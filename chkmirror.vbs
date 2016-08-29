
rem Option Explicit

Dim WshShell, oExec
Dim RegexParse
Dim hasError  hasError = 0

Set WshShell = WScript.CreateObject(WScript.Shell)
Set RegexParse = New RegExp

Set oExec = WshShell.Exec(%comspec% c echo list volume  diskpart.exe)

RegexParse.Pattern = ss(Volumesd)s+([A-Z])s+(.)ss(NTFSFAT)s+(MirrorRAID-5)s+(d+)s+(..)ss([A-Za-z]s[A-Za-z])(ss).

While Not oExec.StdOut.AtEndOfStream
    Dim regexMatches
    Dim Volume, Drive, Description, Redundancy, RaidStatus
    Dim CurrentLine  CurrentLine = oExec.StdOut.ReadLine
    
    Set regexMatches = RegexParse.Execute(CurrentLine)
    If (regexMatches.Count  0) Then
        Dim match
        Set match = regexMatches(0)
        
        If match.SubMatches.Count = 8 Then
            Volume      = match.SubMatches(0)
            Drive       = match.SubMatches(1)
            Description = Trim(match.SubMatches(2))
            Redundancy  = match.SubMatches(4)
            RaidStatus  = Trim(match.SubMatches(7))
        End If

        If RaidStatus  Healthy Then
            hasError = 1
            WScript.StdOut.Write WARNING 
        End If
        
        WScript.StdOut.WriteLine Status of  & Redundancy &   & Drive &  ( & Description & ) is  & RaidStatus & 
    End If
Wend

If (hasError) Then
    WScript.StdOut.WriteLine 
    WScript.StdOut.WriteLine WARNING One or more redundant drives are not in a Healthy state!



Set objMessage = CreateObject(CDO.Message) 
 objMessage.Subject = MIRROR FAILED HyperVServer biuro.local
 objMessage.From = marek@i-can.pl 
 objMessage.To = marek@i-can.pl 
 objMessage.TextBody = Status of  & Redundancy &   & Drive &  ( & Description & ) is  & RaidStatus & 
 
 '==This section provides the configuration information for the remote SMTP server.
 '==Normally you will only change the server name or IP.
 objMessage.Configuration.Fields.Item _
 (httpschemas.microsoft.comcdoconfigurationsendusing) = 2 
 'Name or IP of Remote SMTP Server
 objMessage.Configuration.Fields.Item _
 (httpschemas.microsoft.comcdoconfigurationsmtpserver) = i-can.pl
 'Server port (typically 25)
 objMessage.Configuration.Fields.Item _
 (httpschemas.microsoft.comcdoconfigurationsmtpserverport) = 25  
 objMessage.Configuration.Fields.Update
 '==End remote SMTP server configuration section==
 
 objMessage.Send




End If

WScript.Quit(hasError)
