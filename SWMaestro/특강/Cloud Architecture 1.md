# Make up Cloud Architecture 1

> using AWS

* Infra에 대해서 안다면 비용과 시간이 절감될 수 있다.

## Theory

* 클라우드 컴퓨팅?
  * 인터넷을 통해 (물리적 서버와 네트워크와 같은) IT 리소스와 (데이터분석과 같은) 애플리케이션을
    **원할 때 언제든지(On-demand) 사용한 만큼만 요금**을 내는 서비스
  * *Serverless*
* 모든 AWS 서비스를 알겠다고 생각하지 말고, 필요한 서비스만 선택하여 공부하고 사용하면 된다.
  * 이후에 필요한 서비스는 추가하면 된다!
* AWS 주요 구성요소 목록
  * **Compute Service**
    * EC2: Elastic Virtual Servers in the Cloud
      * 재구성이 가능한 컴퓨팅 파워
      * 쉽게 확장/축소되는 컴퓨팅 용량
      * Ecpu 4기가 정도를 1~2개사용하면 SoMa에서는 충분 (T2, T3)
      * 비용최적화를 위한 Reserved Instance
    * ELB(Elastic Load Balancing)
      * 트래픽을 자동으로 분산
      * 자동으로 용량 확장/축소
    * Auto Scaling: 해당 단계까지만 가면 잘하는 거
      * Application의 고가용성 유지
      * 자동으로 EC2 Scale in & out
      * 사용자의 지정에 따른 작동
  * Database
    * RDS
      * Relational Database
    * DynamoDB
      * NoSQL
      * 높은 내구성과 낮은 latency
      * Bigdata 관리 및 운영에 적합한 DB
    * ElastiCache
      * 응답속도가 빨라야 하는 문제에 적합
  * Storage
    * EBS(Elastic Block Storage) : Block Storage for use with Amazon EC2
      * EBS는 EC2에 붙여서 용량을 확장
        * 보통 EC2본체에는 프로그램만, 빠른 I/O를 위한 Static Data를 저장하기 위한 하드디스크
      * EC2와 함께 사용/하드디스크
      * 언제든지 늘이거나 줄일 수 있음
      * Secure and Durable
      * 1개의 EBS에 여러개의 EC2를 붙일 수는 없으나, 1개의 EC2에 여러개의 EBS를 붙일 수는 있다
        * 이를 해결한 것이 EFS
    * S3 : Internet Scale Storage via API
      * 객체 저장소
      * 사용한 만큼만 지불
      * Static 웹서버로 사용
      * Secure, Durable, Highly-Scalable
      * 99.999999999% => 은행에서 판단한 신뢰도
      * 30일 이후 Cold Data Glacier로 이동
    * Glacier : Storage for archiving and backup
      * S3의 Backup용도로 사용하면 좋음
      * 백업용도의 Cold 데이터
      * 사용한 만큼 매우 낮은 비용으로
      * 호출하면 바로 출력되지 않음, 데이터가 바로 필요하지 않을 때 사용
      * Secure, Durable, Highly-Scalable
      * 99.999999999% => 은행에서 판단한 신뢰도
      * 1년후 데이터 삭제
    * CloudFront(Content Delevery Network)
  * Application
    * SES(Simple Email Service), ...
* AWS Architecture 기본구성
  * Single EC2(Compute), EBS(File Storage)
  * Multi EC2(Compute), ELB, EBS, Route52(DNS), Amazon Certificate
  * Multi EC2, ELB, Route52, Certificate, S3
  * Multi EC2, ELB, Route52, Certificate, S3(Storage), CloudFront(CDN)
  * Multi EC2, ELB, Route52, Certificate, S3(Storage), CloudFront(CDN) + Lambda
  * EC2 Auto Scaling, ELB, Route52, Certificate, S3, CloudFront, RDS
  * ...etc

## Training

* 계정생성

  * 프로페셔널 선택
  * 영문으로 주소 입력(우편번호 필수) => 신용카드 인증 => 문자메시지 인증
  * 기본플랜 선택
    * 개발자 플랜은 추가과금, 나중에 AWS 지원을 1~2일 텀으로 받고자 할때 변경
    * 비즈니스 플랜은 AWS 지원을 바로 받을 때 변경

* 도메인 생성

  * 콘솔 로그인
  * 서비스 > Route53
  * 도메인 등록
    * 가능하면 `.com`으로 등록
    * 1년에 $12 과금, 결제하여 등록
  * 도메인 등록 확인

