# Web Hacking

## Basic Theory

웹서버는 기본적으로는 뚫린다는 전제하에 올려둔다는게 맞다. **모든 웹서버는 시기가 문제지 언제든 뚫릴 수 있다.**

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

구글의 탭 타이틀을 **INTITLE**, 구글의 탭 URL을 **INURL**, 내용을 **INTEXT**라고 한다.

**구글 검색 옵션**

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

**구글 해킹 방어**

* Googledork Prevention
  웹 서버 중요 데이터 저장 금지
  웹 서버 임시 파일 저장 금지
  웹 서버와 DB 서버 분리
  잘 알려진 googledork 검색어를 통해 주기적인 보완 (내 서비스에 대해서 주기적으로 검색해서 노출되는 데이터가 있는지 확인)
  https://www.exploit-db.com/google-hacking-database/
* 테스트 도구 (SiteDigger)

bot이 접근하지 못하게 할 수 있다.
다만, 모든 봇이 아예 접근하지 못하도록 하면 내 웹은 공개되지 않는다.
**robots.txt** 파일로 bot이 접근할 수 있는 한계를 지정할 수 있다.
User-agent는 검색엔진 로봇이름으로 구글(GoogleBot), 네이버(Yeti), 등의 봇이름이 있다.
Allow는 허용하는 사이트이다.
Disallow는 접근을 막는 사이트이다.

웹 서버 **시그니처**를 가져올 수 있다.
해당 웹 서버가 어떻게 만들어졌는지 알 수 있다. Wappalyzer 크롬 확장프로그램으로 가능하다.

### 실습

박수현 멘토님이 지원해주신 계정으로 AWS 로그인 진행함,  AWS EC2를 생성하여 과정을 진행함

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

OWASP ZAP(Zed Attack Proxy)를 사용하면 내 웹사이트에 존재하는 취약점을 알 수 있다.

### 실습

#### Burpsuite

Burpsuite **Community Edition을 다운로드** 받아서 진행한다.
Burpsuite은 Proxy를 통한 네트워크 트래픽 중계로 **중간에서 패킷 위변조**를 진행해볼 수 있다.

Burpsuite를 실행하면, 설정화면 두개가 나온다. 설정값 변경없이 다음을 진행하여 Burpsuite를 실행하면 된다.
Proxy => Option 으로 들어가서 127.0.0.1:8080 기본값이 설정되어 있는 것을 확인한다. 
또한 **Firefox를 사용하여 프록시를 진행**할 것이다. 파이어폭스 설정에서 일반 탭 맨 밑의 네트워크 설정에서 프록시를 수동프록시로 변경한다.
HTTP 프록시와 HTTPS 프록시를 127.0.0.1의 포트8080 으로 변경한다.
설정을 완료한 후 파이어폭스에서 새로고침을 하면 로딩만 가고 페이지가 안뜬다. 현재 Burp의 기본값이 intercept 모드이므로 버프에서 대기하고 파이어폭스로 전달이 안되고 있는 상태기 때문이다.
**intercept 탭**에서 intercept is off로 클릭하여 변경하면 파이어폭스에서 제대로 뜨게 된다.
**HTTP history 탭**을 보면 어떤 요청들이 지나갔는지 과거 기록을 살펴볼 수 있다.

intercept를 활용하여 패킷을 변조할 수 있다. 다시 intercept is on으로 켜주고 DVWA의 Brute Force에서 로그인을 진행해보면 로그인 요청이 어떻게 진행되는지 Burp에서 확인가능하다. 해당 요청에서 값을 변경할수도 있다.
Brute Force 사이트에서는 ID/PW를 aaaa/aaaa로 요청했으나 intercept한 Burp에서 user/user로 수정한 후 Forward를 누르면 user로 로그인이 성공한다.

