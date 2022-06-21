package smart_db

import smart_db.ip_core._
import smart_db.tmp._
import common.axi._
import common._
import chisel3._
import chisel3.util._
import hbm._


class SMART_DB_TOP() extends RawModule{

	val sysClkP			= IO(Input(Clock()))
	val sysClkN			= IO(Input(Clock()))
	val led		        = IO(Output(UInt(1.W)))

	val sysClk = Wire(Clock())
	
	val ibufdsInst = Module(new IBUFDS)
	ibufdsInst.io.I		:= sysClkP
	ibufdsInst.io.IB	:= sysClkN
	sysClk := ibufdsInst.io.O

    val hbmDriver = withClockAndReset(sysClk, false.B) {Module(new HBM_DRIVER)}
	hbmDriver.getTCL("/home/amax/cj/smart_db_pro_alpha/smart_db_pro_alpha.srcs/ip")//edit me
	val hbmClk 	= Wire(Clock())
	val hbmRstn = Wire(UInt(1.W))

	hbmClk 	    := hbmDriver.io.hbm_clk
	hbmRstn     := hbmDriver.io.hbm_rstn
    led         := 0.U

    hbmDriver.io.axi_hbm <> DontCare
    dontTouch(hbmDriver.io.axi_hbm)
	dontTouch(hbmClk)
	dontTouch(hbmRstn)

