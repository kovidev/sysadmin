@rem This script registers svnserve as a service.
@rem You should run this script as Administrator.
@rem For more information, see Docs/how-to-run-subversion-server.md.
sc create svn binpath= "C:\Program Files\CollabNet\Subversion Client\svnserve.exe --service -r E:\KoviProjectSystem\SvnRepo" displayname="Subversion Server" depend=Tcpip start=auto
