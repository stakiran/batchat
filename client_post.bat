@echo off
setlocal

:LOOP
set /p tweet="What are you doing? > "
call %~dp0post.bat %tweet%
if %errorlevel% equ 0 (
	goto :LOOP
)
exit /b
