do {tb_cuckoo_compile.do}
do {tb_cuckoo_elaborate.do}
vsim -lib xil_defaultlib tb_cuckoo_opt

view wave
view structure
view signals

do {wave_cuckoo.do}
log * -r -depth 5
run 5us