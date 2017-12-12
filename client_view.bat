@echo off
setlocal

rem I think this params should be separate to an independent file.
set outdir=%~dp0
set outpath=%outdir%chatdata.txt

set intervalsec=5
powershell -Command "Get-Content %outpath% -Wait -Tail %intervalsec%"
exit /b