	def random_table = Array[Array[Array[Long]]](
		Array(Array(12030485860140L,705050132307925521L,336590337597657683L,1043570306297702554L,589530387743670598L,53145238191249266L,814270324059455208L,11833872663418935L,102751804105424204L,1055726704217607884L,810010022352163358L,1005222975880979365L,1077890286617601684L,403450265231815086L,1131526176212492288L,972510145631607744L,561609077523875442L,1110894288126031079L,1001533031304208750L,970966998518845422L,419217578474791818L,734382965129948889L,422594676731082393L,255959641963416539L,93101221952397285L,775567059198698078L,490426584727087204L,759355122649788440L,139477207269654437L,113369193210714321L,590514323427668994L,814342880645510097L,76990535192228530L,192715248998108654L,1058313228609859516L,967752191559599330L,1115124122767548014L,358473851489703292L,539590702787389527L,908676746349907183L,633462376209617966L,414002231859237695L,825959074960712132L,441511090980991285L,236302755819285427L,50811177904031801L,766277930652257290L,1150296916783916722L,960536245156833721L,245599216047047760L,1098672652416238423L,139872952700239230L,4611071331928269L,41315005598023475L,368797767179348583L,488130879398356779L,1002363306630561129L,1047384934554936348L,596022503493699170L,226791963101365772L),Array(907131874767255446L,854923788230422208L,628367879926284655L,868378447805761330L,750958571540551381L,193738166720558462L,490759751014926004L,194785564183770775L,955593648253127453L,380989455526627345L,598464902579579071L,43619142145551363L,655624049451910237L,630744961763466331L,141691946268974021L,109240949815838115L,389007033446376494L,699911409707965992L,695288788937791783L,1001728998082991474L,1044688873039962474L,384500235631105023L,724437962498787211L,922942469411835302L,710576235693245265L,972664070135977616L,1059121212532646856L,444745161320835174L,790803716773467010L,636456455322288824L,676440043486418095L,1100105914505793263L,1086106588749892392L,29349390309679938L,807025690896605806L,100217890002779552L,751617443582796189L,1048465459878783851L,836172931676924127L,692286991587700934L,331321942595530106L,485352917376636112L,675958742446121282L,561331437876940221L,236125210587712622L,947471451063787139L,1351224140627759L,1118080199117369240L,642136871915661374L,1046179392682912508L,1089773088697253568L,145343130003369353L,967795876697623857L,328270262324114174L,597710229042521360L,599294108433982891L,1064021999095552280L,649417343127054485L,298172359752648361L,294877104019617542L)),
		Array(Array(375167185717909144L,209762443152422918L,923889967885369330L,242468893077997448L,395327030783419570L,156239889668069500L,975705845980276544L,1070284412454089205L,1029206327109506143L,86762203906139597L,348962777444820860L,1075805565773418127L,808771784273902216L,903873414883029445L,1080655477254276322L,248550982295946097L,855983929160838520L,485775539196086217L,812499551220660834L,904073575795845020L,662311577916915440L,569122444509884216L,686935139116661603L,596185267248272007L,120308447029101870L,390336610443592087L,1039530783977769932L,1120037665682845032L,708197156649381279L,494311390102612844L,794970609338947015L,617709062741257621L,231189799333028150L,528526207826785052L,803675007309288910L,22982441435313234L,988405578609571662L,409845641014643476L,379285264834063046L,1066873076062151642L,33947696699080345L,1086743734189981361L,671213143137600319L,1069417938293469860L,263141154804985484L,761990533507591680L,250692874792128555L,1147816592246396794L,9748627820889417L,797019895871058685L,836287311488900227L,331773749402933934L,963629271901658410L,1090386804540671567L,430868169843111378L,571710233799667697L,476800584146128453L,159560162025362768L,339243534332620624L,108581946774048834L),Array(1112590356844770791L,77787757821772519L,702762372855242996L,686356576258470361L,439558834333128422L,1069353754942775818L,1047105544667770136L,88352635423989125L,833782298899746067L,45126083981494939L,752706636354121297L,1135948541578284747L,824364651176998437L,188321108672558777L,289422951615762600L,944051357027823509L,193587536533464175L,548675308779324664L,398164041401880082L,652301273069794006L,375984951658338055L,1068153210382509080L,405244602961909844L,179196352383707008L,174745497830948114L,9345381053859013L,921352312778363157L,126831418548605098L,576937387557522186L,190058916863391087L,45556220022595056L,759767011093904452L,384545855697357531L,768545668644849981L,1032869281478139509L,55905345614703281L,340753356011664013L,1003229125793306846L,571027794718588438L,359237271932948667L,255068565652508836L,245584112439988163L,1017635404960020955L,744296089765369599L,27584830286941395L,1109681775358408950L,82540557812003326L,798090486702245019L,100467527952998353L,719025429305133922L,685496177471659332L,315656547024372287L,572648066222332545L,391927943925800175L,190383886013662534L,246084425599363320L,161693148697786184L,566564289042624040L,503023581474134303L,886636389454711456L)),
		Array(Array(1075738944971574847L,930949603873467051L,829342053165311767L,617492733044434796L,127721738927554831L,726155996195964199L,161361575880258711L,810794495071867534L,374699974648642725L,405310210127723921L,124524007011641842L,357969799473467068L,755306675178323787L,409086000231288793L,653615948328169106L,206048811274893294L,263104730479624677L,98080758589606826L,449590193604225917L,1116709183302763202L,971164616751359282L,63672684274711676L,94895246142602295L,338982797926326760L,136802073474197091L,1085992524625424141L,402413444373815521L,581635363150573357L,357571086150835294L,721726546115234287L,683327661995681889L,805156934668436877L,909406343131630922L,506638087474182535L,824766637341531512L,620396418153073457L,479008427413558901L,983093550010287586L,1061875474368370497L,832462585526466592L,244751577907713266L,238906670942445238L,528212332837520533L,148401403204354168L,34441668190355651L,794605960201685995L,1133206383244562718L,35048116778490922L,1031466615306420411L,101903315542649598L,340736663229394836L,900840265683094463L,40490122729713333L,1097112913455274459L,906671821429034338L,661693936381222965L,924854631598633662L,798339164704735871L,248138554820728848L,882923090444995830L),Array(816925275329734081L,1025407294244700516L,843533149418378023L,1026815623463720679L,878653172080067920L,678399326865748182L,772111114229053564L,48663353918739482L,802530923567261703L,53894478467100661L,164760965540198360L,848288015336414898L,939416680001464390L,788826572353284877L,999395008664364606L,626478702796622203L,737535961763611360L,821185473955457942L,930850643356041590L,1081239696717233656L,361867807888436624L,918457591476869734L,1047607681083568176L,810754381283063655L,220875397219266055L,386493286836104618L,7402691670281442L,423280607702605015L,428776991363954739L,779098161418152618L,640217964324358567L,670986799489423073L,153516275290982402L,529692857856872329L,520366654282231625L,85479423823794808L,745995613866406307L,175973614581101065L,756071693386931817L,249344358692009703L,88733339525951843L,719578926145728754L,651990222087861206L,1001188730052249362L,92452722499712894L,262552880797625620L,48274785547023410L,802763331851627350L,426116961175607411L,902141048543522913L,808075377631183962L,645694564901916701L,1151607243285738920L,519713492533087777L,1142354614228334477L,112016392780064577L,552448341449214735L,247538613260900621L,148232735878664762L,864862672536959776L)),
		Array(Array(976455895876437584L,747816707723492238L,580280052252632904L,1056964456953203498L,118092608492373595L,734243100531149280L,365890145640748305L,966558132552198125L,557091892086305085L,659276328428629318L,766509196448549713L,692882444801429972L,1138715637077592780L,461355753208956776L,169123534967446078L,627462077974279533L,304494154575755937L,301769421333453546L,884950566621072628L,900315775585108986L,566011704904007683L,922541116769885606L,228720289777103248L,1073087751885913224L,575306900234254974L,737529431112530420L,993810962662366329L,580094844619492236L,598751280542632915L,1066204398379356912L,448141153581864022L,483764145902620375L,925795036767110775L,587152071074366783L,529506920062148881L,447333236232683180L,191216961724471895L,74859116219690831L,579253213133010368L,1023753091702681003L,862253727889048664L,638811082543316369L,791042960658784725L,356476168053687564L,573938646148425484L,113524840037389120L,870352177646726513L,649559789061769015L,450474786509802154L,549598726953281387L,906072141868345478L,711827133484831372L,623786345777964324L,683836354832986480L,1150325234168107377L,201412403336092979L,1022730700126043997L,893568114018643296L,29078242658195644L,299265937788471056L),Array(804081977900458719L,1106489135245819239L,1014398098286304484L,988479058635275361L,822227017240820420L,497184148573135831L,680024340124678611L,425301312703768562L,180221333886378396L,511786950729989631L,823887443336599713L,1019018176376143365L,917299937467056347L,379655029397454853L,301570381433420945L,926034456750238791L,1032476892643335050L,1025866273815904931L,61836095942004L,966537400258348921L,882901050302832595L,540170747444137420L,570061632026478113L,886104808199320779L,1144418085222958682L,680413831936060300L,141118932638727873L,913358495175531295L,1062119846565073821L,875205619673574049L,667930164856880959L,312300778076435156L,418806974255963838L,375545254795521233L,733183814319291634L,334208621381959421L,77466014267619285L,985938553750562279L,210743928500101288L,771463965575280509L,776391160364641446L,182003690523913361L,1028259142176046738L,594457722122712276L,373548619356214235L,1119573699537537043L,309316045032023882L,34674357801734495L,288966516872427580L,1105581441316301090L,893082676827767055L,241582073179677766L,259960001852069735L,1032020782177677761L,890612308258148125L,672138500534836350L,433836044745130316L,261268831522647234L,112500109796169958L,187881280810231095L))
	)
	
}