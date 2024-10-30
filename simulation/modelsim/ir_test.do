restart -f
force CLK 1 0, 0 50 -r 100

force data 1000000000000000
force ir_ld 1
force ir_clr 1
run 100

force data 1000000000100001
force ir_ld 1
force ir_clr 0
run 100

force data 1010101010101010
force ir_ld 0
force ir_clr 0
run 100




