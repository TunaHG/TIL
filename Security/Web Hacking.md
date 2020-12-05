# Web Hacking

## Basic Theory

웹서버는 기본적으로는 뚫린다는 전제하에 올려둔다는게 맞다. 모든 웹서버는 시기가 문제지 언제든 뚫릴 수 있다.

보통 AWS EC2에 웹 서버, 앱 서버, DB 등을 업로드하는 경우가 많다.
이런 경우 웹 서버가 해킹되면 모든 것들이 해킹된다.

해커의 타겟

* 웹 서버, 서버, DB 서버
  웹 애플리케이션이 구동되는 서버 시스템
  네트워크를 해킹해서 웹 서버의 파일 시스템에 침투하여 정보를 탈취하거나 파괴하기 위한 목적
* 웹 애플리케이션 (nginx, Apache, ...)
  웹 프로그래밍 시스템의 취약점을 이용하여, 권한 없이 무엇인가를 얻고자 함
* 웹 사용자
  타 사용자를 공격하거나 그 권한을 얻고자 함

### Google Hacking

구글의 탭 타이틀을 INTITLE, 구글의 탭 URL을 INURL, 내용을 INTEXT라고 한다.

구글 검색 옵션

* `" "` : 연속되는 글자 (exact matching)
* `+` : 검색문자를 포함 (추천기)
* `-` : 검색 결과에서 제외
  ex) apple -iponhe -computer +fruit : Apple 아이폰 등이 아닌 과일을 검색
* filetype : 파일의 확장자 검색
* site : 도메인 내 검색
* intitle : 타이틀바 텍스트 글자
  다이렉트 목록화, 소스코드를 볼수 있는 취약점 ex) intitle:"index of"
* inurl : 특정 도메인, URL 내 검색
* intext : 일반 본문 텍스트 검색
* numrange : 숫자 범위값 검색

구글 해킹 방어

* Googledork Prevention
  웹 서버 중요 데이터 저장 금지
  웹 서버 임시 파일 저장 금지
  웹 서버와 DB 서버 분리
  잘 알려진 googledork 검색어를 통해 주기적인 보완 (내 서비스에 대해서 주기적으로 검색해서 노출되는 데이터가 있는지 확인)
  https://www.exploit-db.com/google-hacking-database/
  https://www.bishopfox.com/resources/tools/hacking?
* 테스트 도구 (SiteDigger)

bot이 접근하지 못하게 할 수 있다.
다만, 모든 봇이 아예 접근하지 못하도록 하면 내 웹은 공개되지 않는다.
robots.txt 파일로 bot이 접근할 수 있는 한계를 지정할 수 있다.
User-agent는 검색엔진 로봇이름으로 구글(GoogleBot), 네이버(Yeti), 등의 봇이름이 있다.
Allow는 허용하는 사이트이다.
Disallow는 접근을 막는 사이트이다.

웹 서버 시그니처를 가져올 수 있다.
해당 웹 서버가 어떻게 만들어졌는지 알 수 있다. Wappalyzer 크롬 확장프로그램으로 가능하다.

### 실습

박수현 멘토님이 지원해주신 계정으로 AWS 로그인 진행함

```shell
sudo apt update
sudo apt install nginx -y
```

위의 코드를 진행하여 nginx를 설치한다.
AWS EC2의 보안그룹 인바운드 규칙에 HTTP 80 포트를 모든 IP에 대해서 연다.
해당 AWS EC2의 IP주소로 웹에서 접속해보면 nginx의 초기사이트가 등장한다.
여기서 Wappalyzer를 진행해보면 nginx로 만들어진 사이트라는 것이 표시된다. 이 표시를 지울 수 있다.

```shell
sudo vi /etc/nginx/nginx.conf
```

위의 파일로 접근하여 `server_tokens off;`라고 표시된 부분의 주석을 해제하고 저장한 후 나온다.
이제 nginx를 재부팅한 후 확인해본다.
만약 Wappalyzer에서 nginx가 계속 표시된다면 캐싱된 데이터에 존재할 수 있으므로 강력비우기 및 새로고침을 통해 캐시를 비운 후 다시 확인한다.

nginx의 버전을 다른 버전으로 제작했다고 표시할 수도 있다. 다시 nginx의 config파일로 진입한다.

```shell
sudo vi /etc/nginx/nginx.conf
```

아까 주석 해제한 `server_tokens off;` 아래에 `more_set_headers "Server: nginx/2.99.0 (Ubuntu)"`를 추가하고 다시 진행해본다.

이제 php를 설치하여 php도 표시되는지 확인해본다.

```shell
sudo apt install php-fpm -y
```

php가 설치되었으면 nginx에서 php사용 세팅을 주석해제해야 한다.

```shell
sudo vi /etc/nginx/sites-available/default
```

다음 경로의 파일로 진입하여 56~60번째 `location ~`부분의 주석을 해제하고 중괄호에 해당하는 63번째 줄의 주석도 해제한다.
이후 test.php 파일을 생성하여 php 페이지를 호출하도록 만든다.

```shell
sudo vi /var/www/html/test.php
```

`<?php phpinfo(); ?>`를 입력한다.
그리고 이제 AWS EC2의 IP주소를 웹에서 접속하며 /test.php로 접속해본다. phpinfo() 사이트가 나타나면 제대로 된 것이다.
Wappalyzer로 확인해보면 php의 버전은 나타나지 않는다. 왜 나타나지 않는지 살펴본다.

```shell
sudo vi /etc/php/7.2/fpm/php.ini
```

