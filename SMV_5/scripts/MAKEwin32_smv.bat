@echo off

Rem  Windows batch file to build Smokeview for all platforms.
Rem  This script builds LInux and OSX Smokeview's by doing a
Rem  remote shell (plink) to the NIST Linux cluster.

Rem setup environment variables (defining where repository resides etc) 

set envfile=c:\bin\fds_smv_env.bat
IF EXIST %envfile% GOTO endif_envexist
echo ***Fatal error.  The environment setup file %envfile% does not exist. 
echo Create a file named %envfile% and use SMV_5/scripts/fds_smv_env_template.bat
echo as an example.
echo.
echo Aborting now...
pause>NUL
goto:eof

:endif_envexist

call %envfile%

%svn_drive%
cd %svn_root%\smv_5\scripts
set version=%smv_version%_%smv_revision%

set scriptdir=FDS-SMV/SMV_5/scripts
set bundledir=FDS-SMV/SMV_5/for_bundle

call make_smv_release_win32.bat %version%

echo uploading Windows Smokeview files
pscp  ..\for_bundle\smokeview_release.exe %svn_logon%:%bundledir%/.
pscp  ..\for_bundle\smokezip_release.exe %svn_logon%:%bundledir%/.

echo win32 Smokeview build finished
pause
