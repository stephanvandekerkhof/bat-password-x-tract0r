@echo off
color 0a
mode 999,999
TITLE Password x-tract0r v0.04
setlocal enabledelayedexpansion
echo Password x-tract0r v0.04&&echo.
set STARTDATETIME=%DATE% %TIME%
set SPEECHMODE=0

for /r "%CD%" %%a IN (*) do (
echo Scanning in %%~nxa ^(%%a^) ...
if [%SPEECHMODE%]==[1] dspeech.exeHidden /Speak Scanning in %%~nxa

for /f "tokens=2 delims=:" %%i in (%%a) do (
@echo off
echo Password x-tract0r v0.04 found: %%~nxa pwd: %%i
echo %%i>>pwd.txt
)

echo Done with "%%a"

sort pwd.txt | uniq >> pwd_uniq_sorted.txt

find /v /c "" < "pwd_uniq_sorted.txt" > tmp
set /p nr1=<tmp

find /v /c "" < "pwd.txt" > tmp
set /p nr4=<tmp

echo !nr4! passwords found. comparing with previous results ...
if [%SPEECHMODE%]==[1] dspeech.exeHidden /Speak !nr4! passwords found. comparing with previous results

sort pwd_uniq_sorted.txt | uniq > pwd_uniq_sorted_final.txt

find /v /c "" < "pwd_uniq_sorted_final.txt" > tmp
set /p nr2=<tmp

if exist tmp del tmp
set /a nr3=!nr1!-!nr2!

echo !nr3! new passwords found. Total harvest: !nr2!
if [%SPEECHMODE%]==[1] dspeech.exeHidden /Speak !nr3! new passwords found. Total harvest !nr2!
if [%SPEECHMODE%]==[0] timeout 3

if exist pwd_uniq_sorted.txt del pwd_uniq_sorted.txt
if exist pwd.txt del pwd.txt
ren pwd_uniq_sorted_final.txt pwd_uniq_sorted.txt

)

find /v /c "" < "pwd_uniq_sorted.txt" > tmp
set /p nr1=<tmp

echo.
echo Start: %STARTDATETIME%
echo Ended: %DATE% %TIME%
echo Unique passwords extracted: %nr1%
echo.
echo Data extraction operation completed.
start "" if [%SPEECHMODE%]==[1] dspeech.exeHidden /Speak Data extraction operation completed. Found %nr1% unique passwords
echo.
pause
if exist tmp del tmp