**Target 탭**의 **Site map 탭**을 보면 brute사이트로 요청한 것을 확인할 수 있다. 이 부분에서 우클릭하여 **Send to Intruder**를 클릭한다.
Intruder 탭을 살펴보면 아래 탭에 **Positions**이 보인다. 이 탭에서 자동으로 변경 가능한 것들을 표시해준다.
username과 password를 제외한 부분을 범위잡아서 우측의 Clear로 제거하고, **Attack Type을 Cluster bomb로 변경**한다.
**Sniper**는 한 필드만 공격하는 타입이고 **Cluster bomb**는 2개 이상을 변조해서 공격하는 타입이다.
다음으로 Payloads 탭으로 넘어가보면 Payload set에 1, 2번만 보이게된다. 3~6번은 Clear로 지워서 1, 2번만 남았기 때문이다.
1번의 Payload Option에 user를 추가한다. 2번은 payload type을 **Brute forcer**로 변경하고 payload option에서 character set을 user로 변경한다.
다음으로 **Start Attack**을 눌러보면 커뮤니티버전에서는 속도가 느리다는 경고표시가 나오고 넘어가면 Brute force를 진행한다.
현재는 성공과 실패를 구분하지 않기 때문에 **Length를 확인**하여 다른 Length인 것을 체크하며 성공과 실패를 확인한다.
이를 구분하기 위해서는 **Option 탭의 Grep-Match** 부분을 Clear로 전부 비워주고 Welcome이라는 단어를 추가해준다면 welcome 문자열을 인식하여 존재한다면 체크되고 없다면 체크가 안되는 식으로 성공과 실패를 구분할 수 있다.

이런식으로 요청을 가로채서 파일을 생성할 수도 있다.
**Command Execution**에서 진행한다.
위와 동일하게 해당 사이트의 요청에 대해서 Burp에서 Intercept한다. `/dvwa/vulnerabilities/exec`와 같은 사이트를 가져오면 역시 Send to Intruder를 한다.
Intruder에서는 받은 데이터에 대하여 Positions 탭에서 15번째 Line의 `ip=$$`에 해당하는 부분을 제외하고는 전부 Clear한다.
Payloads 탭으로 이동하여 Payload Option에 다음을 추가한다.
`1 | echo > phpinfo.php`
`1 | chmod 777 phpinfo.php`
`1 | echo "<?php phpinfo(); ?>" >> phpinfo.php`
이후 Start Attack으로 공격을 시도한 뒤 끝나고 Command Execution의 URL 뒤에 `/phpinfo.php`를 추가해보면 phpinfo 사이트가 나타난다.
해당 사이트를 공격을 통해 추가한 것이다. 해당 서버의 파일시스템을 확인해보면 `/var/www/dvwa/vulnerabilities/exec`로 이동하여 확인하면 phpinfo.php파일이 존재하는 것을 확인할 수 있다.

#### DVWA

멘토님께 받은 OVA 파일을 활용하여 새로운 VM 생성
설정으로 진입하여 수정 >> 설정 - 네트워크 - 어댑터1 을 호스트 전용 어댑터로 수정

부팅이 완료되면 친절하게 설명이 보임. ID/PW/IP를 알려줌
해당 ID/PW를 입력하고 진입한다음, 보여주는 IP주소를 웹 주소로 입력하여 진입. OWASP 관련 사이트가 보이면 성공.

IP주소 뒤에 `/dvwa`를 입력하면 로그인창으로 이동한다.
user/user로 ID/PW를 입력하고 로그인한다.
해당 사이트는 **클라우드나 공개된 퍼블릭 장소에 업로드하면 안된다**! 취약한 서버라서 해킹당하면 악성코드 유포지가 될 수도 있다!
그래서 네트워크를 호스트전용어댑터로 수정하여 VM과 PC만 통신하도록 변경한 것이다.

DVWA Security를 통해 현재 서버의 보안성을 변경하고 진행할 수 있다.
Brute Force에서 View Source를 통해 로그인 진행 코드를 확인할 수 있으며 보안성을 변경하며 코드 변경을 확인해본다.
실제 naver등의 사이트에서 해킹하면 범법행위이기 때문에 실습을 위해 DVWA에서 해킹을 진행해본다.

**Brute Force을 활용한 해킹**

