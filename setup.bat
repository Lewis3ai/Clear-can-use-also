
@echo off
REM setup.bat - Creates Library folder in Documents with About.md and Algorithm.txt

REM Get the user's Documents folder (works for any user)
set "LIBRARY_PATH=%USERPROFILE%\Documents\Library"

REM Create the Library folder
if not exist "%LIBRARY_PATH%" (
    mkdir "%LIBRARY_PATH%"
    echo Created folder: %LIBRARY_PATH%
) else (
    echo Folder already exists: %LIBRARY_PATH%
)

REM Create About.md with required content
echo Alma Jordan Library > "%LIBRARY_PATH%\About.md"
echo Created About.md

REM Create Algorithm.txt with required content
echo Operating Systems Concepts by Abraham Silberschatz > "%LIBRARY_PATH%\Algorithm.txt"
echo Created Algorithm.txt

echo.
echo Setup complete! Files created in %LIBRARY_PATH%
