package smart_db

import common.storage._
import common.connection._
import common._
import chisel3._
import chisel3.util._

object BlockHandler{
	def apply(num:Int)(config:Config, depth:Int) = {
		Seq.fill(num)(Module(new BlockHandler(config, depth)))
	}
	def apply(config:Config, depth:Int) = {
		Module(new BlockHandler(config, depth))
	}
	def top(config:Config, depth:Int) = {
		new BlockHandler(config, depth)
	}

	class BlockHandler(config:Config, depth:Int) extends Module{
		val io = IO(new Bundle{
			val req					= Flipped(Decoupled(new Request(config)))
			val req_out				= Decoupled(new Request(config))
			val res_success			= Flipped(Decoupled(new Request(config)))
			val res_success_out		= Decoupled(new Request(config))
			val res_failed			= Flipped(Decoupled(new Request(config)))
			val res_failed_out		= Decoupled(new Request(config))
			val res_error			= Flipped(Decoupled(new Request(config)))
			val res_error_out		= Decoupled(new Request(config))
		})

		def TODO_16 = 16
		def TODO_512 = 512
		def width_bits_minus_1 = Math.log2(depth) - 1

		val table = RegInit(VecInit(Seq.fill(depth)(0.U(1.W))))
		
		val q_wait	= XQueue(new Request(config), TODO_512)
		val q_work	= XQueue(new Request(config), TODO_512)
		val q_grant	= XQueue(new Request(config), TODO_512)
		val abiter 	= XArbiter(new Request(config), 2)
		abiter.io.in(0)	<> io.req
		abiter.io.in(1)	<> q_wait.io.out
		abiter.io.out	<> q_work.io.in

		val is_success = Wire(UInt(1.W))

		val router	= SimpleRouter(new Request(config), 2)
		router.io.in 		<> q_work.io.out
		router.io.out(0)	<> q_wait.io.in
		router.io.out(1)	<> q_grant.io.in
		router.io.idx		:= is_success

		val addr = q_work.io.out.bits.bucket_idx_raw(width_bits_minus_1,0)
		
		when(table(addr) === 0.U){
			is_success		:= 1.U
		}.otherwise{
			is_success		:= 0.U
		}

		when(table(addr) === 0.U && q_work.io.out.fire()){
			table(addr)	:= 1.U
		}

		q_grant.io.out	<> io.req_out

		//release
		io.res_success	<> io.res_success_out
		io.res_failed	<> io.res_failed_out
		io.res_error	<> io.res_error_out

		val success_addr 	= io.res_success.bits.bucket_idx_raw(width_bits_minus_1,0)
		val failed_addr 	= io.res_failed.bits.bucket_idx_raw(width_bits_minus_1,0)
		val error_addr 		= io.res_error.bits.bucket_idx_raw(width_bits_minus_1,0)
		when(io.res_success.fire()){
			table(success_addr)	:= 0.U
		}
		when(io.res_failed.fire()){
			table(failed_addr)	:= 0.U
		}
		when(io.res_error.fire()){
			table(error_addr)	:= 0.U
		}

		// Util.report(io.req_release.fire()&&table(release_addr)===0.U, "Releasing an empty object")
		

	}
}