 @echo off
 :: Stops commits that have empty log messages.
 @echo off

 setlocal

 rem Subversion sends through the path to the repository and transaction id
 set REPOS=%1
 set TXN=%2

 svnlook log %REPOS% -t %TXN% | findstr . > nul
 if %errorlevel% gtr 0 (goto err) else exit 0

 :err
 echo Your commit has been blocked because you didn't enter a comment. Write a log message describing the changes made and try again. 1>&2
 exit 1