restart -f

force alu_sel 0000
force aluMux0_input 100000000000
force aluMux1_input 000000000000
run 100

force alu_sel 0001
force aluMux0_input 111111110000
force aluMux1_input 000000011111
run 100