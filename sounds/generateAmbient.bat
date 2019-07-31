@echo off
setlocal enabledelayedexpansion enableextensions
set cnt=-1
for %%a in (ambient\*) do (
	set /a cnt+=1
	set names[!cnt!]=%%a
)
set lastindex=%cnt%-1
(
for /L %%f in (0,1,%lastindex%) do (
	echo class ambient%%f
	echo {
	echo     name = "ambient%%f";
	echo     sound[] = {"sounds\!names[%%f]!", 2, 1, 600};
	echo     titles[] = {};
	echo };
  REM echo !names[%%f]! %%f
)
) > ambient.hpp