* EC2 생성

  * 서비스 > EC2 > 인스턴스 시작
    * 프리티어만 체크, Ubuntu 16.04를 선택
    * 보안그룹 생성인 5단계 이전까지는 변경없이 다음단계 선택
    * 태그는 추가해도 되는데, 태그의 의미는 간단한 설명(내가 알아보기 위한 Description)
  * 보안그룹 생성
    * 포트를 입력하여 열어줌
    * 열어주는 포트로만 접근가능
  * **키 페어**
    * 보안 효과 + 팔 때 비밀번호를 건네주는 느낌의 수단
    * 새 키 페어 생성
      * 키 페어 이름 입력후 키페어 다운로드 클릭
    * [puttygen](https://www.puttygen.com/)을 이용하여 `.pem`파일을 load하여 save private key를 클릭하여 `.ppk`파일 생성
    * [putty](https://www.putty.org/)를 활용하여 SSH 접속
      * Session의 Hostname은 EC2 인스턴스의 퍼블릭DNS를 입력
      * SSH > Auth 로 진입하여 Private Key file for authentication에 아까 생성한 ppk파일을 넣어줌
      * Session으로 돌아와서 Saved Session의 이름을 입력하고 Save클릭후 Open
      * login as:에 ubuntu입력 후 로그인

* EC2에 EBS 붙이기

  * 볼륨 생성

    * 범용SSD 선택
      * IOPS => DBMS등 최대한 빠른 작업에서 진행, 비싼 요금
    * 가용영역은 EC2의 가용영역과 동일하게 설정

  * 만들어진 EBS위에서 우클릭하여 볼륨연결

    * 상태가 available에서 in-use로 변경됨
    * 연결된 putty에서 lsblk로 연결된것을 확인할 수 있음

  * 연결된 볼륨을 포맷

    * 이전에 사용자계정의 비밀번호 설정 후 root계정으로 변경

      ```
      ubuntu@ip-172-31-32-27:/$ sudo passwd root
      
      ubuntu@ip-172-31-32-27:/$ su root
      ```

    * 포맷진행

      ```
      ubuntu@ip-172-31-32-27:/$ mkfs -t ext4 /dev/xvdf
      ```

      * xvdf는 lsblk명령어로 확인한 EBS의 Name을 입력한다.

  * 마운트 진행

    * 마운트: 하드디스크 붙이는것

    * lsblk로 새로 생성된 xvdf(이름에 주의)에 마운트 지정

      ```
      // 마운트 지점 생성
      ubuntu@ip-172-31-32-27:/$ mkdir /svdata
      
      // 마운트 진행
      ubuntu@ip-172-31-32-27:/$ mount /dev/xvdf /svdata
      
      // 마운트 확인
      ubuntu@ip-172-31-32-27:/$ df -h
      ```

  * 재부팅후에 볼륨이 자동 탑재되도록 설정

    * EC2를 재부팅할 경우 자동으로 볼륨이 설정되도록 설정 (하지만 EC2는 끌일이 없음)

    ```
    // 볼륨정보 파일 백업
    ubuntu@ip-172-31-32-27:/$ sudo cp /etc/fstab /etc/fstab.orig
    
    // UUID 탐색 => 나오는 결과물에서 UUID를 복사하여 저장
    ubuntu@ip-172-31-32-27:/$ sudo blkid
    
    // 볼륨정보 편집 => 기존에 존재하는 내용에 추가
    ubuntu@ip-172-31-32-27:/$ vi /etc/fstab
    // 아래 코드를 추가
    UUID=4ddffbee-7653-431e-9da8-9d36a85d5d9d /svdata ext4 defaults,nofail 0 2
    ```

* EC2 이미지 생성

  * 인스턴스에 우클릭하여 이미지 > 이미지 생성
  * AMI이름과 설명 추가
  * EC2 > Image > AMI에 생성된 이미지를 확인할 수 있음
  * 해당 이미지로 새로운 EC2 인스턴스를 생성
    * 동일한 인스턴스가 생성됨

* 멘토님이 준비해주신 Image를 사용

  * 퍼블릭이미지에 SomaBase를 검색하면 업로드 해두신 이미지가 나옴

  * 해당 이미지를 활용하여 EC2 2개 생성

  * 해당 EC2로 진입하여 다음의 명령어를 입력

    ```
    ubuntu@ip-172-31-4-191:~$ su jmnight
    Password:
    jmnight@ip-172-31-4-191:/home/ubuntu$ cd ~
    jmnight@ip-172-31-4-191:~$ ls -al
    total 44
    drwxr-xr-x 3 jmnight jmnight  4096 May 28 01:07 .
    drwxr-xr-x 5 root    root     4096 May 27 20:53 ..
    -rw-rw-r-- 1 jmnight jmnight  3095 May 28 01:09 .bash_history
    -rw-r--r-- 1 jmnight jmnight   220 Jan 18  2018 .bash_logout
    -rw-r--r-- 1 jmnight jmnight  3771 Jan 18  2018 .bashrc
    -rw-r--r-- 1 jmnight jmnight  1886 May 28 01:07 .profile
    -rw-rw-r-- 1 jmnight jmnight    66 Jun 29  2019 .selected_editor
    drwxrwxr-x 2 jmnight jmnight  4096 May 28 01:06 tmp
    -rw------- 1 jmnight jmnight 10843 May 28 01:07 .viminfo
    jmnight@ip-172-31-4-191:~$ source .profile
    jmnight@ip-172-31-4-191:~$ astart
    jmnight@ip-172-31-4-191:~$ tailac
    222.112.124.43 - - [28/May/2020:01:08:07 +0900] "GET / HTTP/1.1" 200 228
    222.112.124.43 - - [28/May/2020:01:08:08 +0900] "GET / HTTP/1.1" 200 228
    222.112.124.43 - - [28/May/2020:01:08:08 +0900] "GET / HTTP/1.1" 200 228
    222.112.124.43 - - [28/May/2020:01:08:08 +0900] "GET / HTTP/1.1" 200 228
    222.112.124.43 - - [28/May/2020:01:08:09 +0900] "GET / HTTP/1.1" 200 228
    
    
    
    jmnight@ip-172-31-4-191:/usr/local/apache2/conf$ sudo cp httpd.conf httpd_back.conf
    jmnight@ip-172-31-4-191:/usr/local/apache2/conf$ sudo vi httpd.conf
    jmnight@ip-172-31-4-191:/usr/local/apache2/conf$ arestart
    ```

* Route53에 등록한 도메인으로 연결

  * 해당 도메인에 레코드 세트를 생성
  * 유형을 IP로 지정하고 돌아가고 있는 Server의 IP를 입력
  * 해당 도메인으로 진입하면 사이트가 나타남