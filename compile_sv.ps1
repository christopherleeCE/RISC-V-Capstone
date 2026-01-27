vsim -c -do "file delete -force sim.log; transcript file sim.log; vlog *.sv; vsim -voptargs=+acc work.top_riscv_cpu_v2_1; run 5us; quit -f"
