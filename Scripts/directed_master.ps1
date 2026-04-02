#vibe-coded garbage :)

param(
    [Parameter(Position = 0)]
    [string]$program_file_name = '',
    [string]$directory = "full_isa",
    [switch]$no_run,
    [switch]$help,
    [switch]$compile,

    [switch]$golden_calc,
    [switch]$dut_dump,
    [switch]$golden_history,
    [switch]$verify_output,
    [switch]$no_verify,
    [switch]$v,
    [switch]$wave_dump
)

$startTime = Get-Date
$timer = [System.Diagnostics.Stopwatch]::StartNew()
$diffAnyGlobalErrors = $false

$ErrorActionPreference = "Stop"
$runTime = 5000000

if($help){
    Write-Output("
    Usage: GITHOME/Modules >> ../Scripts/direct_master.ps1 myProgram.s -optional_flags

    myProgram.s must be a program in the Programs/directed/<SUBDIRECTORY>/ directory. The script will run validation using that program
    if you do not give it a myProgram.s when calling the script, it will run vaidation on all of the programs in the
    Programs/directed/<SUBDIRECTORY>/ directory. Regardless a _master.log summary file is created. The individual results, and the 
    _master.log will be moved into the Logs/raw_directed/ directory, and will get cleared whenver this script run

    -help:      Brings up this dialog
    -v:         verbose .log output
    -no_run:    if you give a file name, followed by no run, it will only load instruction_memory.txt
                and data_memory.txt, will not run simulation, use this to get an objdump of the program
    -compile:   use this flag if you want it to use a c file instead of an s file, if in c mode it will
                compare the result with that same c file ran natively on x86, only comparasion made is
                the return value of main(), just like in asm mode, if you dont give it a file name it
                will grab every file and run them through the simuation (except instead of all the .s
                files it will run all the .c files.)
    -directory: lets you specify the <SUBDIRECTORY>, usage example
                ..\Scripts\directed_master.ps1 retep.c -directory full_isa -compile                                            
                'full_isa' being the <SUBDIRECTORY>, if none is given the default is 'full_isa'

    simulate.ps1 flags:
    -golden_calc:       shows the debug info for the golden values calculated on every posedge
    -dut_dump:          shows a dump of all dut on every negedge
    -golden_history:    shows dump of golden_history[] on every negedge
    -verify_output:     shows debug info of verify_row()'s
    -no_verify:         disable verification, script will verify if this argument is NOT given
    -v:                 enables -golden_calc -dut_dump -golden_history -verify_output -continue
    -wave_dump:         include if you need a wave dump, slows down simulation   
    ")

    exit(0)
}

$simScriptArgs = @{
    continue = $true;
    no_compile = $false
}

if ($golden_calc)       { $simScriptArgs.golden_calc = $true }
if ($dut_dump)          { $simScriptArgs.dut_dump = $true }
if ($golden_history)    { $simScriptArgs.golden_history = $true }
if ($verify_output)     { $simScriptArgs.verify_output = $true }
if ($no_verify)         { $simScriptArgs.no_verify = $true }
if ($v)                 { $simScriptArgs.v = $true }
if ($wave_dump)         { $simScriptArgs.wave_dump = $true }

#check if we are in /modules/
$currentDirName = Split-Path -Leaf (Get-Location)
if ($currentDirName -ne "Modules") {
    Write-Host "`nError: Script must be run from the Modules folder. Current folder is $currentDirName`n" -ForegroundColor Red
    exit 1
}

#check if specified directory in arg exist
$targetPath = "../Programs/directed/$directory"
if (-not (Test-Path $targetPath)) {
    Write-Host "`nError: Directory '$directory' does not exist in ../Programs/directed/`n" -ForegroundColor Red
    exit 1
}

#test if specified file exist in directory ('' for progfilename doesn trigger this if block)
if (-not (Test-Path "../Programs/directed/$directory/$program_file_name")) {
    Write-Host "`nError: File <$program_file_name> does not exist in ../Programs/directed/$directory/`n" -ForegroundColor Red
    exit(1)
}

#check that file extension matches with operating mode (.c or .s)
if($program_file_name -ne ''){
    $fileExtension = (Get-Item "../Programs/directed/$directory/$program_file_name").Extension
    if($program_file_name -ne ''){
        if($compile -and ($fileExtension -ne ".c")){
            Write-Host "`nError: File <$program_file_name> is not a *.c file`n" -ForegroundColor Red

        }elseif((-not $compile) -and ($fileExtension -ne ".s")){
            Write-Host "`nError: File <$program_file_name> is not a *.s file`n" -ForegroundColor Red

        }
    }
}
#convering all .sh to linux line endings
wsl bash -c "dos2unix ../Scripts/*.sh"

$logFolder = "..\Logs\raw_directed"
$masterLogName = "_master.log"
$masterLog = Join-Path $logFolder $masterLogName

#clear master log if it exists
if (Test-Path $masterLog) {
    Remove-Item $masterLog
}

#create the folder if it doesn't exist
if (-not (Test-Path $logFolder)) {
    New-Item -ItemType Directory -Path $logFolder | Out-Null
} else {
    #Remove all files in the folder
    Get-ChildItem $logFolder -File | Remove-Item -Force
}

Write-Host "Running from Modules folder, continuing..."

#copmile our lib automatically if in compile mode
if($compile){

    $LibDir = "../Programs/directed/lib"

    $libCFiles = Get-ChildItem "$LibDir\*.c"

    #gen lib for rv32im
    foreach($f in $libCFiles){
        $cfile = "$LibDir/$($f.BaseName).c"
        $obj = "$LibDir/$($f.BaseName).o"

        wsl bash -c "riscv64-unknown-elf-gcc -march=rv32im -mabi=ilp32 -fno-builtin -ffreestanding -c $cfile -o $obj"
    }

    $LibDirFullA = "$LibDir/libdrysoup.a"
    $LibDirFullO = "$LibDir/*.o"
    wsl bash -c "riscv64-unknown-elf-ar rcs $LibDirFullA $LibDirFullO"

    Remove-Item "$LibDir/*.o"

    #gen lib for x86
    foreach($f in $libCFiles){
        $cfile = "$LibDir/$($f.BaseName).c"
        $obj = "$LibDir/$($f.BaseName).o"

        wsl bash -c "gcc -c $cfile -o $obj"
    }   

    $LibDirFullA = "$LibDir/libdrysoup_x86.a"
    $LibDirFullO = "$LibDir/*.o"
    wsl bash -c "riscv64-unknown-elf-ar rcs $LibDirFullA $LibDirFullO"

    Remove-Item "$LibDir/*.o"
}

if(-not $compile){ #no -compile flag =============================================================================
    if($program_file_name -eq ''){ #filename not given, run all

        $runs = (Get-ChildItem -Path ..\Programs\directed\$directory\ -Filter *.s).count
        $runCount = 0

        if($runs -le 0){
            Write-Host "`nError: no files found`n" -ForegroundColor Red
            exit 1
        }

        foreach($file in Get-ChildItem -Path ..\Programs\directed\$directory\ -Filter *.s -File) {
            $runCount++

            $wslPath = "../Programs/directed/$directory/$($file.name)"
            Write-Host "Testing $wslPath..."

            # Write-Host "Assembling in WSL..."
            # wsl bash -c "riscv64-unknown-elf-as -march=rv32im $wslPath -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
            # if ($LASTEXITCODE -ne 0) { exit 1 }

            # Write-Host "Writing instruction memory file..."
            # python3 .\load_instr_mem_file.py
            # if ($LASTEXITCODE -ne 0) { exit 1 }

            Write-Host "Assembling in WSL & Loading instruction_mem.txt and data_memory.txt..."
            wsl bash -c "../Scripts/my_gcc.sh $wslPath -gas"
            if ($LASTEXITCODE -ne 0) { exit 1 }
            python3 .\hex2mif.py .\instruction_memory.hex instr.mif
            if ($LASTEXITCODE -ne 0) { exit 1 }
            python3 .\hex2mif.py .\data_memory.hex data.mif
            if ($LASTEXITCODE -ne 0) { exit 1 }

            Write-Host "Running simulation $($runCount)/$runs..." -ForegroundColor Magenta

            & ..\Scripts\simulate_sv.ps1 @simScriptArgs -time $runTime
            if ($LASTEXITCODE -ne 0) { exit 1 }
            $simScriptArgs.no_compile = $true

            Write-Host "Moving results..."
            Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
            Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force

            Write-Host "Finished testing all programs.."
        }
    }else{ #filename given, run given file

        $runs = 1
        $runCount = 1

        $file = Get-Item "..\Programs\directed\$directory\$program_file_name"

        $wslPath = "../Programs/directed/$directory/$($file.name)"
        Write-Host $wslPath
        Write-Host "Testing $wslPath..."

        # Write-Host "Assembling in WSL..."
        # wsl bash -c "riscv64-unknown-elf-as -march=rv32im $wslPath -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        # Write-Host "Writing instruction memory file..."
        # python3 .\load_instr_mem_file.py
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Assembling in WSL & Loading instruction_mem.txt and data_memory.txt..."
        wsl bash -c "../Scripts/my_gcc.sh $wslPath -gas"
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\instruction_memory.hex instr.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\data_memory.hex data.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }

        if($no_run){
            $timer.Stop()
            $endTime = Get-Date
            Write-Host "`nScript Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Host "Script Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Host "Script Runtime: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))`n"
            exit 0
        }

        Write-Host "Running simulation $($runCount)/$runs..." -ForegroundColor Magenta
        
        & ..\Scripts\simulate_sv.ps1 @simScriptArgs -time $runTime
        if ($LASTEXITCODE -ne 0) { exit 1 }
        $simScriptArgs.no_compile = $true

        Write-Host "Moving results..."
        Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
        Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force

        Write-Host "Finished testing all programs.."
    }

    #initialize global trackers for the final verdict
    $globalAnyErrors = $false
    $globalAnyWarnings = $false

    $logFiles = Get-ChildItem -Path $logFolder -Filter "*.log" -File |
                Where-Object { $_.Name -ne $masterLogName } |
                Sort-Object Name

    foreach ($tempFile in $logFiles) {

        $content = Get-Content $tempFile.FullName
        $summaryLines = $content | Where-Object { $_ -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)" }

        if ($summaryLines) {
            $fileErrors = 0
            $fileWarnings = 0

            foreach ($line in $summaryLines) {
                if ($line -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)") {
                    $fileErrors += [int]$Matches['err']
                    $fileWarnings += [int]$Matches['warn']
                }
            }

            #update global flags if any issues are found in this file
            if ($fileErrors -gt 0) {
                $globalAnyErrors = $true
                Add-Content -Path $masterLog "FAIL (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
            }else{
                if($fileWarnings -gt 0){
                    Add-Content -Path $masterLog "PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
                }else{
                    Add-Content -Path $masterLog "CLEAN PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
                }
            }
            if ($fileWarnings -gt 0) { $globalAnyWarnings = $true }

        } else {
            $globalAnyErrors = $true
            Add-Content -Path $masterLog "$($tempFile.Name): No error/warning summary found, NOT A PASS"
        }
    }
}else{ #-compile flag ================================================================================================================
    if($program_file_name -eq ''){ #filename not given, run all

        $runs = (Get-ChildItem -Path ..\Programs\directed\$directory\ -Filter *.c).count
        $runCount = 0

        if($runs -le 0){
            Write-Host "`nError: no files found`n" -ForegroundColor Red
            exit 1
        }

        foreach($file in Get-ChildItem -Path ..\Programs\directed\$directory\ -Filter *.c -File) {
            $runCount++

            $wslPath = "../Programs/directed/$directory/$($file.name)"

            Write-Host "Testing $wslPath..."
            
            Write-Host "Assembling in WSL & Loading instruction_mem.txt and data_memory.txt..."
            wsl bash -c "../Scripts/my_gcc.sh $wslPath -gcc"
            if ($LASTEXITCODE -ne 0) { exit 1 }
            python3 .\hex2mif.py .\instruction_memory.hex instr.mif
            if ($LASTEXITCODE -ne 0) { exit 1 }
            python3 .\hex2mif.py .\data_memory.hex data.mif
            if ($LASTEXITCODE -ne 0) { exit 1 }

            Write-Host "Running simulation $($runCount)/$runs..." -ForegroundColor Magenta

            & ..\Scripts\simulate_sv.ps1 @simScriptArgs -time $runTime
            if ($LASTEXITCODE -ne 0) { exit 1 }
            $simScriptArgs.no_compile = $true

            #creating log
            $diffLog = ".\diff.log"
            New-Item -Path $diffLog -ItemType File -Force > $null

            Write-Output("`nParsing return value from sim...`n")
            $match = Select-String -Path .\sim.log -Pattern 'Return value in DUT a0:\s+(-?\d+)'

            #check for null ret val
            if ($null -ne $match) {
                $simReturnValue = [int]$match.Matches[0].Groups[1].Value
            } else {
                #error msg
                $simReturnValue = $null 
                Add-Content -Path $diffLog -Value "Error: Could not find return value in sim.log"
            }

            #-I defines the include path, where tb.h is located
            Write-Output("Running program in WSL-x86 and parsing return value`n")
            $x86ReturnValue = wsl bash -c "gcc $wslPath -I../Programs/directed/lib -L../Programs/directed/lib -ldrysoup_x86 -DX86_BUILD -o x86.out && ./x86.out"
            $x86ReturnValue = [int]$x86ReturnValue.Trim('<', '>')

            if($x86ReturnValue -eq $simReturnValue){
                Add-Content -Path $diffLog  "Pass... `nsim: $simReturnValue `nx86: $x86ReturnValue`n"

            }else{
                Add-Content -Path $diffLog  "Fail... `nsim: $simReturnValue `nx86: $x86ReturnValue`n"

            }

            Write-Host "Moving results..."
            Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
            Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force
            Copy-Item ".\diff.log" -Destination (Join-Path $logFolder "$($file.BaseName)_diff.log") -Force

            Write-Host "Finished testing all programs.."
        }
    }else{ #filename given, run given file

        $runs = 1
        $runCount = 1

        $file = Get-Item "..\Programs\directed\$directory\$program_file_name"

        $wslPath = "../Programs/directed/$directory/$($file.name)"
        Write-Host $wslPath
        Write-Host "Testing $wslPath..."

        # Write-Host "Assembling in WSL..."
        # wsl bash -c "riscv64-unknown-elf-as -march=rv32im $wslPath -o program_asm.o && riscv64-unknown-elf-objdump -d program_asm.o | tee program.log"
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        # Write-Host "Writing instruction memory file..."
        # python3 .\load_instr_mem_file.py
        # if ($LASTEXITCODE -ne 0) { exit 1 }

        Write-Host "Assembling in WSL & Loading instruction_mem.txt and data_memory.txt..."
        wsl bash -c "../Scripts/my_gcc.sh $wslPath -gcc"
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\instruction_memory.hex instr.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }
        python3 .\hex2mif.py .\data_memory.hex data.mif
        if ($LASTEXITCODE -ne 0) { exit 1 }

        if($no_run){
            $timer.Stop()
            $endTime = Get-Date
            Write-Host "`nScript Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Host "Script Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
            Write-Host "Script Runtime: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))`n"
            exit 0
        }

        Write-Host "Running simulation $($runCount)/$runs..." -ForegroundColor Magenta
        
        & ..\Scripts\simulate_sv.ps1 @simScriptArgs -time $runTime
        if ($LASTEXITCODE -ne 0) { exit 1 }
        $simScriptArgs.no_compile = $true

        #creating log
        $diffLog = ".\diff.log"
        New-Item -Path $diffLog -ItemType File -Force > $null

        Write-Output("`nParsing return value from sim...`n")
        $match = Select-String -Path .\sim.log -Pattern 'Return value in DUT a0:\s+(-?\d+)'

        #check for null retval
        if ($null -ne $match) {
            $simReturnValue = [int]$match.Matches[0].Groups[1].Value
        } else {
            #error msg
            $simReturnValue = $null 
            Add-Content -Path $diffLog -Value "Error: Could not find return value in sim.log"
        }

        #-I defines the include path, where tb.h is located
        Write-Output("Running program in WSL-x86 and parsing return value`n")
        $x86ReturnValue = wsl bash -c "gcc $wslPath -I../Programs/directed/lib -L../Programs/directed/lib -ldrysoup_x86 -DX86_BUILD -o x86.out && ./x86.out"
        $x86ReturnValue = [int]$x86ReturnValue.Trim('<', '>')

        if($x86ReturnValue -eq $simReturnValue){
            Add-Content -Path $diffLog  "Pass... `nsim: $simReturnValue `nx86: $x86ReturnValue`n"

        }else{
            Add-Content -Path $diffLog  "Fail... `nsim: $simReturnValue `nx86: $x86ReturnValue`n"

        }

        Write-Host "Moving results..."
        Copy-Item $wslPath -Destination (Join-Path $logFolder $file.name) -Force
        Copy-Item ".\sim.log" -Destination (Join-Path $logFolder "$($file.BaseName).log") -Force
        Copy-Item ".\diff.log" -Destination (Join-Path $logFolder "$($file.BaseName)_diff.log") -Force

        Write-Host "Finished testing all programs.."
    }

    #initialize global trackers for the final verdict
    $globalAnyErrors = $false
    $globalAnyWarnings = $false

    $logFiles = Get-ChildItem -Path $logFolder -Filter "*.log" -File |
                Where-Object {
                    $_.Name -ne $masterLogName -and
                    $_.Name -notlike "*_diff.log"

                } | Sort-Object Name

    foreach ($tempFile in $logFiles) {

        $content = Get-Content $tempFile.FullName
        $summaryLines = $content | Where-Object { $_ -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)" }

        if ($summaryLines) {
            $fileErrors = 0
            $fileWarnings = 0

            foreach ($line in $summaryLines) {
                if ($line -match "Errors:\s*(?<err>\d+),\s*Warnings:\s*(?<warn>\d+)") {
                    $fileErrors += [int]$Matches['err']
                    $fileWarnings += [int]$Matches['warn']
                }
            }

            #update global flags if any issues are found in this file
            if ($fileErrors -gt 0) {
                $globalAnyErrors = $true
                Add-Content -Path $masterLog "FAIL (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
            }else{
                if($fileWarnings -gt 0){
                    Add-Content -Path $masterLog "PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
                }else{
                    Add-Content -Path $masterLog "CLEAN PASS (Errors: $fileErrors, Warnings: $fileWarnings): $($tempFile.Name)"
                }
            }
            if ($fileWarnings -gt 0) { $globalAnyWarnings = $true }

        } else {
            $globalAnyErrors = $true
            Add-Content -Path $masterLog "$($tempFile.Name): No error/warning summary found, NOT A PASS"
        }
    }

    # Filter specifically for the diff logs shown in your file tree
    $diffFiles = Get-ChildItem -Path $logFolder -Filter "*_diff.log" -File |
                Where-Object { $_.Name -ne "_master_diff.log" } |
                Sort-Object Name

    Add-Content -Path $masterLog ""
    foreach ($file in $diffFiles) {

        $content = Get-Content $file.FullName
        $diffResults = ($content -match '(sim|x86):\s*-?\d+').ForEach({ 
            [regex]::Match($_, '(?<=(sim|x86):\s*)-?\d+').Value 
        })

        $simVal = $diffResults[0]
        $x86Val = $diffResults[1]
        
        if ($content[0] -match "Pass") {

            Add-Content -Path $masterLog -Value "CLEAN PASS: [sim, x86] = ($simVal, $x86Val): $($file.Name)"

        } elseif ($content[0] -match "Fail") {

            Add-Content -Path $masterLog -Value "FAIL: [sim, x86] = ($simVal, $x86Val): $($file.Name)"
            $diffAnyGlobalErrors = $true

        } else {

            Add-Content -Path $masterLog -Value "UNKNOWN: $($file.Name) (Check formatting)"
            $diffAnyGlobalErrors = $true

        }
    }

}

