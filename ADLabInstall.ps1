<#
.SYNOPSIS
    Adds an account to the Active directory Computer user depending on the users inputs.
.DESCRIPTION
    Created an entry in the OU starting at the original number and going up as many machines that need adding.
.PARAMETER Metric

#>
function Add-LabComputers {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
            [string][ValidateSet(
                    "EGB069",
                    "EGB070",
                    "EGB074",
                    "EGB076",
                    "EGB080",
                    "EGB083",
                    "INA033",
                    "IND052",
                    "IND053"
                             )]$LabOU,

        [Parameter(Mandatory=$true)]
            [int]$CurrentNumber,

        [Parameter(Mandatory=$true)]
           [int]$ammount

    )  


    PROCESS {


        foreach($_ in $CurrentNumber..$ammount)
        {       
                
                if      ($CurrentNumber -lt 10){
                    $ComputerNameGen = $LabOU + "00000" + $CurrentNumber
                }
                elseif  ($CurrentNumber -lt 100){
                            $ComputerNameGen = $LabOU + "0000" + $CurrentNumber
                }
                else{
                            $ComputerNameGen = $LabOU + "000" + $CurrentNumber
                }
                $OULocation = "OU=$LabOU,OU=Labs,OU=SCC,OU=FST,OU=Independent,OU=University,DC=Lancs,DC=Local"


                New-Adcomputer -Name $ComputerNameGen -Path $OULocation
                $CurrentNumber++

            }
                
    }

}
