# SYS-320-
#Storyline: view service logs and check if the user specifed if the service is running, stopped, or both and print the results.

# Define the valid options for the user prompt
$valid_options = @('all', 'Stopped', 'Running', 'quit')

# make the function that will call the service logs based on the users input

function service_logs ($userinput){
     

    #user input is all
    if($userinput -eq 'all'){

        Get-Service
        
    }

    #User input is running
    elseif($userinput -eq 'Running'){

        Get-Service | Where-Object {$_.Status -eq 'Running'}
        
    }

    #user input is stopped 
    elseif ($userinput -eq 'Stopped'){

        Get-Service | Where-Object {$_.Status -eq 'Stopped'}
  
    }

}

   
while ($true){

    $user_input = Read-Host "Enter the status of the service log you want: Running, Stopped, or All. To quit type quit"

    #user wants to quit
    if ($user_input -eq 'quit'){

        break
    }

    #invalid option
    elseif ($user_input -notin $valid_options) {
        write-host "Ivalid option. Please type Running, Stopped, All, or quit into the prompt"
        continue
    }

    else{
        service_logs $user_input
    }

}