Brute Force에서 admin계정의 비밀번호를 **Bruter**를 이용해서 알아내본다.
Bruter를 먼저 다운로드 받는다. Bruter로 구글에서 검색하면 sourceforge라는 사이트에서 받을 수 있다.
Bruter에서 **Target을 OWASP의 VM IP**로 지정하고 **Protocol을 Web form**으로 지정한다.
프로토콜 우측의 **Option**을 눌러 Target Page를 Brute force사이트(`http://{IP}/dvwa/vulnerabilities/brute`)로 지정한다.
이후 Password Modes에서 Dictionary의 체크를 해제하고, Brute force를 체크하고 Option을 누른다.
이 절차는 보통 비밀번호를 자신이 아는 단어를 이용하는 경우가 많기 때문에 단어사전을 이용하는지 체크하는 부분인데, 단어사전을 제외하고 모든 경우의 수를 탐색하는 Brute force로 진행할 것이기 때문에 체크 표시를 변경한다.
그렇게 설정하고 우측위의 Start를 누르면 에러가 발생한다.

이 에러는 **로그인이 필요하다는 경고**이다. `/dvwa`로 진행할 때 초기에 로그인을 했던 것을 기억한다.
이 로그인 세션 없이 진행하면 해당 URL로 접속했을 때 로그인창이 나타나기 때문에 발생하는 에러이다. 해당 로그인이 진행되었다는 세션값을 Cookie로 넘겨줘야한다.
Protocol의 우측 Option을 클릭한 후 **Cookie**부분을 채워줘야한다.
Firefox에서 찾아보면, `F12`를 눌러 개발자 창을 띄운 후 저장소의 쿠키를 확인한다. PHPSESSID와 security를 찾아서 작성한다.
`PHPSESSID=gbvqdsj4s7n1t3n4d482mb8pn6; security=low`와 같이 작성될 것이다.
다음은 QueryString을 채워야한다. 로그인을 진행할 때 필요한 값은 username과 password이다.
Brute force사이트에서 View Source를 살펴보면 어떤 값들이 필요한지 알 수 있다. 이 값들을 이용하여 채워준다.
`username=%username%&password=%password%&Login=Login`와 같이 채워주면 된다.
그리고 아래의 response test를 살펴보면, 성공하거나 실패했을 때 어떤 결과가 나올지 작성할 수 있다.
체크표시를 하지말고 성공했을 때 표시되는 `Welcome to the`를 작성해준다.
이후 Web Form Option을 OK를 눌러 벗어나서 Start로 진행해본다.

너무 오랜시간이 걸린다 싶으면 Brute force의 옵션 중 Custom으로 admin 다섯개의 알파뱃만 사용하는 모든 경우의 수를 탐색하도록 설정해본다.

**Brute Force를 활용한 해킹 방어**

어떠한 방식으로 이러한 해킹을 방어할 수 있을까?

우선 **로그인 시도마다의 지연시간을 대입**하는 방법이 있다.
한번 로그인이 실패하면 다음 로그인까지 delay를 주어서 오랜 시간이 걸리게 만드는 방법이다.

다음은 **CAPCHA 등의 다른 인증수단을 받는 방법**이다.
여러번 로그인이 실패하면 인증을 통해 다음 로그인을 시도할 수 있도록 설정하는 방법이다.

마지막으로 **암호를 어렵게 설정하도록 하는 방법**이다.
대소문자를 구분하고 특수문자가 들어가도록 하거나 암호의 길이를 길게 설정하는 것이다.
전체를 탐색하는데 걸리는 시간이 늘어나기 때문에 방어할 수 있다.

이처럼 Brute force로 찾는 시간을 늘리면, 해킹 서버에 부하가 걸릴 수 있기 때문에 시간을 늘리는 방법도 유효하다.

DVWA Security의 level을 올려보며 Brute Force의 View Source를 살펴보면 이러한 설정들이 적용되는 것을 확인할 수 있다.

**Command를 활용한 해킹**

Command Execution에서 진행해본다.
해당 페이지는 IP주소를 입력하여 ping명령어를 확인해보는 경우인데, `127.0.0.1`을 입력해보면 확인이 가능하다.
하지만 이런 기능에서도 `127.0.0.1; cat /etc/passwd`를 입력하면, `;`이후의 명령어가 실행되어 확인이 가능하다.
`;` 이외에도 `&&` 혹은 `|`와 같은 특정 문자도 가능하다.
이런 취약점이 존재한다.

**Command를 활용한 해킹 방어**

이러한 해킹은 어떻게 방어할 수 있을까?

