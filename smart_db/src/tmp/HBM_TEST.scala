package smart_db.tmp

import common.axi._
import common._
import chisel3._
import chisel3.util._
import chisel3.experimental.DataMirror._


class HBM_TEST() extends Module{
	val io = IO(new Bundle{
		val axi_hbm				= Vec(32,(new AXI(28, 256, 6, 0, 4)))
		val lite_control		= Input(Vec(512,UInt(32.W)))
		val lite_status			= Output(Vec(512,UInt(32.W)))
		val bridge_control		= Input(Vec(32,UInt(512.W)))
		val bridge_status		= Output(Vec(32,UInt(512.W)))
	})
	for(i<-0 until 32){
		io.axi_hbm(i).init()
	}

	io.lite_status 			:= 0.U.asTypeOf(chiselTypeOf(io.lite_status))
	io.bridge_status 		:= 0.U.asTypeOf(chiselTypeOf(io.bridge_status))

	val ar_addr		= RegInit(0.U(io.axi_hbm(0).ar.bits.addr.getWidth.W))
	val ar_len		= RegInit(0.U(io.axi_hbm(0).ar.bits.len.getWidth.W))
	val ar_start	= RegInit(0.U(1.W))
	val ar_valid	= RegInit(0.U(1.W))

	val aw_addr		= RegInit(io.axi_hbm(0).aw.bits.addr)
	val aw_len		= RegInit(io.axi_hbm(0).aw.bits.len)
	val aw_start	= RegInit(0.U(1.W))
	val aw_valid	= RegInit(0.U(1.W))

	val w_data		= RegInit(io.axi_hbm(0).w.bits.data)
	val w_strb		= RegInit(io.axi_hbm(0).w.bits.strb)
	val w_last		= RegInit(io.axi_hbm(0).w.bits.last)
	val w_start		= RegInit(0.U(1.W))
	val w_valid		= RegInit(0.U(1.W))

	io.axi_hbm(0).ar.bits.addr	:= ar_addr
	io.axi_hbm(0).ar.bits.len	:= ar_len
	io.axi_hbm(0).ar.valid		:= ar_valid

	io.axi_hbm(0).aw.bits.addr	:= aw_addr
	io.axi_hbm(0).aw.bits.len	:= aw_len
	io.axi_hbm(0).aw.valid		:= aw_valid

	io.axi_hbm(0).w.bits.data	:= w_data
	io.axi_hbm(0).w.bits.strb	:= w_strb
	io.axi_hbm(0).w.bits.last	:= w_last
	io.axi_hbm(0).w.valid		:= w_valid

	io.axi_hbm(0).r.ready		:= 1.U

	when(ar_start === 1.U && RegNext(ar_start)===0.U){
		ar_valid	:= 1.U
	}
	when(io.axi_hbm(0).ar.fire()){
		ar_valid	:= 0.U
	}

	when(aw_start === 1.U && RegNext(aw_start)===0.U){
		aw_valid	:= 1.U
	}
	when(io.axi_hbm(0).aw.fire()){
		aw_valid	:= 0.U
	}

	when(w_start === 1.U && RegNext(w_start)===0.U){
		w_valid	:= 1.U
	}
	when(io.axi_hbm(0).w.fire()){
		w_valid	:= 0.U
	}



	class vio_hbm(seq:Seq[Data]) extends BaseVIO(seq)

	val mod_vio = Module(new vio_hbm(Seq(
		ar_addr,
		ar_len
	)))
	mod_vio.connect(clock)


	class ila_test1(seq:Seq[Data]) extends BaseILA(seq)
	class ila_test2(seq:Seq[Data]) extends BaseILA(seq)

	val mod1 = Module(new ila_test1(Seq(
		io.axi_hbm(0).r.bits.data,
		io.axi_hbm(0).r.ready
	)))
	mod1.connect(clock)

	val mod2 = Module(new ila_test2(Seq(
		io.axi_hbm(0).r.bits.data,
		io.axi_hbm(0).r.ready,
		ar_addr
	)))
	mod2.connect(clock)


	

}