restart -f
force CLK 1 0, 0 50 -r 100

force nrst 1
force co 0
force addr 0000
force data 0000000000000000
run 100

force nrst 0
force co 0
force addr 0001
force data 0000000000000000
run 500

force nrst 0
force co 0
force addr 0010
force data 0000000000000000
run 500

force nrst 0
force co 0
force addr 0011
force data 0000000000000000
run 500

force nrst 0
force co 0
force addr 0100
force data 0000000000000000
run 500


