# LF will be replaced by CRLF Error

```bash
warning: CRLF will be replaced by LF in some/file.file.
The file will have its original line endings in your working directory.
```

> 위와같은 `Error`혹은 `LF`와 `CRLF`의 위치가 바뀐 `Error`를 가끔 확인할 수 있다.

> 이는 맥 또는 리눅스 개발자와 윈도우 개발자가 Git을 이용하여 협업할 경우 발생하는 **Whitespace**에러다.
>
> UNIX 시스템에서는 한 줄의 끝이 `LF(Line Feed)`로 끝나는 반면, Windows에서는 줄 하나가 `CR(Carriage Return)`과 `LF(Line Feed)`가 합친 CRLF로 이루어지기 때문이다.

## 해결방법

> Git에서는 자동으로 이를 변환해주는 기능을 가지고 있다.
>
> core.autocrlf 기능이 바로 그것이며 true값을 입력하여 켜주면 된다. 이 기능은 개발자가 Git에 코드를 추가할 때는 CRLF를 LF로 변환해주며, Git의 코드를 개발자가 가져올 때는 LF를 CRLF로 변환해준다.

```bash
$ git config --global core.autocrlf true
```

* 맥 또는 리눅스를 사용하는 경우 Git의 코드를 가져올 때 LF를 CRLF로 변환하는 것을 원치 않으면 뒤에 input이라는 명령어를 추가함으로써 Git에 코드를 추가할 때만 변환하도록 할 수 있다.

```bash
$ git config --global core.autocrlf true input
```

* 또는 변환하는 것을 원하지 않지만 에러 메시지를 보기 싫을 경우에는 경고메시지 기능을 꺼주면 된다

```bash
$ git config --global core.safecrlf false
```



## 참고사항

* `--global`은 시스템 전체를 얘기하는 `parameter`다. 특정 프로젝트에만 적용하고 싶다면 `--global`을 제외하고 명령어를 입력해주면 된다.