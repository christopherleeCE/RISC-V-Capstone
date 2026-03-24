package require ::quartus::project

set project_name "new_capstone"
set sof_file "output_files/new_capstone.sof"

# -c: Cable name (e.g., "USB-Blaster [USB-0]")
# -m: Mode (JTAG)
# -o: Operation (p for program; path to SOF; @1 for device index)
qexec "quartus_pgm --cable=\"USB-Blaster \[USB-0\]\" --mode=JTAG --operation=\"p;$sof_file@1\""
