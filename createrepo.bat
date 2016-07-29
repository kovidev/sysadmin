@echo off

rem Run the powershell script has the same file name.
rem For more information see http://www.howtogeek.com/204088/how-to-use-a-batch-file-to-make-powershell-scripts-easier-to-run/
Powershell.exe -Command "& '%~dpn0.ps1' -Skeleton repository-skeleton"
pause


