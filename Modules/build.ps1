#invoking this powershell script with ./build.ps1 will run mkurom and then will run vlog (questa)
#this does work if we are cd'd into the modules folder, one thing to note is that it will genreate
#some object files in a "work" folder in the modules directory, i (chris) will figure out more usage
#of vlog in the vscode/powershell commandline, so you dont even need to boot up questa
perl .\mkurom.pl
vlog *.sv