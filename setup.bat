@echo off
REM INFO 3601 Assignment 1 - Question 1
REM This script creates a Library folder in the Documents directory
REM Works for any user and from any location

REM Define the Library path in the user's Documents folder
set LIBRARY_PATH=%USERPROFILE%\Documents\Library

REM Create the Library directory if it doesn't exist
if not exist "%LIBRARY_PATH%" (
    mkdir "%LIBRARY_PATH%"
    echo Created Library folder at: %LIBRARY_PATH%
) else (
    echo Library folder already exists at: %LIBRARY_PATH%
)

REM Create About.md file with content
echo Alma Jordan Library > "%LIBRARY_PATH%\About.md"
echo Created About.md

REM Create Algorithm.txt file with content
echo Operating Systems Concepts by Abraham Silberschatz > "%LIBRARY_PATH%\Algorithm.txt"
echo Created Algorithm.txt

echo.
echo Setup completed successfully!
echo Library folder created at: %LIBRARY_PATH%
pause
