# Hadoop Start

> 빅데이터 저장(분산) 처리 시스템

* 1개 컴퓨터(vm) : Single Node로 운영
* 4개 컴퓨터 : Multi Clustering Node로 운영
  * 하나의 VM을 먼저 만든 후 복사하여 4개의 VM을 생성
  * master : 2GB Memory, 1 Processor, 20GB Disk, NAT Network, Cent OS Iso file

## Concept

* 빅데이터의 3V 속성
  * 규모(Volume) : 데이터를 생성하는 주기가 빠르다. => 데이터의 규모가 커진다.
  * 속도(Velocity) : 저장된 데이터를 처리하는 속도가 빠르다.
  * 다양성(Variety) : SNS등에서 쌓이는 데이터는 각종 형태를 가진다. (텍스트, 이미지 등)
  * 정확성 : 데이터에 부여할 수 있는 신뢰 수준
  * 가치 : 빅데이터를 저장하기 위한 IT 인프라 구조를 구현하는 비용
* HDFS : Hadoop Distributed File System
  * 분산처리시스템
* 설치방식
  * 독립실행모드(Standalone)
    * 기본 실행 모드, 환경설정 파일에 아무런 설정을 하지 않고 실행하면 로컬 장비에서만 실행되기 때문에 로컬모드라고도 한다.
    * 분산환경을 고려한 테스트는 불가능하다.
  * 가상분산모드(Pseudo-Distributed)
    * 하나의 장비에 모든 하둡 환경설정을 하고, 하둡 서비스도 이 장비에서만 제공하는 방식
  * 완전분산모드(Fully Distributed) : 이 모드로 설치한다.
    * 여러 대의 장비에 하둡이 설치된 경우

## Setting

* VMWare에서 Home - Create a New Virtual Machine

  * OS를 나중에 설치하는 3번째 라디오박스 체크후 Next
  * Linux, Cent OS 7으로 설정후 Next
  * name은 master, 경로는 `C:\hadoop\master`로 설정
  * 이후 변경없이 Next, Finish

* VMWare에서 master - Edit virtual machine setting

  * Memory 2GB로 변경

  * Processors는 본인 컴퓨터 사양에 맞춰서 올리고싶으면 올려도됨

    * 단, Hadoop을 구동하기 위해 4개의 가상환경을 구축한다는 것을 생각할것.

  * CD/DVD에서 Connection - Use ISO Image file - Browse를 선택하여 Cent OS의 iso파일을 선택

  * Network Adapter가 NAT로 설정되어 있는지 확인

    ![image-20200224092603047](image/image-20200224092603047.png)

* 이후 Cent OS의 설치방식은 Linux를 설치할 때의 방식과 동일하게 설치한다.

  * [Linux_Start](../Linux/Linux_Start.md)를 참고하여 Install과 Setting을 동일하게 진행한다.
    * 사용자 생성은 hadoop/hadoop으로 하나 생성해준다.
      * root계정으로 hadoop을 사용하다가 실수하면 Linux 시스템 자체를 사용할 수 없는 상태가 될 수 있기 때문에 사용자 계정에서 진행한다.
    * Setting의 소프트웨어, yum업데이트 방지, 네트워크설정, SELinux기능 끄기를 전부 진행한다.

* 방화벽

  * 이전 Linux를 배울 때는 원하는 포트번호에 한하여 방화벽을 해제해줬다.

  * 하지만 Hadoop을 공부할 때는 여러개의 포트번호를 사용하기 때문에 방화벽 자체를 해제한다.

  * `systemctl status firewalld`명령어를 사용하여 현재 방화벽 상태를 확인한다.

    ```
    [root@localhost ~]# systemctl status firewalld
    firewalld.service - firewalld - dynamic firewall daemon
       Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled)
       Active: active (running) since 월 2020-02-24 09:57:41 KST; 54min ago
     Main PID: 753 (firewalld)
       CGroup: /system.slice/firewalld.service
               └─753 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid
    
     2월 24 09:57:41 localhost.localdomain systemd[1]: Started firewalld - dynam...
    Hint: Some lines were ellipsized, use -l to show in full.
    
    ```

    * Active를 살펴보면 active(running)으로 현재 활성화 되어있는 것을 확인할 수 있다.

  * `systemctl stop firewalld`를 사용하여 현재 방화벽을 해제한다.

  * `systemctl disable firewalld`를 사용하여 이후에도 방화벽이 다시 안켜지도록 변경한다.

    * 후에 다시 활성화 시키고 싶다면 `systemctl enable firewalld`명령어를 사용한다.

  * `systemctl restart network`명령어를 사용하여 변경된 Setting을 적용한다.

* JDK를 설치한다.

  * [JDK Install](../Linux/JDK.md)를 참고하여 진행한다.

* Host name을 변경한다.

  * `hostname`명령어를 입력하면 현재 hostname이 나온다.

    ```
    [root@localhost ~]# hostname
    localhost.localdomain
    ```

  * `hostnamectl set-hostname master`로 hostname을 master로 변경한다.

    ```
    [root@localhost ~]# hostnamectl set-hostname master
    [root@localhost ~]# hostname
    master
    ```

  * 