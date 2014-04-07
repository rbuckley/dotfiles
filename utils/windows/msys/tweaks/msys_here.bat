@echo off
rem Copyright (C): 2001, 2002, 2003, 2004, 2005 Earnie Boyd
rem mailto:earnie@users.sf.net
rem This file is part of Minimal SYStem
rem http://www.mingw.org/msys.shtml
rem
rem File: msys.bat
rem Revision: 2.4
rem Revision Date: December 8th, 2005

rem ember to set the "Start in:" field of the shortcut.
rem A value similar to C:\msys\1.0\bin is what the "Start in:" field needs
rem to represent.


if NOT "x%WD%" == "x" set WD=

if NOT EXIST %WD%msys-1.0.dll set WD=%~dp0\bin\

set MSYSCON=unknown
if NOT "x%MSYSCON%" == "xunknown" shift
if "x%MSYSCON%" == "xunknown" set MSYSCON=sh.exe

if "x%MSYSTEM%" == "x" set MSYSTEM=MINGW32

if NOT "x%DISPLAY%" == "x" set DISPLAY=

if "x%MSYSCON%" == "xsh.exe" goto startsh

:unknowncon
echo %MSYSCON% is an unknown option for msys.bat.
pause
exit 1

:notfound
echo Cannot find the sh.exe binary -- aborting.
pause
exit 1

:startsh
if NOT EXIST %WD%sh.exe goto notfound
start %WD%sh --login -i -c "cd "%1";exec sh"
exit

:EOF
