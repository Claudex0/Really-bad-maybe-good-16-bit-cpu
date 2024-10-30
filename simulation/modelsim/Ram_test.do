restart -f
force CLK 1 0, 0 50 -r 100

force addr 0000
force data 0000000000000000
force we 0
run 200

force addr 1000
force data 0000010010100001
force we 1
run 200

force addr 1001
force data 0000010010100001
force we 0
run 100

force addr 1010
force data 0000010010100001
force we 0
run 100

force addr 1011
force data 1111010010100001
force we 0
run 100



