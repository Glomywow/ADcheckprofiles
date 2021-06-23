Get-ChildItem -Path C:\Users -Exclude "temp*", "all users", "public", "Администратор" | select name -ExpandProperty name | Out-File C:\service\profillist.txt
$Profiles = @(gc c:\service\profillist.txt)
$cikl = foreach ($profile in $Profiles) {
Get-ADUser  $profile | where {$_.Enabled -eq $false} | select samaccountname -ExpandProperty samaccountname
}
$cikl | Out-File C:\service\false.txt
$names =  @(gc c:\service\false.txt)
foreach ($name in $names) {
Get-WMIObject -class Win32_UserProfile | where LocalPath -eq C:\Users\$name | Remove-WmiObject
