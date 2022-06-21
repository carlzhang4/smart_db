package smart_db
import common.storage._
import common.connection._
import common.axi._
import common._
import chisel3._
import chisel3.util._

object CompositeMemory{
	def apply(num:Int)(config:Config) = {
		Seq.fill(num)(Module(new CompositeMemory(config)))
	}
	def apply(config:Config) = {
		Module(new CompositeMemory(config))
	}

	class CompositeMemory(config:Config) extends Module{
		def TODO_1024	= 1024
		def TODO_16	= 16
		def TODO_NUM_WORDS	= 4
		def TODO_SHIFT_IDX2ADDR = 7 //32 bytes(5) + 4 words(2)
		def TODO_HBM_DEPTH = 1024
		
		val io = IO(new Bundle{
			val req_wr				= Flipped(Decoupled(new Request(config)))
			val req_rd				= Flipped(Decoupled(new Request(config)))
			val axi_hbm 			= new AXI(config.addr_width, config.data_width, 6, 0, 4)

			val raw_data 			= Decoupled(new RawData(config))
			val wr_req_done 		= Decoupled(new Request(config))

			val init				= new XRamInitIO(new Bucket(config), TODO_1024)
		})

		io.axi_hbm.init()

		val router_wr				= SimpleRouter(new Request(config), 2)
		val router_rd				= SimpleRouter(new Request(config), 2)

		val idx_wr					= io.req_wr.bits.bucket_idx	>= TODO_HBM_DEPTH.U
		val idx_rd					= io.req_rd.bits.bucket_idx	>= TODO_HBM_DEPTH.U

		router_wr.io.in 			<> io.req_wr
		router_rd.io.in 			<> io.req_rd

		router_wr.io.idx 			<> idx_wr
		router_rd.io.idx 			<> idx_rd
		
		val q_rd_hbm							= XQueue(new Request(config),TODO_16)
		val q_wr_hbm							= XQueue(new Request(config),TODO_16)
		val q_rd_oc								= XQueue(new Request(config),TODO_16)
		val q_wr_oc								= XQueue(new Request(config),TODO_16)

		q_rd_hbm.io.in 							<> router_rd.io.out(0)
		q_wr_hbm.io.in 							<> router_wr.io.out(0)
		q_rd_oc.io.in 							<> router_rd.io.out(1)
		q_wr_oc.io.in 							<> router_wr.io.out(1)

		//onchip memory
		val oc_mem 								= XRam(new Bucket(config), TODO_1024, use_musk=1)
		val q_oc_raw_data						= XQueue(new RawData(config), TODO_16)
		val q_req_done_wr_oc					= XQueue(new Request(config),TODO_16)

		val (bucket_wr_oc, musk_wr_oc)			= parse_wr(q_wr_oc.io.out.bits)


		q_rd_oc.io.out.ready 					:= !(q_oc_raw_data.io.almostfull)
		oc_mem.io.addr_a						:= Mux(io.init.init_en.asBool, io.init.addr_a, q_wr_oc.io.out.bits.bucket_idx-TODO_HBM_DEPTH.U)
		oc_mem.io.wr_en_a						:= Mux(io.init.init_en.asBool, io.init.wr_en_a, q_wr_oc.io.out.fire())
		oc_mem.io.data_in_a						:= Mux(io.init.init_en.asBool, io.init.data_in_a, bucket_wr_oc)
		oc_mem.io.musk_a.get					:= Mux(io.init.init_en.asBool, -1.S(oc_mem.io.musk_a.get.getWidth.W)asTypeOf(oc_mem.io.musk_a.get), musk_wr_oc)

		oc_mem.io.addr_b						:= q_rd_oc.io.out.bits.bucket_idx - TODO_HBM_DEPTH.U

		q_oc_raw_data.io.in.valid				:= ShiftRegister(q_rd_oc.io.out.fire(), 2)
		q_oc_raw_data.io.in.bits.req			:= ShiftRegister(q_rd_oc.io.out.bits, 2)
		q_oc_raw_data.io.in.bits.bucket			:= oc_mem.io.data_out_b


		q_wr_oc.io.out.ready					:= !(q_req_done_wr_oc.io.almostfull)
		q_req_done_wr_oc.io.in.bits 			:= ShiftRegister(q_wr_oc.io.out.bits, 2)
		q_req_done_wr_oc.io.in.valid 			:= ShiftRegister(q_wr_oc.io.out.fire(), 2)


		//rd hbm
		val q_rd_hbm_flight						= XQueue(new Request(config),TODO_16)
		io.axi_hbm.ar.bits.addr 				:= q_rd_hbm.io.out.bits.bucket_idx	<< TODO_SHIFT_IDX2ADDR
		io.axi_hbm.ar.bits.len	 				:= q_rd_hbm.io.out.bits.len
		io.axi_hbm.ar.valid	 					:= q_rd_hbm.io.out.valid
		q_rd_hbm.io.out.ready 					:= io.axi_hbm.ar.ready && q_rd_hbm_flight.io.in.ready
		q_rd_hbm_flight.io.in.bits 				:= q_rd_hbm.io.out.bits
		q_rd_hbm_flight.io.in.valid 			:= q_rd_hbm.io.out.valid