입력값에 대한 검증이 필요하다.
ping과 같은 경우 IP만 입력하므로 `.`으로 구분하여 4개의 숫자를 받고 ping에 대한 해당 역할만을 진행하도록 수정한다.
명령어를 입력받은 그대로 실행하는 것이 아니라 내가 원하는 명령어로 수정한 후에 실행하는 것이다.

여기서도 DVWA Security의 Level을 올려보면서 Source를 확인해본다.

**SQL injection을 활용한 해킹**

기존에 ID와 PASSWORD를 입력하도록 하는 창이라면, ID에 `user' OR 1=1 LIMIT 1;`과 같은 SQL 코드를 넣었을 경우 뒤에 붙게되는 PASSWORD는 무시한채 로그인이 성공하는 경우가 발생할 수 있다.

언제 에러가 발생하는지를 이용한 **Error based SQL Injection**도 존재한다.
`' ORDER BY 1 #`과 같은 SQL query를 활용하면 어떤 칼럼까지 있는지 파악할 수 있다.

`'and 1=1 union select table_name, table_schema from information_schema.tables where table_schema='dvwa' #`
위의 Query문을 활용하면 DB이름이 dvwa, 테이블 이름이 guestbook이라는 것 등등을 알 수 있다.

`'UNION select user, password FROM users #`
위의 Query문은 심지어 모든 유저정보와 비밀번호를 가져올 수 있다.
비밀번호가 MD5로 해쉬되어 있다. MD5는 암호 알고리즘이 아니라 해쉬 알고리즘이다.
해쉬 알고리즘을 통하면 특정 문자열을 집어넣으면 항상 동일한 해쉬값을 반환하게 되나, 원본 문자열로 돌릴 수 없다.
하지만 해쉬값에 대한 원본 문자열의 사전을 보유하고 있다면 원본 문자열을 쉽게 가져올 수 있다.

**SQL Injection을 활용한 해킹 방어**

이러한 해킹은 어떻게 방어할까?

입력값에 대한 검증이 필요하다.
입력값을 검증하지 않고 바로 SQL 쿼리문에 사용하는 경우가 가장 안좋다.
`escape string`을 제외하는 경우도 존재한다.

## QnA

Q1. 혹시 제 데탑에 웹서버를 실행시켜 놓으면 그 이외의 다른 디렉토리에도 접근할 가능성이 있나요??
A1. 동일한 LAN(공유기)을 사용하는 기기에서는 접근이 가능하다. 하지만 외부에서 접근한다는 것은 아예 다른이야기이다. 공유기에 포트포워딩을 설정해둔다면, 외부에서 접근이 가능해져서 웹에 업로딩한 상태와 똑같아 진다.

Q2. 자신만을 위한 웹 서버를 구축 하려면 방화벽을 설정하면 될까요?
A2. 방화벽으로 방어할 수 있는 것은 한계가 있다. 이는 V3만 설치하면 모든 바이러스를 막냐는 것과 동일한 질문. 서버에 대해서는 방어할 수 있지만 애플리케이션과 사용자에 대해서는 방어해주지 않는다.

Q3. 현재 제 서버에 해킹시도가 얼마나 들어왔는지 어떻게 확인할 수 있나요?
A3. `sudo lastb` 명령어를 사용하면 로그인 시도가 얼마나 들어왔는지 확인할 수 있다.

Q4. API Server도 OWASP로 취약점 점검을 진행할 수 있나요?
A4. API Server에서도 가능하다. 다만, AWS에 업로드 되어있는 서버라면 AWS 자체 방어시스템이 돌아갈수도 있음. 이러한 경우 내 작업 IP가 AWS에서 블랙리스트에 등록될 수도있다. 며칠 or 몇주간 접속이 안될수 있다. 만약 AWS에 업로드되어있는 내 서버를 라이브로 모의해킹을 진행하고자 한다면, AWS에 먼저 요청할 수 있다. 그렇다면 AWS에서 방어시스템을 Disable 시킨다. 하지만 보통 이러지 않고, 로컬 작업환경이나 폐쇄망에서 개발 및 점검을 진행하고 패치하여 해결한 다음에 라이브로 배포하는 것이 올바른 방법이다.

