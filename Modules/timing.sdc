#its important to include this in the quartus project, if its not there
#quartus thinks that we are trying to run a 1ghz clk, and ends up
#hyperoptimizing the routing to accomidate that, compilation ends up
#being 15-20 minutes, if you specify a more reasonable clk period
#compilation is only about 2 minutes

create_clock -name global_clk -period 20 [get_ports global_clk]

create_generated_clock \
    -name divided_clk \
    -source [get_ports global_clk] \
    -divide_by 10 \
    [get_pins {top_fpga|my_clock|clk_out}]