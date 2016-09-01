$StartFolder = "C:\wamp\www"
$logFile = "C:\Users\lenovor500\Downloads\deleteold_log.txt "

dir $StartFolder -Recurse -Force -ea 0 | 
?{!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-1)} | 
ForEach-Object {
    $_ | del -Force
    $_.FullName | Out-File $logFile -Append
}

