#$computers = Get-Content -Path E:\scripts\d53.txt
$computers = "ind052000025"

foreach($computer in $computers){

$pathexist = Test-Path "\\$computer\c$\ProgramData\SCC\VBoxes"


    if ($pathexist -eq $true){
        $path = "\\$computer\c$\programdata\SCC\Vboxes\Data" 
        $user = "builtin\users" 
        $Rights = "Read, ReadAndExecute, ListDirectory, write" 
        $InheritSettings = "Containerinherit, ObjectInherit" 
        $PropogationSettings = "None" 
        $RuleType = "Allow" 
        $acl = Get-Acl $path
        $perm = $user, $Rights, $InheritSettings, $PropogationSettings, $RuleType
        $rule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $perm
        $acl.SetAccessRule($rule)
        $acl | Set-Acl -Path $path
    }
    else {
    Write-Host "$computer isn't Ready" -ForegroundColor Red
    }

}