#final Verdict Logic at the end of the file
Add-Content -Path $masterLog ""
if ($globalAnyErrors) {
    Add-Content -Path $masterLog "FAIL: Errors detected in one or more sim logs"
} elseif ($globalAnyWarnings) {
    Add-Content -Path $masterLog "PASS: Warnings present"
} else {
    Add-Content -Path $masterLog "CLEAN PASS: No warnings or errors"
}

if($compile){
    if($diffAnyGlobalErrors){
        Add-Content -Path $masterLog "FAIL: Mismatch between x86 and sim detected in one or more diff logs"
    }else{
        Add-Content -Path $masterLog "PASS: No mismatches detected in any of the diff logs"
    }
}

#timestamps
$timer.Stop()
$endTime = Get-Date
Add-Content -Path $masterLog "`nVerification Started: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Add-Content -Path $masterLog "Verification Finished: $($endTime.ToString('yyyy-MM-dd HH:mm:ss'))"
Add-Content -Path $masterLog "Verification Time: $($timer.Elapsed.ToString('hh\:mm\:ss\.ff'))"

Write-Host "Master log updated at $masterLog"


#print out master log in cmd
Write-Host "`n===============================================`n"
Get-Content $masterLog
Write-Host "`n===============================================`n"

#reprint results in cmd with color formating
if ($globalAnyErrors) {
    Write-Host "FAIL: Errors detected in one or more sim logs" -ForegroundColor Red
} elseif ($globalAnyWarnings) {
    Write-Host "PASS: " -ForegroundColor Green -NoNewline
    Write-Host "Warnings present" -ForegroundColor Yellow
} else {
    Write-Host "CLEAN PASS: No warnings or errors" -ForegroundColor Green
}

if($compile){
    if($diffAnyGlobalErrors){
        Write-Host "FAIL: Mismatch between x86 and sim detected in one or more diff logs" -ForegroundColor Red
    }else{
        Write-Host "PASS: No mismatches detected in any of the diff logs" -ForegroundColor Green
    }
}

Write-Host ""
exit 0