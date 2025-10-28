- the mkurom.pl is used my typing "perl mkurom.pl" in the cmd line, perl needs to be installed here: https://www.perl.org/get.html get strawberry perl for windows
- do not touch the microcode_legacy, or mkurom_legacy plz
- feel free to edit and experiment with microcode.sh all you want, there isnt anything really important in there, but for now maybe dont remove the "UD_fault:" label.
- I built the riscv_cpu.sv based on the block diagram pinned in the discord gc
- right now the PC is set to inc by 1, but that might get changed to 4
- as of right now EVERYTHING compiles in questia with no errors, however NO VALIDATION has been done on ANYTHING
- see notes and guides for questia installation instructions
- for use of these files in questia i recomond something along these lines

    * Documents
        > Quartus
            > Projects
                > Project_1_Folder
                    > work #this is used by questia
                    > git_home_folder
                        > Notes and Guides
                        > project files #SV files in here
                        > Verification

- you have to in questia "add files to project", and you just navigate to the "project files" folder and select all of the verilog related files, (.sv, .inc, etc)
- then you can compile all and check for errors, again no testbench has been created yet