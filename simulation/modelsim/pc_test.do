restart -f
force CLK 1 0, 0 50 -r 100

force pc_clr 1
force pc_ld 0
force pc_cnt 0
force data 0000
run 100

force pc_clr 0
force pc_ld 0
force pc_cnt 1
force data 0100
run 100

force pc_clr 0
force pc_ld 0
force pc_cnt 1
force data 1100
run 100

force pc_clr 0
force pc_ld 1
force pc_cnt 0
force data 1100
run 100



