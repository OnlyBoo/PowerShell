#Get-ADComputer -SearchBase "OU=Desktops,OU=SCC,OU=FST,OU=Independent,OU=University,DC=lancs,DC=local" -Filter * | Select-Object Name
#Get-ADComputer -SearchBase "OU=KBC,OU=SCC,OU=FST,OU=ISS SUpported,OU=University,DC=lancs,DC=local" -Filter * | Select-Object Name 

$computerlist = Get-Content -Path "E:\Scripts\ComputerList.txt"

function ConnectionTest {
     if (Test-Connection -ComputerName $computer -Count 1 -Quiet){
            return $true
         }
     else {
          #Write-Warning "$computer is offline" 
            return $false
    }
}


foreach($computer in $computerlist){
        if(ConnectionTest eq $true) { 
           $Version = (Get-WmiObject -ComputerName $computer -class Win32_OperatingSystem).Caption
           Write-Host "$computer - $Version" 
       }
}
