- all of these scripts, except the clear local should be called from inside the "Modules" directory
- calling these would look like this: 

C:\Users\Chris\Git_Folder\Modules >> ../Scripts/my_script.sh
                                            OR
C:\Users\Chris\Git_Folder\Modules >> ../Scripts/my_script.ps1

- *.sh scripts need to be ran from the wsl terminal, and files  like *.ps1 need to be ran from the powershell or windows cmd terminal

- if you run into an error like "/usr/bin/env: ‘bash\r’: No such file or directory" while trying to run a bash script in the wsl terminal do this

    in wsl (not windoes cmd or powershell) run the following...

>> sudo apt update                      #this updates the package manager, if its not up to date its possible the next command fails
>> supo apt install dos2unix            #installs the program from the package manager
>> dos2unix ../Scripts/my_script.sh     #run the program on the script that gave you the error

The cause of the issue is due to windows vs linux compatability.
Windows expects line endings in its files one way, while linux expects them in another way.
If the script is in the windows format (because it was edited on a windows machine) then linux
cant run the bash script. The program "dos2unix" just converts the windows style format to the linux one.
This isn't something that you should have to run very often.

If you run into any other errors, just message me (Chris) on discord.