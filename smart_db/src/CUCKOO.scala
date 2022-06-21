package smart_db

import common.connection._
import common.axi._
import common.storage._
import chisel3._
import chisel3.util._



class CUCKOO(NUM_TABLES:Int, KEY_BITS:Int, TB_ADDR_BITS:Int, ADDR_WIDTH:Int, DATA_WIDTH:Int) extends Module{

	val BUCKET_SIZE = 6
	def TODO_1024	= 1024

	val config = new Config(NUM_TABLES,KEY_BITS,TB_ADDR_BITS,ADDR_WIDTH,DATA_WIDTH,BUCKET_SIZE)

	val io = IO(new Bundle{
		val req				= Flipped(Decoupled(new Request(config)))
		val res_failed		= Vec(NUM_TABLES,Decoupled(new Request(config)))
		val res_error		= Vec(NUM_TABLES,Decoupled(new Request(config)))
		val res_success		= Vec(NUM_TABLES,Decoupled(new Request(config)))
		val axi_hbm 		= Vec(NUM_TABLES,(new AXI(ADDR_WIDTH, DATA_WIDTH, 6, 0, 4)))

		val inits_init_en	= Vec(NUM_TABLES, Input(UInt(1.W)))
		val inits_addr_a	= Vec(NUM_TABLES, Input(UInt(log2Up(TODO_1024).W)))
		val inits_wr_en_a	= Vec(NUM_TABLES, Input(UInt(1.W)))
		val inits_data_in_a	= Vec(NUM_TABLES, Input(UInt(1024.W)))

	})

	def TODO_16	= 16
	def BLOCK_REQ = 0

	// val fifo_hbm_w		= XQueue(NUM_TABLES)(new AXI_DATA_W(ADDR_WIDTH,DATA_WIDTH,6,0), TODO_16)
	// val fifo_hbm_aw 	= XQueue(NUM_TABLES)(new AXI_ADDR(ADDR_WIDTH,DATA_WIDTH,6,0,4),TODO_16)

	val lock_handlers 				= LockHandler(NUM_TABLES)(config)
	val router_req 					= SimpleRouter(new Request(config),NUM_TABLES)
	

	if(BLOCK_REQ == 1){
		val done_fail		=  io.res_failed.map(_.fire()).reduce(_ | _)
		val done_error		=  io.res_error.map(_.fire()).reduce(_ | _)
		val done_success	=  io.res_success.map(_.fire()).reduce(_ | _)

		val done = done_error | done_fail | done_success

		val is_busy			= RegInit(0.U(1.W))

		val valid = Wire(UInt(1.W))
		val ready = Wire(UInt(1.W))

		val block_req					= XQueue(new Request(config), TODO_16)
		block_req.io.out 				<> router_req.io.in
		router_req.io.idx				:= block_req.io.out.bits.tb_idx

		when(done){
			is_busy			:= 0.U
		}
		when(block_req.io.in.fire()){
			is_busy			:= 1.U
		}

		valid 							:= io.req.valid & ~is_busy
		ready 							:= block_req.io.in.ready & ~is_busy
		
		block_req.io.in.bits			:= io.req.bits
		block_req.io.in.valid 			:= valid
		io.req.ready 					:= ready

	}else{
		router_req.io.in				<> io.req
		router_req.io.idx				:= io.req.bits.tb_idx
	}

	for(i<-0 until NUM_TABLES){
		lock_handlers(i).io.req					<> router_req.io.out(i)
		lock_handlers(i).io.res_failed			<> io.res_failed(i)
		lock_handlers(i).io.res_error			<> io.res_error(i)
		lock_handlers(i).io.res_success			<> io.res_success(i)
		lock_handlers(i).io.axi_hbm				<> io.axi_hbm(i)
		lock_handlers(i).io.inits_init_en		<> io.inits_init_en(i)
		lock_handlers(i).io.inits_addr_a		<> io.inits_addr_a(i)
		lock_handlers(i).io.inits_wr_en_a		<> io.inits_wr_en_a(i)
		lock_handlers(i).io.inits_data_in_a		<> io.inits_data_in_a(i)
	}

	for(i<-0 until NUM_TABLES){
		when(io.res_failed(i).fire()){
			// printRes(io.res_failed(i).bits)
			io.res_failed(i).bits.print_csv()
		}
		when(io.res_success(i).fire()){
			// printRes(io.res_success(i).bits)
			io.res_success(i).bits.print_csv()
		}
		when(io.res_error(i).fire()){
			// printRes(io.res_error(i).bits)
			io.res_error(i).bits.print_csv()
		}
	}
	
	def printRes(req:Request)={
		printf(p"ID:${req.id} ,")
		when(req.is_unlock===0.U && req.lock===LockOP.shared){
			printf(p"Lock S   ")
		}.elsewhen(req.is_unlock===0.U && req.lock===LockOP.exclusive){
			printf(p"Lock X   ")
		}.elsewhen(req.is_unlock===1.U && req.lock===LockOP.shared){
			printf(p"Unlock S ")
		}.elsewhen(req.is_unlock===1.U && req.lock===LockOP.exclusive){
			printf(p"Unlock X ")
		}

		when(req.success === 1.U){
			printf(p" : Success");
		}.elsewhen(req.hit === 0.U || req.is_unlock === 1.U){
			printf(p" : Error  ");
		}.otherwise{
			printf(p" : Fail   ");
		}

		printf(p", table:${req.tb_idx}")
		printf(p", bucket:${req.bucket_idx}")
		printf(p", key:${req.key}")

		when(req.hit === 1.U){
			printf(p", slot_idx:${req.slot_idx}")
		}

		when(req.lock === LockOP.shared && req.success === 1.U){
			printf(p", shared_count:${req.shared_count}")
		}
		printf(p"\n")
	}
	
}


