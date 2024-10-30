restart -f
force CLK 1 0, 0 50 -r 100

force nrst 1
force d_in 000000000000
force pwm_on 0
run 100

force nrst 0
force d_in 100000011111
force pwm_on 1
run 100

force nrst 0
force d_in 100000011111
force pwm_on 0
run 3100

force nrst 0
force d_in 100000011111
force pwm_on 1
run 100

force nrst 0
force d_in 100000011111
force pwm_on 0
run 100





