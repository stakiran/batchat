@echo off
setlocal

set outdir=%~dp0
set outpath=%outdir%chatdata.txt
set ret_continue=0
set ret_end=1

set tweet=%*

if "%tweet%"=="" (
	exit /b %ret_continue%
)
if "%tweet%"=="quit" (
	exit /b %ret_end%
)
rem lockfileがあったらなくなるまで待つ.
rem できればミリ秒スリープ使いたいがバッチだけじゃ無理だよなぁ...
:LOCKLOOP
call :DOES_LOCKFILE_EXISTS
if %ret% equ 1 (
	echo Other locking exists, please wait...
	ping localhost -n 1 > nul
	goto :LOCKLOOP
)

rem lockfileをつくる
call :DATETIMESTR
set lockfilepath=%outdir%locking_by_%username%_at_%curdatetime%.lock
copy nul %lockfilepath% 1>nul

rem 書き込み
echo %date% %time% %username%「%tweet%」 >> %outpath%

rem lockfileを消す
del %lockfilepath%

exit /b %ret_continue%

rem @retval 1 Exists.
rem @retval 0 Not exists.
:DOES_LOCKFILE_EXISTS
dir %outdir%*.lock 1>nul 2>nul
if "%errorlevel%"=="0" (
	set ret=1
	exit /b
)
set ret=0
exit /b

:DATETIMESTR
set curdate=%date%
set curdate=%curdate:/=%
set curdate=%curdate:~2,6%
set curtime=%time%
set curtime=%curtime: =0%
set curtime=%curtime::=%
set curtime=%curtime:.=%
set curtime=%curtime:~0,8%
set curdatetime=%curdate%_%curtime%
exit /b
