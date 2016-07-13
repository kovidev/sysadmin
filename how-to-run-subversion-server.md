# 목적

이 문서는 서브버전 서버를 구동하는 법을 다룹니다.
서브버전은 여러 프로토콜을 지원합니다.
하지만 이 문서는 오직 svn:// 프로토콜만 지원하는 방법만을 다룹니다.
만약 http://나 https:// 프로토콜을 지원해야 한다면, Subversion Edge나 VisualSVN사용법을 참고하세요.


# 설치

서브버전 서버를 구동하려면 서브버전 명령행 바이너리를 내려받아야 합니다.
아래 주소에서 Subversion을 선택하고 설치합니다.

http://www.collab.net/downloads/subversion

설치 폴더(C:\Program Files\CollabNet\Subversion Client)에 svnadmin.exe, svnserve·exe가 있다면 설치가 올바로 된 것입니다.

콘솔 창을 열어서 아래 명령을 내립니다.

```
svnserve
```

정상 설치를 했다면 다음과 같은 메시지가 뜹니다.

> You must specify exactly one of -d, -i, -t, --service or -X.
> Type 'svnserve --help' for usage.

만약 아래와 같은 에러 메시지가 뜬다면 서브버전 설치 경로가 환경 변수 PATH에 없는 것입니다.
제어판 > 시스템 > 고급 시스템 설정 > 환경 변수 > 시스템 변수에서 PATH 항목을 찾아 서브버전 설치 경로를 추가합니다.

> 'svnserve'은(는) 내부 또는 외부 명령, 실행할 수 있는 프로그램, 또는 배치 파일이 아닙니다.


# 시험 구동

콘솔 창에서 아래와 같이 명령을 내립니다.

```
svnserve -d -r 저장소-루트-디렉터리
```

2016년 7월 8일 기준으로 저장소 루트 디렉터리는 E:\KoviProjectSystem\SvnRepo 입니다.

TortoiseSVN과 같은 도구를 써서 서브버전 서버가 정상 동작하는지 확인합니다.


# 서비스 등록

위 명령으로 서브버전 서버를 구동할 수 있습니다.
하지만 PC를 켤 때마다 콘솔 창에서 명령을 내려야 하는 단점이 있습니다.
이 문제를 해결하려면 svnserve를 서비스로 구동해야 합니다.

콘솔 창을 열어서 아래 명령을 내립니다.

```
sc create svn
    binpath= "C:\Program Files\CollabNet\Subversion Client\svnserve.exe --service -r C:\repos"
    displayname= "Subversion Server"
    depend= Tcpip
    start= auto
```

svnserver.exe 경로는 환경에 따라 다를 수 있습니다.

제어판 > 관리도구 > 서비스를 선택합니다.
목록에 Subversion Server가 있다면 서비스가 제대로 설치된 것입니다.
