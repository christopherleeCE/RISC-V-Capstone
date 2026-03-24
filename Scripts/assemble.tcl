package require ::quartus::project
package require ::quartus::flow

# Help flag
if { $argc == 0 || [lsearch $argv "-help"] != -1 || [lsearch $argv "-h"] != -1 } {
    puts "Usage:"
    puts "  quartus_sh -t build.tcl <project_path>"
    puts ""
    puts "Arguments:"
    puts "  <project_path>   Path to Quartus project (no trailing slash)"
    puts ""
    puts "Options:"
    puts "  -h, -help        Show this message"
    exit 0
}

#get arg
set project_name [lindex $argv 0]


project_open $project_name


execute_module -tool cdb -args "--update_mif"


execute_module -tool asm


project_close
