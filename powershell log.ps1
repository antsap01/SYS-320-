# SYS-320-

#Storyline: Review the Security Event Log


# List all the available windows Event logs
Get-EventLog -list 

# Create a prompt to allow user to select the log to view
$readLog = Read-host -Prompt "Please select a log to review from the list above." 

# Create a prompt that allows the user to search for a keyword or a phrase in the log file they selected 
$phrase = Read-host -Prompt "Select a word or phrase to search for in the log file you selected."


# Print the log results
Get-EventLog -LogName $readLog -Newest 100 | where {$_.Message -ilike "*$phrase*"} 
