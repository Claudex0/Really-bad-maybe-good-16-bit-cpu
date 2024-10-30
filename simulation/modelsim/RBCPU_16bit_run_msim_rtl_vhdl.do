transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/decoder.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/cycle_counter.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/instruction_register.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/ram.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/program_counter.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/memMux.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/aluMux0.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/aluMux1.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/accumulator.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/ALU.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/pwmDemux.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/pwm_controller.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/reg_dc_per.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/pwm_counter.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/comparator_dc.vhd}
vcom -93 -work work {C:/Uni/Year4/EBAES/assignments/RBCPU_16bit/comparator_per.vhd}

