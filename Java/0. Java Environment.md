

# Java 개발환경 구축

> 19/12/02에 Windows 10에서 사용할 Java와 Eclipse를 설치하는 과정이다.

---

## 1. Java 설치

### 1. Java 설치파일 다운로드

* [Oracle](https://www.oracle.com/kr/index.html)사이트 접속 후 회원가입

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMjUz/MDAxNTc1MjU4ODQ4MjU3.aYevhwp7BtkhM-MZeqy0ACi-aAt9Z0PPZdA-yj6OZLUg._p6j6CbfF5RtANRUxHLC5RXz-TQyv8d_GojOkUl0h-Ag.PNG.asdf0185/image.png?type=w773)

* [Java Download Site](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) 접속 후 로그인

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMjM1/MDAxNTc1MjU5MzI4MDA0.lTElYV3yz7Y_sau6VqSPKm7-tv6ez_T8tQRnD0-LxaMg.AlOpSThel-XyfXcMHBIG3f0CyhXaG4IUeWoucas_9mEg.PNG.asdf0185/image.png?type=w773)

  * 현재 운영체제가 Windows 64비트이므로 맨 아래 파일을 다운로드받는다.

### 2. Java 다운로드

> Oracle사이트에서 다운로드받은 설치파일을 실행한다.
>
> 별도의 설정변경없이 Next를 눌러 Install을 진행한다.

## 2. Eclipse 설치

### 1. Eclipse 파일 다운로드

* [Eclipse Download Site](https://www.eclipse.org/downloads/) 접속 후 Download Package 클릭

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMTc2/MDAxNTc1MjYwMTk2ODU4.5hwxOvU7EkflGgOIXecw5JKYb4ncPQXxYilEVCcwMEkg.A2GUTMXTVwpvRFGP893TKfuBb7bryOTh3s3zPWRosGcg.PNG.asdf0185/image.png?type=w773)

* 원하는 버전을 선택하고 Download

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMTY0/MDAxNTc1MjYwMzY5NTA1.j1_xmx31jy-5nOnj9afPuACxjHgkagE2CI3nlk2KZEAg.TVJNstU6o7TB8_Y5ozfHkQNu4M2TbhglQRYxra0qzAgg.PNG.asdf0185/image.png?type=w773)

  * 우측 아래의 `MORE DOWNLOAD` 에서 `2019-03`버전을 다운로드 받는다.
  * `Eclipse IDE for EnterPrise Java Developers`의 Windows 64-bit를 다운로드 받는다.

* 다운로드받은 압축파일을 해제하면 `Eclipse`파일이 존재한다.

## 3. Java 환경변수 설정

> 명령프롬프트 창에서 Java를 실행할 수 있게 해주는 환경변수를 설정한다.

### 1. 시스템 환경 변수 

* 윈도우 검색에서 `환경 변수`를 검색한다.

  * `시스템 환경 변수 편집`을 클릭

* 환경 변수 버튼을 클릭

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMTEx/MDAxNTc1MjYwNzMzMTk0.KouR_7r8CgBvalKN5x_20H-4g7Ubs3wIjcE-qhBFlcwg.eTKB4naD-rEFRzWI8fjtW7hRZM-dIkL6bMum3sizVQog.PNG.asdf0185/image.png?type=w773)

* 시스템 변수의 `새로 만들기` 버튼 클릭

  ![img](https://postfiles.pstatic.net/MjAxOTEyMDJfMjc2/MDAxNTc1MjYwNzY4NDMz.WZAkLrYmIxtasdn3JPKGt_xoQMPK7BQrvOIKnpcJhTsg.VfP2dUZ0Wn4XqjJZZOccTsNqWt5TXLgpPfHNXE-mkbwg.PNG.asdf0185/image.png?type=w773)

* JAVA_HOME 생성

  ![image-20191216162533297](C:\Users\student\AppData\Roaming\Typora\typora-user-images\image-20191216162533297.png)

  * 변수 이름은`JAVA_HOME`으로 설정, 변수 값은 `Jdk가 설치된 경로`로 설정.

* Path에 `%JAVA_HOME%\bin`경로 추가

  ![image-20191216162658812](C:\Users\student\AppData\Roaming\Typora\typora-user-images\image-20191216162658812.png)

### 2. 명령프롬프트 창에서 확인

  > 명령프롬프트 창은 Windows 실행창에서 cmd를 입력하면 실행할 수 있다.

* `java` 명령어를 입력했을 때 다음과 같은 결과가 나타나면 성공.

  ![image-20191216162921805](C:\Users\student\AppData\Roaming\Typora\typora-user-images\image-20191216162921805.png)