package smart_db
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import firrtl.options.TargetDirAnnotation

object elaborate extends App {
	println("Generating a %s class".format(args(0)))
	val stage	= new chisel3.stage.ChiselStage
	val arr		= Array("-X", "sverilog", "--full-stacktrace")
	val dir 	= TargetDirAnnotation("Verilog")

	val BUCKET_SIZE = 6
	val config = new Config(4, 60, 10, 33, 256 ,BUCKET_SIZE)

	args(0) match{
		case "SMART_DB_TOP" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => new SMART_DB_TOP()),dir))
		case "CUCKOO" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => new CUCKOO(4,60,10,33,256)),dir))
		case "TestRouter" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => new TestRouter()),dir))
		case "TestArbiter" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => new TestArbiter()),dir))
		case "BlockHandler" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => BlockHandler.top(config, 1024)),dir))
		case "TestConverter" => stage.execute(arr,Seq(ChiselGeneratorAnnotation(() => new TestConverter()),dir))
		case _ => println("Module match failed!")
	}
}

