:start
@echo off
@title Ping Commands Organiser 
COLOR F0
cls
mode con: cols=65 lines=35

echo - %~dp0
echo:
echo:
echo - Ping Commands Organiser 
echo:
echo - Type in the number corresponding to the desired destination.
echo -----------------------------------------------------------------
echo - 1. Find IP-Adress or Hostename availability
echo - 2. Find IP-Adress or Hostename availability from a list
echo - 3. Find IP-Adress or Hostename availability from a given range
echo -----------------------------------------------------------------
echo: 
echo:
echo _________________________by Pedro_______________________________
echo:




set/p var1=
if %var1% == 1 goto ipping
if %var1% == 2 goto iplist
if %var1% == 3 goto rangeping
exit


rem------------------------------------------------------------------------------------------------


:ipping
COLOR F0
cls

echo - Enter the IP-Adress or Hostename you'd like to test
set /p IPPING=
cls

ping -n 1 %IPPING% >nul && (echo - Ping Successful!) || (echo - Ping Failed!)
echo:

>Document_%date%.txt (ping -a -n 1 %IPPING%) 

for /f "tokens=1-2,5,6" %%i in (Document_%date%.txt) do if "%%l" == "mit" (
echo - Hostename not available for %IPPING% 
) else ( 
if "%%i"=="Ping" echo - IP-Adress: %%l ---------- Hostename: [%%k]
)

Del Document_%date%.txt

echo:
echo:
echo:
echo - Task Complete!
echo:
echo:
echo:
echo - Press any key to clear the screen!

pause > nul
cls

Goto end

exit


rem------------------------------------------------------------------------------------------------

:iplist
COLOR F0
cls

echo - Enter the name of the document you'd like us to use 
echo - (make sure to introduce doc. type as well)                                          

echo  [File must be placed under %~dp0]                                                                                                                                                      
set /p DOCNM=
cls

echo - Note: the longer the list the longer the loading time
echo - Loading...     
echo:


>Document_%date%.txt ( 
for /f "delims=" %%a in (%DOCNM%) do ping -a -n 1 %%a
)
for /f "tokens=1-2,5,6" %%i in (Document_%date%.txt) do if "%%l" == "mit" (
echo - No Hostname for %%k found
) else ( 
if "%%i"=="Ping" echo - IP-Adress: %%l ---------- Hostename: [%%k]
)




echo:
echo:
echo -----------------------------Complete----------------------------
echo:
echo - Would you like to save this in a seperate document [y,n] ?

set/p var2=
if %var2% == y goto filsav
if %var2% == n (
Del Document_%date%.txt
goto end
)


:filsav
cls
echo - Choose a file name(it will automatically be a .txt file)
set/p FILNAM=

>%FILNAM%.txt (
for /f "tokens=1-2,5,6" %%i in (Document_%date%.txt) do if "%%l" == "mit" (
echo - No Hostname for %%k found
) else ( 
if "%%i"=="Ping" echo - IP-Adress: %%l ---------- Hostename: [%%k]
)
)
cls
echo - File Saved
timeout /t 1 > nul

Del Document_%date%.txt
goto end


rem------------------------------------------------------------------------------------------------
:rangeping
echo off
cls
SET /p IPrange=IP-Range(xxx.xxx.xxx) :
SET /p startIP=Starting IP :
SET /p endIP=End IP :
cls

>IPlist.txt (
for /l %%i in (%startIP%,1,%endIP%) do (
echo %IPrange%.%%i
) 
)

cls

echo - Note: the longer the list the longer the loading time
echo - Loading...     
echo:


>Document_%date%.txt ( 
for /f "delims=" %%a in (IPlist.txt) do ping -a -n 1 %%a
)


for /f "tokens=1-2,5,6" %%i in (Document_%date%.txt) do if "%%l" == "mit" (
echo - No Hostname for %%k found
) else ( 
if "%%i"=="Ping" echo - IP-Adress: %%l ---------- Hostename: [%%k]
)

echo:
echo:
echo -----------------------------Complete----------------------------
echo:
echo - Would you like to save this in a seperate document [y,n] ?

set/p var2=
if %var2% == y (
Del IPlist.txt
goto filsav
)
if %var2% == n (
Del Document_%date%.txt
Del IPlist.txt 
goto end
)
exit

rem------------------------------------------------------------------------------------------------
:end
COLOR F0
cls
echo - Are you finished using the programm [y,n]?


set/p var1=
if %var1% == y goto exiting
if %var1% == n goto start


rem------------------------------------------------------------------------------------------------


:exiting 
COLOR F0
cls
echo Thank you for giving my programm a try!
timeout /t 2 > nul
cls
Echo Goodbye!
timeout /t 1 > nul

exit
