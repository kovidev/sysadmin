@echo off

rem go to the directory in which this batch file is located
pushd %~dp0

rem create a bare repository.
set /P repo="Please enter the name of repository: "
svnadmin create %repo%
xcopy /Y conf-skeleton %repo%\conf

rem initialize the standard subversion directory structure
pushd %temp%
	svn co svn://dev.kovi.com/%repo%
	pushd %repo%
		svn mkdir trunk branches tags
		svn ci --username taemin --password "kovi&*()7890" -m "Initialized the repository structure."
	popd
popd

pause