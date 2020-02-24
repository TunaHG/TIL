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
    * Setting의 소프트웨어, yum업데이트 방지, 네트워크설정, SELinux기능 끄기를 전부 진행한다.

* JDK를 설치한다.
  * [JDK Install](../Linux/JDK.md)를 참고하여 진행한다.