		val q_hbm_raw_data						= XQueue(new RawData(config), TODO_16)
		val hbm_rd_datas 						= Reg(Vec(TODO_NUM_WORDS-1,UInt(256.W)))
		val counter_cur_word					= RegInit(0.U(log2Up(TODO_NUM_WORDS+1).W))
		when(io.axi_hbm.r.fire()){
			counter_cur_word					:= counter_cur_word + 1.U
			hbm_rd_datas(counter_cur_word)		:= io.axi_hbm.r.bits.data
			when(counter_cur_word === (TODO_NUM_WORDS-1).U){
				counter_cur_word				:= 0.U
			}
		}
		val is_last								= io.axi_hbm.r.bits.last.asBool
		io.axi_hbm.r.ready 						:= q_hbm_raw_data.io.in.ready
		q_hbm_raw_data.io.in.valid 				:= io.axi_hbm.r.valid && is_last

		val last_fire 							= is_last && io.axi_hbm.r.fire()
		q_rd_hbm_flight.io.out.ready  			:= last_fire

		q_hbm_raw_data.io.in.bits.req			:= q_rd_hbm_flight.io.out.bits
		q_hbm_raw_data.io.in.bits.bucket		:= Cat(io.axi_hbm.r.bits.data, hbm_rd_datas.asUInt).asTypeOf(new Bucket(config))


		//wr hbm
		val q_hbm_w 							= XQueue(new AXI_DATA_W(config.addr_width, config.data_width, 6, 0), TODO_16)
		val q_hbm_aw							= XQueue(new AXI_ADDR(config.addr_width, config.data_width, 6, 0, 4),TODO_16)
		val q_wr_hbm_flight						= XQueue(new Request(config),TODO_16)
		val q_req_done_wr_hbm					= XQueue(new Request(config),TODO_16)

		val wr_hbm_ready_3 						= q_wr_hbm_flight.io.in.ready && q_hbm_aw.io.in.ready && q_hbm_w.io.in.ready
		val (bucket_wr_hbm, musk_wr_hbm)		= parse_wr(q_wr_hbm.io.out.bits)
		q_hbm_w.io.in.bits						:= 0.U.asTypeOf(q_hbm_w.io.in.bits)
		q_hbm_w.io.in.valid						:= q_wr_hbm.io.out.valid && wr_hbm_ready_3
		q_hbm_w.io.in.bits.data					:= bucket_wr_hbm.asUInt
		q_hbm_w.io.in.bits.strb					:= musk_wr_hbm
		q_hbm_w.io.in.bits.last					:= 1.U

		q_hbm_aw.io.in.bits 					:= 0.U.asTypeOf(q_hbm_aw.io.in.bits)
		q_hbm_aw.io.in.valid 					:= q_wr_hbm.io.out.valid && wr_hbm_ready_3
		q_hbm_aw.io.in.bits.addr 				:= q_wr_hbm.io.out.bits.bucket_idx << TODO_SHIFT_IDX2ADDR
		q_hbm_aw.io.in.bits.len 				:= 0.U

		q_wr_hbm_flight.io.in.valid 			:= q_wr_hbm.io.out.valid && wr_hbm_ready_3
		q_wr_hbm_flight.io.in.bits	 			:= q_wr_hbm.io.out.bits

		q_wr_hbm.io.out.ready 					:= wr_hbm_ready_3

		io.axi_hbm.aw 							<> q_hbm_aw.io.out
		io.axi_hbm.w 							<> q_hbm_w.io.out

		val wr_hbm_valid_2						= q_wr_hbm_flight.io.out.valid && io.axi_hbm.b.valid
		q_wr_hbm_flight.io.out.ready 			:= q_req_done_wr_hbm.io.in.ready && wr_hbm_valid_2
		io.axi_hbm.b.ready 						:= q_req_done_wr_hbm.io.in.ready && wr_hbm_valid_2


		q_req_done_wr_hbm.io.in.valid			:= wr_hbm_valid_2
		q_req_done_wr_hbm.io.in.bits			:= q_wr_hbm_flight.io.out.bits


		val arbiter_wr							= XArbiter(new Request(config), 2)
		arbiter_wr.io.in(0)						<> q_req_done_wr_hbm.io.out
		arbiter_wr.io.in(1)						<> q_req_done_wr_oc.io.out
		arbiter_wr.io.out						<> io.wr_req_done
		
		
		val arbiter_rd							= XArbiter(new RawData(config), 2)
		arbiter_rd.io.in(0)						<> q_hbm_raw_data.io.out
		arbiter_rd.io.in(1)						<> q_oc_raw_data.io.out
		arbiter_rd.io.out						<> io.raw_data

		def parse_wr(req:Request)={
			val bucket 			= 0.U.asTypeOf(new Bucket(config))
			val musk_width 		= 2 * bucket.slots.size
			val musk 			= 0.U.asTypeOf(UInt(musk_width.W))
			val is_shared 		= req.lock===LockOP.shared
			val is_unlock 		= req.is_unlock===1.U
			val musk_vec 		= Wire(Vec(musk_width,UInt(1.W)))
			musk_vec			:= 0.U.asTypeOf(musk_vec)
			musk				:= musk_vec.asUInt

			for(i<-0 until bucket.slots.size){
				when(is_unlock){
					bucket.shared_count(i)		:= req.shared_count - 1.U
					bucket.exclusive_state(i)	:= 0.U
				}.otherwise{
					bucket.shared_count(i)		:= req.shared_count + 1.U
					bucket.exclusive_state(i)	:= 1.U
				}

				when(req.slot_idx === i.U){
					when(is_shared){
						musk_vec(i) 							:= 1.U
					}.otherwise{
						musk_vec(bucket.slots.size + i) 		:= 1.U
					}
				}
			}
			(bucket, musk)
		}

	}
}