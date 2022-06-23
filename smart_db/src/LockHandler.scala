package smart_db
import common._
import common.storage._
import common.connection._
import common.axi._
import chisel3._
import chisel3.util._

object LockHandler{
	def apply(num:Int)(config:Config) = {
		Seq.fill(num)(Module(new LockHandler(config)))
	}
	def apply(config:Config) = {
		Module(new LockHandler(config))
	}

	class LockHandler(config:Config) extends Module{
		def TODO_1024	= 1024
		def TODO_16	= 16
		def TODO_SHIFT_IDX2ADDR = 7 //32 bytes(5) + 4 words(2)
		val io = IO(new Bundle{
			val req				= Flipped(Decoupled(new Request(config)))
			val res_failed		= Decoupled(new Request(config))
			val res_error		= Decoupled(new Request(config))
			val res_success		= Decoupled(new Request(config))
			val axi_hbm 		= new AXI(config.addr_width, config.data_width, 6, 0, 4)

			val inits_init_en	= Input(UInt(1.W))
			val inits_addr_a	= Input(UInt(log2Up(TODO_1024).W))
			val inits_wr_en_a	= Input(UInt(1.W))
			val inits_data_in_a	= Input(UInt(1024.W))
		})

		val block_handler					= BlockHandler(config,TODO_1024)
		block_handler.io.req				<> io.req
		block_handler.io.res_error_out		<> io.res_error
		block_handler.io.res_failed_out		<> io.res_failed
		block_handler.io.res_success_out	<> io.res_success

		val q_req				= XQueue(new Request(config),TODO_16)
		q_req.io.in 			<> block_handler.io.req_out
		
		when(q_req.io.in.fire()){
			printf(p"seq:0, ")
			q_req.io.in.bits.print_csv()
		}

		val router_req			= SimpleRouter(new Request(config), 2)

		val q_rd_0				= XQueue(new Request(config),TODO_16)
		val q_wr_0				= XQueue(new Request(config),TODO_16)

		val abiter_rd 	= XArbiter(new Request(config), 2)
		val abiter_wr 	= XArbiter(new Request(config), 2)

		q_req.io.out			<> router_req.io.in
		router_req.io.idx		:= (q_req.io.out.bits.is_unlock === 1.U) && (q_req.io.out.bits.lock === LockOP.exclusive)

		router_req.io.out(0)	<> q_rd_0.io.in
		router_req.io.out(1)	<> q_wr_0.io.in

		abiter_rd.io.in(0)		<> q_rd_0.io.out 
		abiter_wr.io.in(0)		<> q_wr_0.io.out 

		val q_rd		= XQueue(new Request(config),TODO_16)
		val q_wr		= XQueue(new Request(config),TODO_16)

		q_rd.io.in		<> abiter_rd.io.out
		q_wr.io.in		<> abiter_wr.io.out

		val memory					= CompositeMemory(config)
		
		memory.io.req_wr			<> q_wr.io.out
		memory.io.req_rd			<> q_rd.io.out
		memory.io.axi_hbm			<> io.axi_hbm

		memory.io.init.init_en		<> io.inits_init_en
		memory.io.init.addr_a		<> io.inits_addr_a
		memory.io.init.wr_en_a		<> io.inits_wr_en_a
		memory.io.init.data_in_a	<> io.inits_data_in_a.asTypeOf(memory.io.init.data_in_a)

		//parse success
		val q_res_success						= XQueue(new Request(config), TODO_16)

		q_res_success.io.in						<> memory.io.wr_req_done
		q_res_success.io.in.bits.success		:= 1.U

		q_res_success.io.out					<> block_handler.io.res_success

		//parse rd
		val q_res_fail							= XQueue(new Request(config), TODO_16)
		val q_res_error							= XQueue(new Request(config), TODO_16)

		val q_mid_rd_next 						= XQueue(new Request(config), TODO_16)
		val q_mid_wr 							= XQueue(new Request(config), TODO_16)

		val q_raw_data							= XQueue(new RawData(config), TODO_16)
		q_raw_data.io.in						<> memory.io.raw_data
		val router_raw_data						= SimpleRouter(new Request(config), 4)
		val (res,idx)							= parse_rd(q_raw_data.io.out.bits)

		router_raw_data.io.idx 					:= idx
		router_raw_data.io.in.valid 			:= q_raw_data.io.out.valid
		q_raw_data.io.out.ready					:= router_raw_data.io.in.ready
		router_raw_data.io.in.bits 				:= res

		router_raw_data.io.out(0) 				<> q_mid_wr.io.in
		router_raw_data.io.out(1) 				<> q_res_fail.io.in
		router_raw_data.io.out(2) 				<> q_mid_rd_next.io.in
		router_raw_data.io.out(3) 				<> q_res_error.io.in

		q_mid_wr.io.out 						<> abiter_wr.io.in(1)
		q_res_fail.io.out 						<> block_handler.io.res_failed
		q_mid_rd_next.io.out 					<> abiter_rd.io.in(1)
		q_res_error.io.out 						<> block_handler.io.res_error


		def parse_rd(raw_data:RawData)={
			val req 							= raw_data.req
			val is_shared 						= req.lock===LockOP.shared
			val is_unlock 						= req.is_unlock===1.U

			val bucket 							= raw_data.bucket
			val max_share_count					= Math.pow2(GlobalConfig.LOCK_BITS) - 1

			val res 							= 0.U.asTypeOf(new Request(config))
			
			res.key 						:= req.key
			res.tb_idx 						:= req.tb_idx
			res.bucket_idx_raw				:= req.bucket_idx_raw
			res.bucket_idx 					:= req.bucket_idx
			res.lock 						:= req.lock
			res.is_unlock 					:= req.is_unlock
			res.id 							:= req.id
			res.len 						:= req.len
			res.last 						:= req.last

			res.is_unlock 					:= req.is_unlock
			for(i <- 0 until bucket.slots.size){
				val slot = bucket.slots(i)
				when(slot.valid === 1.U && slot.key === req.key){
					res.host_addr			:= slot.host_addr
					res.hit					:= 1.U
					res.slot_idx			:= i.U
					res.shared_count		:= bucket.shared_count(i)
					when(is_unlock){//only share comes here, exclusive goes to wr directly
						when(bucket.exclusive_state(i)===0.U && bucket.shared_count(i)>0.U){
							res.success			:= 1.U
						}
					}.otherwise{
						when(is_shared){//lock S
							when(bucket.exclusive_state(i)===0.U && bucket.shared_count(i)<max_share_count.U){
								res.success	:= 1.U
							}.otherwise{
								res.success	:= 0.U
							}
						}.otherwise{//lock X
							when(bucket.exclusive_state(i)===0.U && bucket.shared_count(i)===0.U){
								res.success	:= 1.U
							}.otherwise{
								res.success	:= 0.U
							}
						}
					}
				}
			}

			val idx 						= Wire(UInt(2.W))
			when(res.hit === 1.U){
				when(res.success === 1.U){
					idx						:= 0.U //success pre, go to wr
				}.otherwise{
					idx 					:= 1.U //fail
				}
			}.otherwise{
				when(bucket.has_next===1.U){
					idx						:= 2.U //Read next
					res.bucket_idx			:= bucket.next_idx
				}.otherwise{
					idx						:= 3.U //error
				}
			}
			(res,idx) //return
		}

	}
}
