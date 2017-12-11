@echo off
color 0a
mode 999,999
TITLE Password x-tract0r v0.04
setlocal enabledelayedexpansion
echo Password x-tract0r v0.04&&echo.
set STARTDATETIME=%DATE% %TIME%
set SPEECHMODE=1


for /r "%CD%" %%a IN (test-data\*) do (
echo Scanning in %%~nxa ^(%%a^) ...
if [!SPEECHMODE!]==[1] dspeech.exe /Hidden /Speak Scanning in %%~nxa

for /f "tokens=2 delims=:" %%i in (%%a) do (
@echo off
echo Password x-tract0r v0.04 found: %%~nxa pwd: %%i
echo %%i>>pwd.txt
)

find /v /c "" < "pwd_uniq_sorted.txt" > tmp
set /p nr4=<tmp
if not exist pwd_uniq_sorted.txt set nr4=0

echo Done with "%%a"

find /v /c "" < "pwd.txt" > tmp
set /p nr1=<tmp

sort pwd.txt | uniq >> pwd_uniq_sorted.txt

find /v /c "" < "pwd_uniq_sorted.txt" > tmp
set /p nr2=<tmp

sort pwd_uniq_sorted.txt | uniq > pwd_uniq_sorted_final.txt

find /v /c "" < "pwd_uniq_sorted_final.txt" > tmp
set /p nr3=<tmp

set /a nr5=!nr3!-!nr4!

echo !nr1! passwords found inside %%~nxa.
echo !nr5! new de-duplicated entries added.
echo !nr2! total unique passwords found.
if [!SPEECHMODE!]==[1] dspeech.exe /Hidden /Speak !nr1! passwords found in %%~nxa. Added !nr5! new de duplicated entries. Total unique passwords found !nr2!
if [!SPEECHMODE!]==[0] timeout 3

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
if [%SPEECHMODE%]==[1] dspeech.exe /Hidden /Speak Data extraction operation completed. Found %nr1% unique passwords
echo.
pause
if exist tmp del tmp