@echo off
setlocal EnableDelayedExpansion
set cnt=0
set waitunit=200
set waitmin=10

:LOOP
set /a waitmsec=%random%%%%waitunit%+%waitmin%
%~dp0sleep.exe %waitmsec%
set /a cnt=%cnt%+1
set tweet="try%cnt%"
echo %tweet%
call %~dp0post.bat %tweet%
if %errorlevel% equ 0 (
	rem ping localhost -n 2 > nul
	goto :LOOP
)
exit /b
