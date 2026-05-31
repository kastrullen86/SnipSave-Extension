@echo off
TITLE SnipSave Extension - Installer
echo ===================================================
echo   SnipSave Extension: Deploying Native Component...
echo ===================================================
echo.

:: Define Paths
set "SourceScript=%~dp0src\SnipSave.ahk"
set "SourceExe=%~dp0dist\SnipSave.exe"
set "TargetDir=%APPDATA%\SnipSave"
set "ShortcutPath=%USERPROFILE%\Desktop\SnipSave.lnk"

:: Create local isolated application directory
if not exist "%TargetDir%" mkdir "%TargetDir%"

:: Determine if deployment uses the raw script or compiled binary
if exist "%SourceExe%" (
    echo [INFO] Compiled production binary detected. Deploying executable...
    copy "%SourceExe%" "%TargetDir%\SnipSave.exe" /Y >nul
    set "TargetPath=%TargetDir%\SnipSave.exe"
) else (
    echo [INFO] Standalone script deployment active. Deploying raw AHK source...
    copy "%SourceScript%" "%TargetDir%\SnipSave.ahk" /Y >nul
    set "TargetPath=%TargetDir%\SnipSave.ahk"
)

:: Programmatically build the VBScript required to generate a native Windows shortcut binding
set "VBSFile=%TEMP%\CreateShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBSFile%"
echo sLinkFile = "%ShortcutPath%" >> "%VBSFile%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBSFile%"
echo oLink.TargetPath = "%TargetPath%" >> "%VBSFile%"
echo oLink.Description = "SnipSave Native Overlay Extension" >> "%VBSFile%"
echo oLink.HotKey = "CTRL+SHIFT+S" >> "%VBSFile%"
echo oLink.Save >> "%VBSFile%"

:: Execute shortcut construction and clean up temporary assets
cscript //nologo "%VBSFile%"
del "%VBSFile%"

echo [SUCCESS] Environment mapped cleanly to target directory: %TargetDir%
echo [SUCCESS] Global Hotkey initialized: [ Ctrl + Shift + S ]
echo.
echo Setup completed. Execute SnipSave using the mapped keyboard shortcut.
pause