#GPUpdate Script version 1.5.1 ------ Q('.'Q) ------

#Variables
######################################################################################
$computerlist = Get-Content E:\Scripts\b74new.txt
$roomnumber = Read-Host -Prompt 'What room do you want to update? (A44, B70, B74, B76, B80, D52, D53, B83) '
#$computerlist = Get-Content "\\scc-wds\scripts$\$roomnumber.txt"
$computerestart = Read-Host -Prompt 'Do you want to restart the machines? (y/n)'
$forceshutdown = Read-Host -Prompt 'Forcefully shutdown machines? (y/n/cancel) - Irrelevant if not restarting'

#Functions
#######################################################################################


function ConnectionTest {
     if (Test-Connection -ComputerName $computer -Count 1 -Quiet){
            return $true
         }
     else {
          Write-Warning "$computer is offline" 
            return $false
    }
}


#Scriptblock
########################################################################################

foreach($computer in $computerlist){
        if(ConnectionTest eq $true) { 
              Invoke-Command {gpupdate /force}
              Write-Host "$computer has updated" -ForegroundColor Green
       }
}

#If you raw input -eq 'y' the machines will reboot after the gpupdates have finished.
#Else you just want to update the machines, press n or any other key to continue the script and the machines will not restart.

if ($computerestart -eq 'y') {
             if($forceshutdown -eq 'y'){
                  Restart-Computer -Force -ComputerName $computerlist
                  Write-Host 'Machines Forcefully shutdown' -BackgroundColor Black -ForegroundColor White
       }
            elseif($forceshutdown -eq 'cancel'){
                Write-Host 'Cancelled Shutdowns' -ForegroundColor Red
       }
            else{
                  Restart-Computer -ComputerName $computerlist 
                  Write-Host 'Machines will shutdown if users are not logged in' -ForegroundColor Green
       }
}
elseif ($computerestart -eq 'n'){
Write-Host 'Machines will not restart' -ForegroundColor DarkYellow
}


#Final Statement
##########################################################################################
Write-Host ''
Write-Host "Computers have Updated" -ForegroundColor Yellow
write-host 
Read-Host 'Press Enter to close the script'
