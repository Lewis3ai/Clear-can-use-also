@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

IF NOT EXIST "%~dp0calc.exe" (
  echo ERROR: calc.exe not found in %~dp0
  echo Compile billing.c into calc.exe and place it here.
  pause
  exit /b 1
)

REM Loop through each directory in current folder
for /d %%D in (*) do (
  if exist "%%D\data.txt" (
  echo USERNAME: %USERNAME%> "%%D\receipt.txt"
  echo DATE: %DATE% %TIME%>> "%%D\receipt.txt"
  echo.>> "%%D\receipt.txt"
  echo --- BILLING RECEIPT --- >> "%%D\receipt.txt"
  "%~dp0calc.exe" < "%%D\data.txt" >> "%%D\receipt.txt"
  if errorlevel 1 (
    echo ERROR: calc.exe failed for %%D>> "%%D\receipt.txt"
  )
  echo ---------------------- >> "%%D\receipt.txt"
  echo Created receipt for %%D
  )
)

ENDLOCAL
echo Done.
