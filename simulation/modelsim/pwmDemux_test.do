restart -f

force pwmdemux_sel 0
force pwmDemuxir_input 100000000000
run 100

force pwmdemux_sel 1
force pwmDemuxir_input 100000011100
run 100
