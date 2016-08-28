﻿:: ==================================================================================
:: NAME     : Reset Windows Update Tool.
:: DESCRIPTION     : This script reset the Windows Update Components.
:: AUTHOR     : Manuel Gil.
:: VERSION     : 10.5.2.1
:: ==================================================================================


:: Set console.
:: /************************************************************************************/
:mode

echo off
title Reset Windows Update Tool.
mode con cols=78 lines=32
color 17
cls

goto getValues
:: /************************************************************************************/


:: Print Top Text.
:: /*************************************************************************************/
:print

cls
echo.
echo.%name% [Version: %version%]
echo.Reset Windows Update Tool.
echo.
echo.%*
echo.

goto :eof
:: /*************************************************************************************/


:: Add Value in the Registry.
:: /*************************************************************************************/
:addReg
 
reg add "%~1" /v "%~2" /t "%~3" /d "%~4" /f
 
goto :eof
:: /*************************************************************************************/


:: Load the system values.
:: /************************************************************************************/
:getValues

for /f "tokens=4-5 delims=[] " %%a in ('ver') do set version=%%a%%b
for %%a in (%version%) do set version=%%a

if %version% EQU 5.1.2600 (
    :: Name: "Microsoft Windows XP"
    set name=Microsoft Windows XP
    :: Family: Windows 5
    set family=5
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 5.2.3790 (
    :: Name: "Microsoft Windows XP Professional x64 Edition"
    set name=Microsoft Windows XP Professional x64 Edition
    :: Family: Windows 5
    set family=5
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.0.6000 (
    :: Name: "Microsoft Windows Vista"
    set name=Microsoft Windows Vista
    :: Family: Windows 6
    set family=6
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.0.6001 (
    :: Name: "Microsoft Windows Vista SP1"
    set name=Microsoft Windows Vista SP1
    :: Family: Windows 6
    set family=6
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.0.6002 (
    :: Name: "Microsoft Windows Vista SP2"
    set name=Microsoft Windows Vista SP2
    :: Family: Windows 6
    set family=6
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.1.7600 (
    :: Name: "Microsoft Windows 7"
    set name=Microsoft Windows 7
    :: Family: Windows 7
    set family=7
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.1.7601 (
    :: Name: "Microsoft Windows 7 SP1"
    set name=Microsoft Windows 7 SP1
    :: Family: Windows 7
    set family=7
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.2.9200 (
    :: Name: "Microsoft Windows 8"
    set name=Microsoft Windows 8
    :: Family: Windows 8
    set family=8
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.3.9200 (
    :: Name: "Microsoft Windows 8.1"
    set name=Microsoft Windows 8.1
    :: Family: Windows 8
    set family=8
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 6.3.9600 (
    :: Name: "Microsoft Windows 8.1 Update 1"
    set name=Microsoft Windows 8.1 Update 1
    :: Family: Windows 8
    set family=8
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 10.0.10049 (
    :: Name: "Microsoft Windows 10 Technical Preview"
    set name=Microsoft Windows 10 Technical Preview
    :: Family: Windows 10
    set family=10
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 10.0.10240 (
    :: Name: "Microsoft Windows 10 Threshold 1"
    set name=Microsoft Windows 10 Threshold 1
    :: Family: Windows 10
    set family=10
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 10.0.10586 (
    :: Name: "Microsoft Windows 10 Threshold 2"
    set name=Microsoft Windows 10 Threshold 2
    :: Family: Windows 10
    set family=10
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 10.0.14393 (
    :: Name: "Microsoft Windows 10 Redstone 1"
    set name=Microsoft Windows 10 Redstone 1
    :: Family: Windows 10
    set family=10
    :: Compatibility: Yes
    set allow=Yes
) else if %version% EQU 10.0.14905 (
    :: Name: "Microsoft Windows 10 Insider Preview"
    set name=Microsoft Windows 10 Insider Preview
    :: Family: Windows 10
    set family=10
    :: Compatibility: Yes
    set allow=Yes
) else (
    :: Name: "Unknown"
    set name=Unknown
    :: Compatibility: No
    set allow=No
)

call :print %name% detected . . .

if %allow% EQU Yes goto permission

call :print Sorry, this Operative System is not compatible with this tool.

echo.    An error occurred while attempting to verify your system.
echo.    Can this using a business or test version.
echo.
echo.    If not, verify that your system has the correct security fix.
echo.

echo.Press any key to continue . . .
pause>nul
goto :eof
:: /************************************************************************************/


:: Checking for Administrator elevation.
:: /************************************************************************************/
:permission

openfiles>nul 2>&1

if %errorlevel% EQU 0 goto terms

call :print Checking for Administrator elevation.

echo.    You are not running as Administrator.
echo.    This tool cannot do it's job without elevation.
echo.
echo.    You need run this tool as Administrator.
echo.

echo.Press any key to continue . . .
pause>nul
goto :eof
:: /************************************************************************************/


:: Terms.
:: /*************************************************************************************/
:terms

call :print Terms and Conditions of Use.

echo.    The methods inside this tool modify files and registry settings.
echo.    While you are tested and tend to work, We not take responsibility for
echo.    the use of this tool.
echo.
echo.    This tool is provided without warranty. Any damage caused is your
echo.    own responsibility.
echo.
echo.    As well, batch files are almost always flagged by anti-virus, feel free
echo.    to review the code if you're unsure.
echo.

choice /c YN /n /m "Do you want to continue with this process? (Yes/No) "
if %errorlevel% EQU 1 goto menu
if %errorlevel% EQU 2 goto close

echo.An unexpected error has occurred.
echo.
echo.Press any key to continue . . .
pause>nul
goto menu
:: /*************************************************************************************/


:: Menu of tool.
:: /*************************************************************************************/
:menu

call :print This tool reset the Windows Update Components.

echo.    1. Open the system protection.
echo.    2. Reset Windows Update Components.
echo.    3. Delete temporary files in Windows.
echo.    4. Open the Internet Explorer options.
echo.    5. Scans all protected system files.
echo.    6. Scan the image to check for corruption.
echo.    7. Check the detected corruptions.
echo.    8. Repair the image.
echo.    9. Clean up the superseded components.
echo.    10. Change invalid values in the Registry.
echo.    11. Reset the Winsock settings.
echo.    12. Search updates.
echo.    13. Explore other local solutions.
echo.    14. Explore other online solutions.
echo.    15. Download Diagnostic.
echo.    16. Restart your PC.
echo.
echo.                                            ?. Help.    0. Close.
echo.

set /p option=Select an option: 

if %option% EQU 0 (
    goto close
) else if %option% EQU 1 (
    call :sysProtection
) else if %option% EQU 2 (
    call :components
) else if %option% EQU 3 (
    call :temp
) else if %option% EQU 4 (
    call :iOptions
) else if %option% EQU 5 (
    call :sfc
) else if %option% EQU 6 (
    call :dism1
) else if %option% EQU 7 (
    call :dism2
) else if %option% EQU 8 (
    call :dism3
) else if %option% EQU 9 (
    call :dism4
) else if %option% EQU 10 (
    call :regedit
) else if %option% EQU 11 (
    call :winsock
) else if %option% EQU 12 (
    call :updates
) else if %option% EQU 13 (
    call :local
) else if %option% EQU 14 (
    call :online
) else if %option% EQU 15 (
    call :diagnostic
) else if %option% EQU 16 (
    call :restart
) else if %option% EQU ? (
    call :help
) else (
    echo.
    echo.Invalid option.
    echo.
    echo.Press any key to continue . . .
    pause>nul
)
 
goto menu
:: /*************************************************************************************/


:: Open system protection.
:: /*************************************************************************************/
:sysProtection

call :print Opening the system protection.

if %family% NEQ 5 (
    start systempropertiesprotection
) else (
    echo.
    echo.Sorry, this option is not available on this Operative System.
    echo.
    echo.Press any key to continue . . .
    pause>nul
)

goto :eof
:: /*************************************************************************************/


:: Run the reset Windows Update components.
:: /*************************************************************************************/
:components

:: ----- Stopping the Windows Update services -----
call :print Stopping the Windows Update services.
net stop bits

call :print Stopping the Windows Update services.
net stop wuauserv

call :print Stopping the Windows Update services.
net stop appidsvc

call :print Stopping the Windows Update services.
net stop cryptsvc

:: ----- Checking the services status -----
call :print Checking the services status.

sc query bits | findstr /I /C:"STOPPED"
If %errorlevel% NEQ 0 (
    echo.    Failed to stop the BITS service.
    echo.
    echo.Press any key to continue . . .
    pause>nul
    goto close
)

call :print Checking the services status.

sc query wuauserv | findstr /I /C:"STOPPED"
if %errorlevel% NEQ 0 (
    echo.    Failed to stop the Windows Update service.
    echo.
    echo.Press any key to continue . . .
    pause>nul
    goto close
)

call :print Checking the services status.

sc query appidsvc | findstr /I /C:"STOPPED"
if %errorlevel% NEQ 0 (
    sc query appidsvc | findstr /I /C:"OpenService FAILED 1060"
    if %errorlevel% NEQ 0 (
        echo.    Failed to stop the Application Identity service.
        echo.
        echo.Press any key to continue . . .
        pause>nul
        if %family% NEQ 6 goto close
    )
)

call :print Checking the services status.

sc query cryptsvc | findstr /I /C:"STOPPED"
If %errorlevel% NEQ 0 (
    echo.    Failed to stop the Cryptographic Services service.
    echo.
    echo.Press any key to continue . . .
    pause>nul
    goto close
)

:: ----- Delete the qmgr*.dat files -----
call :print Deleting the qmgr*.dat files.

del /s /q /f "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\qmgr*.dat"

:: ----- Renaming the softare distribution folders backup copies -----
call :print Renaming the softare distribution folders backup copies.

cd /d %SYSTEMROOT%

if exist "%SYSTEMROOT%\winsxs\pending.xml.bak" (
    del /s /q /f "%SYSTEMROOT%\winsxs\pending.xml.bak"
)
if exist "%SYSTEMROOT%\SoftwareDistribution.bak" (
    rmdir /s /q "%SYSTEMROOT%\SoftwareDistribution.bak"
)
if exist "%SYSTEMROOT%\system32\Catroot2.bak" (
    rmdir /s /q "%SYSTEMROOT%\system32\Catroot2.bak"
)
if exist "%SYSTEMROOT%\WindowsUpdate.log.bak" (
    del /s /q /f "%SYSTEMROOT%\WindowsUpdate.log.bak"
)

call :print Renaming the softare distribution folders backup copies.

if exist "%SYSTEMROOT%\winsxs\pending.xml" (
    takeown /f "%SYSTEMROOT%\winsxs\pending.xml"
    attrib -r -s -h /s /d "%SYSTEMROOT%\winsxs\pending.xml"
    ren "%SYSTEMROOT%\winsxs\pending.xml" pending.xml.bak
)
if exist "%SYSTEMROOT%\SoftwareDistribution" (
    attrib -r -s -h /s /d "%SYSTEMROOT%\SoftwareDistribution"
    ren "%SYSTEMROOT%\SoftwareDistribution" SoftwareDistribution.bak
)
if exist "%SYSTEMROOT%\system32\Catroot2" (
    attrib -r -s -h /s /d "%SYSTEMROOT%\system32\Catroot2"
    ren "%SYSTEMROOT%\system32\Catroot2" Catroot2.bak
)
if exist "%SYSTEMROOT%\WindowsUpdate.log" (
    attrib -r -s -h /s /d "%SYSTEMROOT%\WindowsUpdate.log"
    ren "%SYSTEMROOT%\WindowsUpdate.log" WindowsUpdate.log.bak
)

:: ----- Reset the BITS service and the Windows Update service to the default security descriptor -----
call :print Reset the BITS service and the Windows Update service to the default security descriptor.

sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)

:: ----- Reregister the BITS files and the Windows Update files -----
call :print Reregister the BITS files and the Windows Update files.

cd /d %WINDIR%\system32
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll

:: ----- Resetting Winsock -----
call :print Resetting Winsock.
netsh winsock reset

:: ----- Resetting WinHTTP Proxy -----
call :print Resetting WinHTTP Proxy.

if %family% EQU 5 (
    proxycfg.exe -d
) else (
    netsh winhttp reset proxy
)

:: ----- Starting the Windows Update services -----
call :print Starting the Windows Update services.
net start bits

call :print Starting the Windows Update services.
net start wuauserv

call :print Starting the Windows Update services.
net start appidsvc

call :print Starting the Windows Update services.
net start cryptsvc

:: ----- End process -----
call :print The operation completed successfully.

echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Delete temporary files in Windows.
:: /*************************************************************************************/
:temp

call :print Deleting temporary files in Windows.

del /s /f /q "%TEMP%\*.*"
del /s /f /q "%SYSTEMROOT%\Temp\*.*"

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Open the Internet Explorer options.
:: /*************************************************************************************/
:iOptions

call :print Opening the Internet Explorer options.

start InetCpl.cpl

goto :eof
:: /*************************************************************************************/


:: Scans all protected system files.
:: /*************************************************************************************/
:sfc

call :print Scans all protected system files.

if %family% NEQ 5 (
    sfc /scannow
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Scan the image to check for corruption.
:: /*************************************************************************************/
:dism1

call :print Scanning the image to check for corruption.

if %family% EQU 8 (
    Dism.exe /Online /Cleanup-Image /ScanHealth
) else if %family% EQU 10 (
    Dism.exe /Online /Cleanup-Image /ScanHealth
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Check the detected corruptions.
:: /*************************************************************************************/
:dism2

call :print Checking the detected corruptions.


if %family% EQU 8 (
    Dism.exe /Online /Cleanup-Image /CheckHealth
) else if %family% EQU 10 (
    Dism.exe /Online /Cleanup-Image /CheckHealth
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Repair the image.
:: /*************************************************************************************/
:dism3

call :print Repairing the image.

if %family% EQU 8 (
    Dism.exe /Online /Cleanup-Image /RestoreHealth
) else if %family% EQU 10 (
    Dism.exe /Online /Cleanup-Image /RestoreHealth
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Clean up the superseded components .
:: /*************************************************************************************/
:dism4

call :print Clean up the superseded components.

if %family% EQU 8 (
    Dism.exe /Online /Cleanup-Image /StartComponentCleanup
) else if %family% EQU 10 (
    Dism.exe /Online /Cleanup-Image /StartComponentCleanup
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Change invalid values.
:: /*************************************************************************************/
:regedit

for /f "tokens=1-5 delims=/, " %%a in ("%date%") do (
    set now=%%a%%b%%c%%d%time:~0,2%%time:~3,2%
)

:: ----- Create a backup of the Registry -----
call :print Making a backup copy of the Registry in: %USERPROFILE%\Desktop\Backup%now%.reg

if exist "%USERPROFILE%\Desktop\Backup%now%.reg" (
    echo.An unexpected error has occurred.
    echo.
    echo.    Changes were not carried out in the registry.
    echo.    Will try it later.
    echo.
    echo.Press any key to continue . . .
    pause>nul
    goto :eof
) else (
    regedit /e "%USERPROFILE%\Desktop\Backup%now%.reg"
)

:: ----- Checking backup -----
call :print Checking the backup copy.

if not exist "%USERPROFILE%\Desktop\Backup%now%.reg" (
    echo.An unexpected error has occurred.
    echo.
    echo.    Something went wrong.
    echo.    You manually create a backup of the registry before continuing.
    echo.
    echo.Press any key to continue . . .
    pause>nul
) else (
    echo.The operation completed successfully.
    echo.
)

:: ----- Delete keys in the Registry -----
call :print Deleting values in the Registry.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /f
reg delete "HKLM\COMPONENTS\PendingXmlIdentifier" /f
reg delete "HKLM\COMPONENTS\NextQueueEntryIndex" /f
reg delete "HKLM\COMPONENTS\AdvancedInstallersNeedResolving" /f

:: ----- Add keys in the Registry -----
call :print Adding values in the Registry.

set key=HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX
call :addReg "%key%" "IsConvergedUpdateStackEnabled" "REG_DWORD" "0"

set key=HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings
call :addReg "%key%" "UxOption" "REG_DWORD" "0"

set key=HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
call :addReg "%key%" "AppData" "REG_EXPAND_SZ" "%USERPROFILE%\AppData\Roaming"

set key=HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
call :addReg "%key%" "AppData" "REG_EXPAND_SZ" "%USERPROFILE%\AppData\Roaming"

set key=HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders
call :addReg "%key%" "AppData" "REG_EXPAND_SZ" "%USERPROFILE%\AppData\Roaming"

set key=HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate
call :addReg "%key%" "AllowOSUpgrade" "REG_DWORD" "1"

reg add "HKLM\SYSTEM\CurrentControlSet\Control\BackupRestore\FilesNotToBackup" /f

set key=HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains
call :addReg "%key%\microsoft.com\update" "http" "REG_DWORD" "2"
call :addReg "%key%\microsoft.com\update" "https" "REG_DWORD" "2"
call :addReg "%key%\microsoft.com\windowsupdate" "http" "REG_DWORD" "2"
call :addReg "%key%\update.microsoft.com" "http" "REG_DWORD" "2"
call :addReg "%key%\update.microsoft.com" "https" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.com" "http" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.microsoft.com" "http" "REG_DWORD" "2"
call :addReg "%key%\download.microsoft.com" "http" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.com" "http" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.com" "https" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.com\download" "http" "REG_DWORD" "2"
call :addReg "%key%\windowsupdate.com\download" "https" "REG_DWORD" "2"
call :addReg "%key%\download.windowsupdate.com" "http" "REG_DWORD" "2"
call :addReg "%key%\download.windowsupdate.com" "https" "REG_DWORD" "2"
call :addReg "%key%\windows.com\wustat" "http" "REG_DWORD" "2"
call :addReg "%key%\wustat.windows.com" "http" "REG_DWORD" "2"
call :addReg "%key%\microsoft.com\ntservicepack" "http" "REG_DWORD" "2"
call :addReg "%key%\ntservicepack.microsoft.com" "http" "REG_DWORD" "2"
call :addReg "%key%\microsoft.com\ws" "http" "REG_DWORD" "2"
call :addReg "%key%\microsoft.com\ws" "https" "REG_DWORD" "2"
call :addReg "%key%\ws.microsoft.com" "http" "REG_DWORD" "2"
call :addReg "%key%\ws.microsoft.com" "https" "REG_DWORD" "2"

:: ----- End process -----
call :print The operation completed successfully.

echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


winsock
:: Reset Winsock setting.
:: /*************************************************************************************/
:Winsock

:: ----- Reset Winsock control -----
call :print Reset Winsock control.

call :print Restoring transaction logs.
fsutil resource setautoreset true C:\

call :print Restoring TPC/IP.
netsh int ip reset

call :print Restoring Winsock.
netsh winsock reset

call :print Restoring default policy settings.
netsh advfirewall reset

call :print Restoring the DNS cache.
ipconfig /flushdns

call :print Restoring the Proxy.
netsh winhttp reset proxy

:: ----- End process -----
call :print The operation completed successfully.

echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Search Updates.
:: /*************************************************************************************/
:updates

call :print Looking for updates.

echo.Wait . . .
echo.

wuauclt /resetauthorization /detectnow

if %family% EQU 10 (
    start ms-settings:windowsupdate
) else (
    if %family% NEQ 5 (
        start wuapp.exe
    ) else (
        echo.
        echo.An unexpected error has occurred.
        echo.
        echo.Press any key to continue . . .
        pause>nul
    )
)

goto :eof
:: /*************************************************************************************/


:: Explore other local solutions.
:: /*************************************************************************************/
:local

call :print Looking for solutions in this PC.

if %family% NEQ 5 (
    start control.exe /name Microsoft.Troubleshooting
) else (
    echo.Sorry, this option is not available on this Operative System.
    echo.
    echo.Press any key to continue . . .
    pause>nul
)

goto :eof
:: /*************************************************************************************/


:: Explore other online solutions.
:: /*************************************************************************************/
:online

call :print Looking for solutions Online.

start https://support.microsoft.com/en-us/gp/windows-update-issues/

goto :eof
:: /*************************************************************************************/


:: Reboot the system.
:: /*************************************************************************************/
:restart

call :print Restart your PC.

if %family% NEQ 5 (
    echo.    The system reboot in 60 seconds.
    echo.    Please save all open documents.

    start shutdown.exe /r /t 60 /c "The system reboot in 60 seconds. Please save all open documents."
) else (
    echo.Sorry, this option is not available on this Operative System.
)

echo.
echo.Press any key to continue . . .
pause>nul
goto :eof
:: /*************************************************************************************/


:: Open help file.
:: /*************************************************************************************/
:help

start %~dp0Help.chm

goto :eof
:: /*************************************************************************************/


:: Crea el menú de descarga de diagnósticos.
:: /*************************************************************************************/
:diagnostic

call :print Download and run diagnostics for your system.

echo.    1. Windows Update on Windows 7, Windows 8 y Windows 8.1.
echo.    2. Windows Update on Windows 10.
echo.    3. Apps on Windows 8.1.
echo.    4. Apps on Windows 10.
echo.    5. Start Menu on Windows 10.
echo.
echo.                                                        0. Back.
echo.

set /p option=Select an option: 

if %option% EQU 0 (
    goto menu
) else if %option% EQU 1 (
    start http://go.microsoft.com/?linkid=9830262
) else if %option% EQU 2 (
    start http://aka.ms/diag_wu
) else if %option% EQU 3 (
    start http://go.microsoft.com/fwlink/p/?LinkId=268423
) else if %option% EQU 4 (
    start http://aka.ms/diag_apps10
) else if %option% EQU 5 (
    start http://aka.ms/startmenuTS
) else (
    echo.
    echo.Invalid option.
    echo.
    echo.Press any key to continue . . .
    pause>nul
)
 
goto diagnostic
:: /*************************************************************************************/


:: End tool.
:: /*************************************************************************************/
:close

exit
:: /*************************************************************************************/