위의 파일을 들어가서 쭉 내려가면서 살펴보다보면 `expose_php = Off`라고 표시된 부분이 나온다. 이 부분덕분에 버전이 표시되지 않는다.
Off로 되어있어야 보안 설정이 높게 되어 좋은 것이다. 5.3버전에서는 해당 코드의 default값이 ON이라 버전이 표시되었는데 7.2에서는 Off라 표시되지 않는다.
On으로 변경하고 다시 살펴보면 버전이 표시된다.

## SSL 인증서

HTTP에서 HTTPS로 변경하려면 인증서를 발급받아야 하며, 1년단위로 10만원이상의 금액이 소모된다.
10년을 HTTP에서 HTTPS로 변경할 수 있도록 무료로 인증서를 발급해주는 곳이 Let's Encrypt이다.
인증서 발급이 무료로 진행되며 보안성이 향상되었지만 해커들에게도 무료로 발급되니 악의적인 사이트를 HTTPS 보안으로 위장한다.
하지만 그래도 보안이 높은 HTTPS로 업그레이드를 해야한다!

내가 만든 IP주소와 도메인이 정상적으로 제 3자에게 인증을 받았다는 증거

### 실습

AWS EC2에서 인증서를 발급받아본다.

```shell
sudo apt install certbot python3-certbot-nginx
```

nginx가 아닌 apache 서버를 이용하는 경우엔 `python3-certbot-apache`를 이용하면 된다.
다음은 이제 인증서를 발급받는다.

```shell
sudo certbot --nginx -d {URL}
```

이메일을 물어본다. 본인 이메일을 적으면 된다. 이후 이용에 동의할 것인지 묻는 첫번째 질문에 A로 답하고 이메일 구독은 N을 눌러 거절한다.
이후에 나오는 1, 2번 질문은 HTTP에서 HTTPS를 강제로 보내줄것인지 아니면 같이 사용할 것인지 묻는다.
2번을 선택하여 redirect하도록 지정한다.
이후 AWS EC2의 보안그룹 인바운드 규칙에서 HTTPS 규칙을 추가한다.
이후 해당 URL로 접근하면 HTTPS로 접근된다. 참고로 AWS에서 Route53으로 발급받아야 한다. EC2에서 ec2~어쩌구 도메인은 에러가 발생한다.

해당 URL로 들어가보면 이제 URL창 왼쪽에 HTTP의 경고표시가 아닌 HTTPS의 자물쇠 표시가 나타난다. 성공!

## OWASP Top 10

Open Web Application Security Project (오픈 웹 애플리케이션 보안 프로젝트 - 커뮤니티)

3~4년 주기마다 발표한다. 2020버전이 존재한다.

### 실습

Burpsuite를 통한 실습

멘토님께 받은 OVA 파일을 활용하여 새로운 VM 생성
설정으로 진입하여 수정 >> 설정 - 네트워크 - 어댑터1 을 호스트 전용 어댑터로 수정

부팅이 완료되면 친절하게 설명이 보임. ID/PW/IP를 알려줌
해당 ID/PW를 입력하고 진입한다음, 보여주는 IP주소를 웹 주소로 입력하여 진입. OWASP 관련 사이트가 보이면 성공.

IP주소 뒤에 `/dvwa`를 입력하면 로그인창으로 이동한다.
user/user로 ID/PW를 입력하고 로그인한다.
해당 사이트는 클라우드나 공개된 퍼블릭 장소에 업로드하면 안된다! 취약한 서버라서 해킹당하면 악성코드 유포지가 될 수도 있다!
그래서 네트워크를 호스트전용어댑터로 수정하여 VM과 PC만 통신하도록 변경한 것

DVWA Security를 통해 현재 서버의 보안성을 변경하고 진행할 수 있다.
Brute Force에서 View Source를 통해 로그인 진행 코드를 확인할 수 있으며 보안성을 변경하며 코드 변경을 확인해본다.
실제 naver등의 사이트에서 해킹하면 범법행위이기 때문에 실습을 위해 DVWA에서 해킹을 진행해본다.

Command Execution에서 진행해본다.
해당 페이지는 IP주소를 입력하여 ping명령어를 확인해보는 경우인데, `127.0.0.1`을 입력해보면 확인이 가능하다.
하지만 이런 기능에서도 `127.0.0.1; cat /etc/passwd`를 입력하면, `;`이후의 명령어가 실행되어 확인이 가능하다.
이런 취약점이 존재한다.





현재 만들어진 서버에 해킹시도가 얼마나 들어왔는지 확인하려면 `sudo lastb`를 실행해본다.

### 취약한 가상머신 설치

### 웹 해킹 실습

### 시큐어 코딩 이해

## Web Service Security

## Web Service 취약점

## Secure Coding

## Why?

## QnA

Q1. 혹시 제 데탑에 웹서버를 실행시켜 놓으면 그 이외의 다른 디렉토리에도 접근할 가능성이 있나요??
A1. 동일한 LAN(공유기)을 사용하는 기기에서는 접근이 가능하다. 하지만 외부에서 접근한다는 것은 아예 다른이야기이다. 공유기에 포트포워딩을 설정해둔다면, 외부에서 접근이 가능해져서 웹에 업로딩한 상태와 똑같아 진다.

Q2. 자신만을 위한 웹 서버를 구축 하려면 방화벽을 설정하면 될까요?
A2. 방화벽으로 방어할 수 있는 것은 한계가 있다. 이는 V3만 설치하면 모든 바이러스를 막냐는 것과 동일한 질문. 서버에 대해서는 방어할 수 있지만 애플리케이션과 사용자에 대해서는 방어해주지 않는다.