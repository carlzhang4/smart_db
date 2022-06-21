package smart_db

import chisel3._
import chisel3.util._
import chisel3.experimental.ChiselEnum

object LockOP extends ChiselEnum{
	val shared		= Value
	val exclusive	= Value
	val reserve1	= Value
	val reserve2	= Value//note that each state must be declared, otherwise the cast will warn you
	// val load  = Value(0x03.U)
    // val imm   = Value(0x13.U)
	//.all: returns the enum values within the enumeration
	//.getWidth: returns the width of the hardware type
}

object TODO{
	def W10 = 10.W
	def W64 = 64.W
	def W33 = 33.W
	def OCW = 16.W
}

class Config(NUM_TABLES:Int, KEY_BITS:Int, TB_ADDR_BITS:Int, ADDR_WIDTH:Int, DATA_WIDTH:Int, BUCKET_SIZE:Int){
	val key_bits 	= KEY_BITS
	val addr_width 	= ADDR_WIDTH
	val data_width 	= DATA_WIDTH
	val num_tables	= NUM_TABLES
	val bucket_size = BUCKET_SIZE
}

class Request(config:Config) extends Bundle{
	val key				= UInt(config.key_bits.W)
	val tb_idx			= UInt(log2Up(config.num_tables).W)
	val bucket_idx_raw	= UInt(TODO.W33)
	val bucket_idx		= UInt(TODO.W33)
	val lock			= LockOP()
	val is_unlock		= UInt(1.W)
	val id 				= UInt(32.W)
	val len				= UInt(4.W)
	val last			= UInt(1.W)

	val slot_idx		= UInt(log2Up(config.bucket_size).W)
	val shared_count	= UInt(8.W)
	val host_addr		= UInt(TODO.W64)
	val success			= UInt(1.W)
	val hit				= UInt(1.W)

	def print_csv()={
		printf(p"id:${id}")

		when(is_unlock===0.U && lock===LockOP.shared){
			printf(p", type:0")
		}.elsewhen(is_unlock===0.U && lock===LockOP.exclusive){
			printf(p", type:1")
		}.elsewhen(is_unlock===1.U && lock===LockOP.shared){
			printf(p", type:2")
		}.elsewhen(is_unlock===1.U && lock===LockOP.exclusive){
			printf(p", type:3")
		}

		when(success === 1.U){
			printf(p", result:0");//success
		}.elsewhen(hit === 0.U || is_unlock === 1.U){
			printf(p", result:2");//error
		}.otherwise{
			printf(p", result:1");//fail
		}

		printf(p", tb_idx:${tb_idx}")
		printf(p", bucket_idx:${bucket_idx}")
		printf(p", key:${key}")

		printf(p", slot_idx:${slot_idx}")
		printf(p", shared_count:${shared_count}")
		
		printf(p"\n")
	}

}

// class Result(config:Config) extends Bundle{
// 	val req 			= new Request(config)
// 	val host_addr		= UInt(TODO.W64)
// 	val slot_idx		= UInt(log2Up(config.bucket_size).W)
// 	val success			= UInt(1.W)
// 	val hit				= UInt(1.W)
// 	val shared_count	= UInt(8.W)
// 	val has_next		= UInt(1.W)
// 	val next_idx		= UInt(TODO.OCW)
// }

class RawData(config:Config) extends Bundle{
	val req 			= new Request(config)
	val bucket			= new Bucket(config)
}

class Slot(config:Config) extends Bundle{
	val host_addr			= UInt(64.W)
	val key					= UInt(config.key_bits.W)
	val valid				= UInt(1.W)

	override def toPrintable: Printable = {
		p"\nSlot:{" +
		p"  host_addr:0x${Hexadecimal(host_addr)} " +
		p"  key:$key " +
		p"  valid:$valid }" +
		p""
	}
}

object GlobalConfig{
	def LOCK_BITS = 8
}
class Bucket(config:Config) extends Bundle{
	val slots				= Vec(6,new Slot(config))
	val has_next			= UInt(1.W)
	val next_idx			= UInt(TODO.W33)
	val tb_idx 				= UInt(5.W)
	val idx 				= UInt(32.W)
	val exclusive_state 	= Vec(config.bucket_size,UInt(GlobalConfig.LOCK_BITS.W))
	val shared_count 		= Vec(config.bucket_size,UInt(GlobalConfig.LOCK_BITS.W)) //LSB

	override def toPrintable: Printable = {
		p"\nBucket $tb_idx-$idx:\n" +
		p"  exclusive_state:${exclusive_state} " +
		p"  shared_count:${shared_count} " +
		p"  slots:$slots\n" +
		p"  has_next: $has_next " +
		p"  next_idx:$next_idx " +
		p"\n"
	}
}

