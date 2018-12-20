$computerlist = Get-Content -Path "C:\IPAdresses.txt"

foreach($computer in $computerlist){

    $acl = Get-Acl "\\$computer\C$\Users\Public\Documents\Hyper-V\Virtual Hard Disks\Win 7 Blue.vhdx"
    $permission = "Everyone","FullControl","Allow"
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission
    $acl.SetAccessRule($rule)
    $acl | Set-Acl "\\$computer\C$\Users\Public\Documents\Hyper-V\Virtual Hard Disks\Win 7 Blue.vhdx"
    Write-Host -Message "$computer has finished"-ForegroundColor Green
    }