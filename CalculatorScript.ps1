# SYS-320-
# Storyline: Start and Stop the windows caculator with the process name 

Get-Process | Select-Object  ProcessName, Path, ID | 
` export-csv -Path "C:\Users\Anthony\Desktop\Processes.csv" -NoTypeInformation

Get-Service | 
` Export-Csv -Path "C:\Users\Anthony\Desktop\Services.csv" -NoTypeInformation 

# Start Windows Calculator
$StartProcess = Read-Host -Prompt "Select a process to start from the process list"
#Start the process
Start-Process "$StartProcess"


# Stop Windows Calculator
$StopProcess = Read-Host -Prompt "Select a process name to stop from the process list"
# Stop the Process
Stop-process -name "$StopProcess"
