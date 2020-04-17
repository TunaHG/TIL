# Network

## Network

### 네트워크란?

> 케이블이나 전화선으로 연결된 두 대의 컴퓨터가 데이터를 전송하기위한 원거리 통신망

* 지역적으로 분산된 위치에서 컴퓨터 시스템 간에 데이터 통신을 하기 위한 **디바이스** 및 소프트웨어 집단
  * 디바이스란, 컴퓨터 뿐 아니라 프린터, 웹서버, 휴대폰 등 다양한 형태로 존재
  * 디바이스를 통해 언제 어디서든 네트워크를 이용할 수 있음
* 특정 서비스를 제공해주는 다양한 디바이스들이 네트워크로 연결되고 있고 서비스 이용자가 네트워크를 통해 서비스를 검색하고 이용할 수 있음
* 네트워크(Network)
  * 통신 경로들에 의해 상호 연결된 일련의 지점(Point)들이나 노드(Node)들을 의미함
* 네트워킹(Networking)
  * 네트워크에 연결된 디바이스들 간의 데이터 교환을 의미함
* 네트워크의 형태
  * LAN (Local Area Network)
  * WAN (Wide Area Network)
  * Man (Metropolitan Area Network)

### Protocol

* 일종의 통신규약으로, 컴퓨터 간에 통신을 하기 위한 약속과 절차를 의미함

* 데이터 통신에서는 통신 장치 간의 데이터 교환에 필요한 모든 규약의 집합체

* 물리적 측면

  * 데이터 전송에 사용되는 전송 매체, 접속용 커넥터 및 전송 신호

* 논리적 측면

  * 데이터의 표현, 의미와 기능, 데이터 전송 절차

* 서로 다른 부호체계를 사용하는 장치 간의 원활한 통신을 위해 **부호의 일치는 필수적**임

* 전송하는 **데이터 형식, 신호의 코딩방식, 신호의 전기적 특성, 데이터 흐름 제어** 등은 약속을 철저하게 준수하지 않으면 근본적으로 통신이 이루어질 수 없음

* 패킷(Packet)

  * 1024비트씩 묶여있는 데이터 묶음
  * 묶음 속에 각종 에러 검사용 정보를 담아 보내기 때문에 어느 패킷에서 에러가 발생했는지 알 수 있음
  * 전송 도중 에러가 발생하면 전체 데이터를 다시 전송하지 않고 해당 묶음만 다시 전송하기 때문에 속도가 빠름
  * 패킷의 구성
    * 헤더(Header)
      * 송신자와 수신자의 주소 정보
      * 패킷이 손상되지 않았음을 보장하기 위한 checksum
      * 네트워크로 전송할 때 필요한 기타 유용한 정보
    * 바디(Body)
      * 바이트 그룹으로 묶인 전송할 데이터
  * 많은 데이터를 하나의 패킷으로 묶어서 전송할 수 있으므로 매우 효율적임

* 네트워크 구조 OSI 7계층

  * 네트워크 장비끼리 서로 표준적인 연결을 할 수 있도록 틀을 제공하기 위함
    * 개방형 시스템 환경에서는 어떤 장비라도 상호 정보처리가 가능하게 됨
    * 네트워크의 프로토콜을 분리함으로써 프로토콜이 단순해짐
      * 관리가 쉬워지고 좀 더 유연한 구조가 됨

  | 계층  | 내용                                                  |
  | ----- | ----------------------------------------------------- |
  | 7계층 | 애플리케이션 계층(NFS, FTP, HTTP)                     |
  | 6계층 | 프레젠테이션 계층(XDE, XML, ASCI, Java Serialization) |
  | 5계층 | 세션 계층(Sun RPC, DCE RPC, IIOP, RMI)                |
  | 4계층 | 트랜스포트 계층(TCP, UDP)                             |
  | 3계층 | 네트워크 계층(IP)                                     |
  | 2계층 | 데이터 링크 계층(Wire formats for messages)           |
  | 1계층 | 물리 계층(Wires, signaling)                           |

  * 1계층
    * 노드(Node) 간 네트워크 통신을 하기 위한 가장 저수준의 계층
    * 상위 계층인 데이터 링크 계층에서 형성된 데이터 패킷을 전기 신호나 광신호로 바꾸어 송수신하는 역할을 담당함
    * Java 개발자가 직접 접근할 수 있는 계층이 아니고 하드웨어나 드라이버 개발자들이 C 언어 등으로 다룸
  * 2계층
    * 네트워크 계층으로부터의 메시지를 비트로 변환해서, 물리 계층이 전송할 수 있게 함
    * 메시지를 데이터 프레임의 포맷으로 만들고, 수신지와 발신지 하드웨어 주소를 포함하는 헤더를 추가함
  * 3계층
    * 다른 장소에 위치한 두 시스템 간의 연결성과 경로 선택을 제공함
    * 라우팅 프로토콜을 사용하여 서로 연결된 네트워크를 통한 최적의 경로를 선택하며, 선택된 경로를 따라 정보를 보냄
  * 4계층
    * 데이터 전송 서비스를 제공함
    * 네트워크 내에서 신뢰성 있는 서비스를 제공하기 위해 가상 회로 구축, 유지와 종료, 전송 오류 검출과 복구 그리고 정보 흐름 제어의 절차를 제공함
  * 5계층
    * 애플리케이션 간 세션을 구축하고 관리하며 종료시키는 역할을 함
    * 프레젠테이션 계층 사이의 통신을 동기화시키며 데이터 교환을 관리함
  * 6계층
    * 한 시스템의 애플리케이션에서 보낸 정보를 다른 시스템의 애플리케이션 계층에서 읽을 수 있게 하는 곳임
  * 7계층
    * 사용자와 컴퓨터가 통신하는 곳임
    * 통신하고자 하는 상대를 식별하고 그 상대와의 통신을 확보하는 역할을 함
    * 통신을 위한 충분한 자원을 보유하고 있는지의 여부를 판단함.

### 프로그램 관계모델

#### Client / Server model

* 클라이언트 / 서버 모델은 현재 네트워크 컴퓨팅의 중심개념
* 서비스를 요청하는 Client 프로그램과 그 요청에 대해서 서비스를 제공하는 Server 프로그램 사이의 상호 통신하는 관계
* 네트워크 상의 서로 다른 컴퓨터에 분산되어 있는 프로그램들이 서로 효율적으로 통신할 수 있는 환경을 제공
* 인터넷의 기본 프로그램인 TCP / IP도 클라이언트 / 서버 모델을 사용하여 구현됨
* 웹 브라우저
  * 일종의 클라이언트 프로그램
  * 특정 웹서버에게 웹페이지 또는 파일 전송을 요청하고 서버의 응답 결과를 출력하는 일을 수행함
* TCP / IP가 설치된 컴퓨터
  * TCP / IP가 설치된 컴퓨터에서는 인터넷 상의 다른 컴퓨터의 FTP(File Transfer Protocol) 서버들에게 파일 전송을 요청할 수 있음

#### Peer-to-peer model

* 클라이언트 / 서버 모델과 대비되는 모델이며 일반적으로 P2P라는 용어로 사용됨
* 클라이언트 / 서버 환경
  * 서비스 제공자와 서비스 수요자가 명확하게 구분됨
  * 서비스 제공자인 서버가 서비스 수요자인 클라이언트에게 일방적으로 서비스를 제공함
    * 서버는 한 대인데, 수많은 클라이언트가 서버에 접속하여 서비스를 요청한다면 당연히 부하가 발생할 수 밖에 없음
* P2P
  * 하나의 사용자가 서버이자 클라이언트 역할을 수행함
  * 네트워크에 연결되어 있는 모든 컴퓨터들이 서로 대등한 동료의 입장에서 데이터나 주변 장치 등을 공유할 수 있다는 것을 의미함
    * 하나의 서버로 집중되는 요청으로 인해 발생하는 부하를 줄일 수 있음

#### Internet

> Network of Network, 물리적인 네트워크의 형태

* 미 국방성이 중심이 되어 패킷 통신망을 개발하게 된 ARPANET이 시초
* TCP / IP 라는 프로토콜을 사용하는 수많은 컴퓨터들이 서로 연결된 전 세계에서 가장 큰 통신망
* OSI 7계층 중 3계층인 네트워크 프로토콜에 기반을 둔 하나 이상의 네트워크 모임
* 각각의 네트워크는 인터넷 내의 다른 어떤 네트워크와도 통신할 수 있음
* 전 세계적인 TCP / IP 네트워크며, IP 주소체계와 IP 프로토콜을 사용함
* 사용하기 위해 그 위에서 동작하는 Service가 필요함
  * Web Service, Email Service, Torrent, Streaming
* Service가 동작하려면 각 컴퓨터들이 서로를 인지할 수 있는 수단이 필요함
  * 각 컴퓨터의 NIC마다 주소 (IP Address)를 부여함
    * NIC : Network Interface Card
    * 일반적으로 LAN Card를 의미함

### 중요 프로토콜

#### IP

* 네트워크 계층에 존재하는 프로토콜로서, 활용도가 높고 널리 사용됨
* 신뢰성이 없는 프로토콜로, 패킷이 상대방에게 안전하게 전송되는 것을 보장하지 않음
  * 데이터를 효율적으로 전송하는 것에만 집중하기 때문임
* 호스트에 대한 주소체계와 데이터 패킷에 대한 라우팅을 담당함
* 패킷을 수신하는 각 라우터는 패킷의 IP주소를 근간으로 라우팅을 결정함
* IP 주소
  * LAN Card에 부여된 논리적인 주소
    * 논리적이란 의미는 변경될 수 있음을 의미한다.
    * 하지만 논리적인 주소만으로는 컴퓨터간의 통신이 불가능함
    * 물리적인 주소 (MAC Address)가 있어야 통신이 가능
    * 물리적인 주소를 알기 힘들기 때문에, 논리적인 주소로 통신
      * 논리적인 주소를 물리적인 주소로 변경하여 통신
  * 32비트 정보로 구성됨
    * Dot(`.`)을 구분자로 해서 8비트씩 네 부분으로 나뉘어짐
    * 일부는 네트워크를 나타내고, 다른 부분은 호스트를 나타냄
  * 현재 IP버전은 IPv4를 사용하고 있으나, IP 주소 자체가 고갈되고 있는 실정임
    * IPv4보다 좀 더 큰 주소 공간이 있는 IPv6에 의해서 해결방법을 찾고 있음
  * 숫자로 이루어져 있어서 기억하기가 쉽지않음
    * DNS(Domain Name System)을 도입하여 사용 (`www.naver.com`과 같은)

#### TCP

> TransMission Control Protocol

* 신뢰성 있는 프로토콜
* 전송할 데이터가 안전하게 전달되는 것을 보장함
* 전달되는 데이터는 발신자가 보내는 것과 같은 순서로 수신자에게 전달됨
* 흔히 전화통화와 비교함
* TCP는 연결지향 프로토콜로서, 데이터를 전송하거나 수신하기 전에 송신자와 수신자가 연결되어 있어야함
* 송신자
  * 데이터의 무결성을 보장하기 위해 checksum을 포함해서 전달함
* 수신자
  * 발신자가 포함한 checksum을 사용해서 전달받은 데이터를 확인함
  * 누락된 데이터가 있다면 발신자에게 해당 데이터의 재전송을 요청함
* 소켓과 포트를 이용해서 동시에 여러 개의 접속을 지원할 수 있음
* UDP에 비해 프로토콜이 더 복잡하고 속도가 느림
* **신뢰성 있는 데이터 전송이 가능하다는 장점** 때문에 HTTP, FTP, TELNET 등 대부분의 경우 TCP를 사용

#### UDP

> User Datagram Protocol

* 신뢰성 없는 프로토콜
* 전송한 데이터가 잘 전달되었는지 확인하지 않고 데이터를 보내는 것만으로 자신의 임무를 다한 것으로 여김
* 흔히 UDP를 우편배달에 비유함
  * 우편을 보내면 그 우편이 수취인에게 반드시 도착한다고 보장할 수 없음
  * 우편을 보낸 사람 입장에서 우편물이 잘 도착했는지 확인할 방법도 없음
  * UDP는 비연결지향 프로토콜로서, 상대방에게 우편을 보낸다고 알리지 않아도 상대방이 어디에 있는지를 가정하고 보냄
* 음악이나 동영상의 **스트리밍 서비스**같은 것에 적당한 프로토콜

#### HTTP

* 인터넷에서 하이퍼 텍스트 문서(텍스트, 그래픽, 사운드, 비디오, 기타 멀티미디어 파일 포함)를 교환하기 위해서 사용하는 통신규약들의 집합
* 상태를 유지하지 않는 (Stateless) 특징
  * 클라이언트에서 서버로 접속해서 요청을 하면 서버에서는 클라이언트가 요청한 정보에 대해서 적절한 응답을 하고 접속을 끊어버림
* HTTP 문서는 요청에 관한 여러 정보를 담고 있는 헤더와 데이터를 담고 있는 바디로 구성
* HTTP 프로토콜은 TCP 포트 80번을 사용

### 네트워크 프로그래밍 기초

#### 소켓

> 사용자에게 네트워크에 접근할 수 있는 인터페이스를 제공

* 소켓의 과정
  1. 소켓 생성
  2. 소켓을 통한 송수신
  3. 소켓 소멸
* 소켓의 방법
  * TCP와 UDP를 이용한 두 가지 방법이 있음
* 소켓의 형식
  * SOCK_STREAM
    * 바이트를 주고 받을 수 있는 Stream 통신을 구현할 수 있게 해주는 소켓
    * 양방향 통신이 가능
    * 해당 소켓을 이용하는 방식을 TCP라고 함
  * SOCK_DGRAM
    * 데이터그램 통신용 소켓
    * 양방향 통신이 가능
    * 해당 소켓을 이용하는 방식을 UDP라고 함
  * SOCK_RAW
    * Java에서 지원하지 않음

#### 인터넷 주소와 포트

* 소켓을 사용하려면 인터넷 주소와 포트에 대해 알고 있어야 함
* 인터넷 주소(IP)
  * 원하는 컴퓨터를 찾을 수 있음
  * 컴퓨터를 찾았다고 해서 올바른 통신을 할 수 있는 것은 아님
    * 컴퓨터 안에는 프로세스 여러 개가 각자의 포트를 가지고 접속을 기다리고 있거나 이미 통신을 하고 있기 때문
* 포트(Port)
  * 하나의 컴퓨터에는 프로세스 여러 개가 소켓으로 통신하는데, 이 때 각각의 소켓을 구분하기 위해 사용
  * 정수값으로 되어있음
    * 0 ~ 65535 내의 숫자
    * 0부터 1023까지의 숫자는 유명 프로그램(FTP, WWW)등이 사용하도록 이미 정해진 포트
    * 일반 사용자는 1023 이후의 포트를 이용
* InetAddress Class (도메인과 IP 변환)
  * Java.net 패키지에 존재
  * 도메인 주소를 IP 주소로 변환하거나 반대로 변경하는 것이 가능
  * 문자열이나 바이트 배열 형태로 IP 주소에 대한 정보를 얻을 수 있음
    * `getLocalHost()`, `getByName()`, `getAllByname()`
    * 해당 메소드는 UnknownHostException 예외처리를 진행해야 함
  * 현재 컴퓨터의 이름을 구할 수 있음
  * 메소드
    * `Static InetAddress getLocalHost()` : 로컬호스트의 IP주소 정보를 InetAddress객체 형태로 반환
    * `Byte[] getAddress()` : IP주소를 바이트 형태로 반환
    * `String getHostAddress()` : 호스트의 IP주소를 점으로 구분되는 10진수 형태로 반환
    * `String getHostName()` : 호스트의 도메인명을 문자열로 반환
  * [예제1](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/InetAddressTest.java), [예제2](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/IPAddressLocalTest.java)

## Network Programming

### TCP 프로그래밍

> 미리 정해지지 않은 길이의 데이터를 신뢰성 있게 송수신하기 위한 네트워크 프로그래밍에 적합

* 스트림 통신 프로토콜
* 연결지향 프로토콜 : 양쪽의 소켓이 연결된 상태여야 가능함
* 신뢰성 있는 데이터 전송
  * 송신한 쪽의 데이터가 수신 측에 차례대로, 중간에 유실되는 일 없이 도착하는 것을 의미
  * 수신 측과 송신 측이 미리 연결을 맺고 연결된 순서대로 데이터를 교환해야 함
  * TCP는 연결지향 방식
    * 연결이 끊어질 때까지는 송신한 데이터가 차례대로 목적지의 소켓에 전달되는 신뢰성이 있는 통신이 가능
    * 한번 연결을 맺게 되면, **안정적으로 통신**할 수 있음
* 연결에 시간이 필요함
* TCP 프로그램에서 사용하는 라이브러리의 사용방법과 동작 순서를 이해하고 있어야 함
  * Java는 java.net 패키지에 관련 클래스들을 미리 준비해둠
    * ServerSocket : 서버 쪽에서 클라이언트의 접속을 대기하기 위해서 반드시 필요한 클래스
      * `Socket accept()` : 접속요청을 받아 새로운 Socket 객체를 반환
      * `void close()` : 서버소켓을 닫음
      * `InetAddress getInetAddress()` : 서버 자신의 인터넷 주소를 반환
    * Socket : 서버와 클라이언트가 서버와 통신하기 위해서 반드시 필요한 클래스
      * `void close()` : 소켓을 닫음
      * `InetAddress getInetAddress()` :상대방의 InetAddress를 반환
      * `InputStream getInputStream()` : 이 소켓과 연결된 InputStream을 얻음
      * `OutputStream getOutputStream()` : 이 소켓과 연결된 OutputStream을 얻음
* TCP 에코서버
  * 클라이언트가 보낸 데이터를 서버 쪽에서 받아들여, 클라이언트에게 그대로 다시 보내주는 것
  * 구현 순서
    1. ServerSocket(포트 번호)을 생성하여 특정 포트에서 클라이언트의 접속을 대기함
    2. ServerSocket의 accept() 메소드를 이용하여 클라이언트의 접속을 기다림
    3. 클라이언트의 접속 요청이 들어오면 accept() 메소드가 실행되어 클라이언트와의 통신을 위한 Socket 객체를 생성함
    4. 생성된 Socket 객체로부터 통신을 위한 InputStream, OutputStream을 얻음
    5. InputStream, OutputStream을 이용하여 클라이언트와 통신함
    6. 통신에 사용된 IO 스트림과 Socket 객체를 close()함
  * [TCPEchoServer Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/TCPEchoServer.java)
* TCP 에코 클라이언트
  * 구현순서
    1. 서버와 통신을 위한 Socket 객체를 생성함
       이 때 접속요청할 서버의 IP주소와 Port번호를 매개변수로 지정함
    2. Socket 객체로부터 서버와의 통신을 위한 InputStream, OutputStream을 얻음
    3. 생성된 Stream을 이용하여 서버와 통신함
    4. 통신이 완료되면 통신에 사용된 IO 스트림과 Socket 객체를 close()함
  * [TCPEchoClient Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/TCPEchoClient.java)
* 에코 서버와 클라이언트의 문제점
  * 서버가 단 하나의 클라이언트 접속만을 처리할 수 있다는 점에서 문제가 발생
  * accept() 로 대기하고 접속 요청을 받은 후 클라이언트와 통신할 수 있는 소켓을 리턴한 이후에는 accept()를 다시 하지 않음
  * **멀티 Thread를 이용**하여 여러 클라이언트의 접속을 지원해야함.
    * 각각의 소켓은 각각 별개로 동작해야 함
    * 클라이언트와 1:1로 통신하는 Thread 객체는 통신을 위한 Socket을 가진 Thread 객체로 작성해야 함
* TCP 기반 멀티 Thread
  * 구현 순서 (1~4는 서버, 5~7은 생성된 Thread 객체에서 담당)
    1. ServerSocket(50000)을 생성하여 특정 포트에서 클라이언트의 접속을 대기
    2. ServerSocket의 accept() 메소드를 이용하여 클라이언트의 접속을 기다림
    3. 클라이언트의 접속 요청이 들어오면 accept() 메소드가 실행되어 클라이언트와의 통신을 위한 Socket 객체를 생성함
    4. 생성된 Socket 객체를 매개변수로 하여 Thread클래스의 객체를 생성함
    5. Thread는 생성자 메소드에 의해서 전달된 Socket으로부터 통신에 필요한 InputStream, OutputStream을 얻음
    6. InputStream, OutputStream을 이용하여 클라이언트와 통신함
    7. 통신에 사용된 IO 스트림과 Socket 객체를 close()함
  * [MultiThreadEchoServer Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/MultiThreadEchoServer.java), [EchoThread Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/EchoThread.java)

### UDP 프로그래밍

> 복잡하지 않고, 부하가 많이 발생하지 않는 곳에 적합

* 데이터그램 통신 프로토콜
* 비연결성(Connectionless) 프로토콜
* 패킷을 보낼 때마다 수신 측의 주소와 로컬 파일 설명자를 함께 전송해야 함
* 데이터의 크기가 64KB로 제한되어 있음
* 연결되지 않은 상태로 전송되기 때문에 좀 더 빠르게 데이터를 주고 받을수 있음
* 클라이언트와 서버 모두 java.net 패키지 안에 있는 DatagramSocket 객체를 생성함
  * DatagramSocket은 DatagramPacket을 보내거나 받을 때 모두 필요함
* 클라이언트와 서버는 데이터를 주고받기 위해 DatagramPacket을 이용해야 함
  * DatagramPacket은 서버의 IP포트와 포트값을 통해 서버에 전달됨
  * 서버는 클라이언트로부터 전달된 패킷을 receive()를 통해 전송한 클라이언트의 IP, 동작 포트, 데이터, 데이터의 길이를 읽어들임
  * 이후 새로운 패킷을 생성하여 send()를 통해 클라이언트로 전송함
* UDP 에코 서버
  * 구현 순서
    1. 특정 포트에서 동작하는 DatagramSocket 객체를 생성함
    2. 클라이언트가 전송한 DatagramPacket을 받기 위해 내용이 비어있는 DatagramPacket 객체를 생성함
    3. 생성한 DatagramPacket을 매개변수로 DatagramSocket이 제공하는 receive() 메소드를 호출함
    4. 클라이언트가 전송한 데이터를 서버 콘솔에 출력함
    5. 클라이언트가 전송한 데이터를 이용하여 새로운 DatagramPacket을 생성함
    6. 생성한 DatagramPacket을 매개변수로 DatagramSocket이 제공하는 send() 메소드를 호출하여 클라이언트로 전송함
    7. DatagramSocket의 close()를 호출하여 연결을 해제함
  * [UDPEchoServer Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/UDPEchoServer.java)
* UDP 에코 클라이언트
  * 클라이언트는 데이터를 전송하기 위해 DatagramSocket을 생성함
  * 서버와 다르게 동작하는 포트는 지정하지 않음
    * 클라이언트는 전송할 DatagramPacket에 서버의 DatagramSocket의 동작포트, 서버의 IP, 전송할 데이터, 전송할 데이터의 길이 등을 지정한 후, send() 메소드를 이용해서 전송하기 때문
  * 구현 순서
    1. DatagramSocket 객체를 생성함
    2. 전송할 데이터, 데이터의 길이, 서버 IP, 서버 포트번호를 매개변수로 하여 DatagramPacket 객체를 생성함
    3. 생성한 DatagramPacket을 매개변수로 하여 DatagramSocket이 제공하는 send() 메소드를 호출하여 서버 쪽에 DatagramPacket을 전송함
    4. 서버에서 전송하는 메시지를 받기 위해 내용이 비어있는 수신용 DatagramPacket 객체를 생성함
    5. 생성한 DatagramPacket을 매개변수로 하여 DatagramSocket이 제공하는 receive() 메소드를 호출함
    6. 서버에서 수신한 메시지를 콘솔에 출력함
    7. DatagramSocket의 close()를 호출하여 연결을 해제함
  * [UDPEchoClient Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Java_Multicampus/src/Network/UDPEchoClient.java)

### Multi Echo Programming

> 위에서 잠깐 진행한 TCP기반 Multi Thread Programming을 Javafx를 이용한 UI와 같이 진행한다.

* [Javafx Package](https://github.com/TunaHG/Eclipse_Workspace/tree/master/Java_Multicampus/lib)에서 `.7z` 파일을 다운로드 받아서 Eclipse의 Project에 Library로 등록한다.

* Server Class를 먼저 생성한다.

  * Javafx의 하위 클래스인 Application을 상속받는다.

  * 필요한 Field를 선언한다.

    ```java
    private TextArea ta;
    private Button startBtn, stopBtn;
    ```

    * 물론 TextArea와 Button은 Javafx의 하위 클래스를 import 해야한다.

  * 해당 Server가 여러 개의 Client의 접속을 받을 것이므로 Thread를 이용한다.

    * 필요한 개수만큼 Thread를 가지고 있는 Thread Pool을 생성한다.

      ```java
      private ExecutorService es = Executors.newCachedThreadPool();
      ```

  * Server Program이며 TCP로 진행할 것이므로 ServerSocket을 선언한다.

    ```java
    private ServerSocket server;
    ```

  * TextArea에 appendText()를 사용하여 text를 추가하는데, 이 때 Thread를 사용한다.

    ```java
    private void printMSG(String msg){
        // Thread를 사용한 Text추가 Code
    }
    ```

    * Platform.runLater()을 사용한다. 이는 Thread를 사용하는 방식이므로 Runnable 객체가 필요하다

    * 일반적인 형태는 다음과 같다.

      ```java
      Platform.runLater(new Runnable() {
      	@Override
      	public void run() {
      		ta.appendText(msg + "\n");
      	}
      });
      ```

      * 하지만 요즘 Java에서는 위와같은 형태는 지양한다.

    * Lambda식을 사용하여 간단하게 표현한다.

      ```java
      Platform.runLater(() -> {
      	ta.appendText(msg + "\n");
      });
      ```

  * main method에서는 간단하게 javafx 프로그램을 실행시킨다.

    ```java
    public static void main(String[] args) {
    	launch();
    }
    ```

  * Application을 상속받으며 `start()`를 Overriding해야한다.

    * `start()`에서는 UI를 구성하고, 각 UI의 Event를 처리한다.

    * UI는 Layout을 담당하는 Pane을 활용한다.

    * 화면을 동,서,남,북,중앙으로 구성하는 BorderPane을 먼저 이용한다.

      ```java
      BorderPane root = new BorderPane();
      root.setPrefSize(700, 500);
      ```

    * TextArea를 생성하여 BorderPane의 중앙에 부착한다.

      ```java
      ta = new TextArea();
      root.setCenter(ta);
      ```

    * 두 개의 버튼을 각각 생성한다.

      ```java
      startBtn = new Button("Echo Server Start");
      startBtn.setPrefSize(150, 40);
      startBtn.setOnAction(e -> {
      	// Event 처리 코드
      			
      });
      		
      stopBtn = new Button("Echo Server Stop");
      stopBtn.setPrefSize(150, 40);
      stopBtn.setOnAction(e -> {
      	// Event 처리 코드
      });
      ```

      * Event 처리 코드는 이후에 추가한다.

    * 두 버튼을 가로로 붙여놓기 위해서 FlowPane을 이용한다.

      * BorderPane은 동, 서, 남, 북, 중앙으로 구분되기 때문에 하단 부분에 두 개의 버튼을 같이 붙여놓기 위해서 이용한다.

      * FlowPane을 생성하고 크기를 설정한다.

        ```java
        FlowPane flowpane = new FlowPane();
        flowpane.setPrefSize(700, 40);
        ```

      * 상하좌우 여백을 설정한다.

        ```java
        flowpane.setPadding(new Insets(10, 10, 10, 10));
        ```

      * 이대로 화면을 구성하면 두 버튼이 붙어있게 되므로 Component 사이의 공간을 설정한다.

        ```java
        flowpane.setHgap(10);
        ```

      * FlowPane이 구성됬으니 두 버튼을 FlowPane에 부착한다.

        ```java
        flowpane.getChildren().add(startBtn);
        flowpane.getChildren().add(stopBtn);
        ```

      * FlowPane이 완성됬으니 BorderPane의 아래 부분에 FlowPane을 부착한다.

        ```java
        root.setBottom(flowpane);
        ```

    * 화면의 구성이 완료됬으니 창을 설정한다.

      * 화면을 의미하는 Scene을 생성한다.

        ```java
        Scene scene = new Scene(root);
        ```

        * Layout인 BorderPane을 이용한다.

      * `start()`에서 인자로가지는 Stage객체의 변수명을 arg0에서 primaryStage로 변경한다.

      * 해당 Stage를 이용하여 창을 설정하고 보여준다.

        ```java
        primaryStage.setScene(scene);
        primaryStage.setTitle("Multi Echo Server");
        primaryStage.setOnCloseRequest(e -> {
        	// x버튼을 눌러 종료시 발생하는 Event
        });
        primaryStage.show();
        ```

  * Start Button의 Event 처리 Code를 작성한다.

    * Client의 요청이 올 때마다 요청을 받을 것이므로 무한 Loop를 돌려야한다.

      ```java
      try {
      	server = new ServerSocket(50000);
      	while(true) {
      		server.accept();
      		printMSG("[New Client Connect]");
      	}
      } catch (IOException e1) {
      	e1.printStackTrace();
      }
      ```

      * 이렇게 구성하면 무한 Loop에 진입한 후 UI가 마비된다.
      * UI가 마비되어 문제가 발생하는 것을 방지하기 위해 Thread를 사용한다.

    * Runnable Interface를 구현한 객체를 생성한다.

      ```java
      Runnable runnable = () -> {
      	try {
      		server = new ServerSocket(9999);
      		while(true) {
      			Socket socket = server.accept();
      			printMSG("[New Client Connect]");
      		}
      	} catch (IOException e1) {
      		e1.printStackTrace();
      	}				
      };
      ```

    * Client와 연결된 Sockect을 가지고 별도의 Thread가 실행되어야 한다.

      * 해당 Thread에서 Echo의 동작을 진행한다.

      * 별도의 Thread를 외부 Class로 생성한다.

        ```java
        class EchoRunnable implements Runnable {
        	private Socket socket;
        	private BufferedReader br;
        	private PrintWriter pw;
        	
        	EchoRunnable(Socket socket){
        		this.socket = socket;
        		try {
        			this.br = new BufferedReader(new InputStreamReader(socket.getInputStream()));
        			this.pw = new PrintWriter(socket.getOutputStream());
        		} catch (IOException e) {
        			e.printStackTrace();
        		}
        	}
        	
        	@Override
        	public void run() {
        		// Thread가 Client와 어떻게 동작하는지를 여기에 명시
        		String line = "";
        		try {
        			while((line = br.readLine()) != null) {
        				if(line.equals("@EXIT"))
        					break;
        				pw.println(line);
        				pw.flush();
        			}
        		} catch (Exception e) {
        			// TODO: handle exception
        		}
        	}
        }
        ```

      * Thread객체를 생성한다.

        ```java
        EchoRunnable r = new EchoRunnable(socket);
        ```

      * Thread를 실행할 때는 Thread Pool인 ExecutorService객체로 실행한다.

        ```java
        es.execute(r);
        ```

    * Runnable 객체의 내부구현이 끝났으니 Runnable 객체 또한 실행시킨다.

      ```java
      es.execute(runnable);
      ```

  * [MultiEchoServer Code]

* Client Class의 기본은 Server와 동일하다.

  * Client는 기본 코드와 크게 다르지않고 주의할 점 몇개만 보면된다.
  * UI는 TextArea와 Button, 텍스트를 입력할 TextField로 구성된다.
  * 주의할점은 Textfield를 활성화시키고 비활성화시키는 점이다.
  * Button의 Click Event는 Socket을 활성화한다.
    * Input과 Output도 생성한다.
    * Textfield를 활성화한다.
  * Textfield의 Action Event는 Enter를 쳤을때 발생한다.
  * [MultiEchoClient Code]

### Chatting Programming

> 하나의 Client가 Message를 보내면 모든 Client에게 Message를 전송하는 Program

* 기본 골격은 위의 MultiEcho Code와 동일하므로 그대로 복사해서 사용한다.

  * 단, Thread Class인 EchoRunnable의 이름을 ChatRunnable로 변경한다.

* Server Code

  * Thread에 의해서 공유되는 공용객체를 만들기 위한 Class를 정의한다.

    ```java
    class ChatSharedObject {
    	// Thread에 의해서 공유되어야 하는 Data
    	// 모든 Client에 대한 Thread를 만들기 위해 필요한 Runnable객체를 저장
    	List<ChatRunnable> clients = new ArrayList<ChatRunnable>();
    	
    	// Data를 제어하기 위해 필요한 Method
    	// 새로운 사용자가 접속했을 때 clients안에 새로운 사용자에 대한 Runnable 객체를 저장
    	public void add(ChatRunnable r) {
    		clients.add(r);
    	}
    	
    	// 사용자가 접속을 종료했을 때 clients안에 있는 사용자를 삭제
    	public void remove(ChatRunnable r) {
    		clients.remove(r);
    	}
    	
    	// Client가 Data를 보내줬을 때 Chat Message를 Broadcast하는 method
    	public void broadcast(String msg) {
    		for(ChatRunnable client : clients) {
    			client.getPw().println(msg);
    			client.getPw().flush();
    		}
    	}
    }
    ```

  * `broadcast()`에서 사용되는 `getPw()`를 ChatRunnable에 생성한다

  * 다시 main Class로 돌아와서 공용객체를 선언한다.

    ```java
    private ChatSharedObject shared = new ChatSharedObject();
    ```

  * 이제 Start Button의 Action Event처리를 수정한다.

    * Runnable객체를 수정하면 된다.

    * EchoRunnable을 사용하던 부분을 ChatRunnable로 변경한다.

      * 이 때, ChatRunnable에서 공용객체를 가져야하므로 인자로 추가한다.

        ```java
        ChatRunnable chat = new ChatRunnable(socket, shared);
        ```

      * 마찬가지로 ChatRunnable Class에서도 ChatSharedObject 객체를 가지도록 변경한다.

        ```java
        private ChatSharedObject shared;
        
        ChatRunnable(Socket socket, ChatSharedObject shared){
        		this.socket = socket;
        		this.shared = shared;
        ```

    * 이제 공용객체의 `add()`를 이용하여 새로운 Client를 추가한다.

    * 또한 `execute()`를 이용하여 Thread를 실행한다.

  * ChatRunnable의 `run()`을 조금 수정한다.

    * 문자열을 전달하는 PrintWriter를 사용하지않는다.
    * 모든 Client에게 문자열을 전달하기위해 공용객체의 `broadcast()`를 사용한다.

* Client Code

  * 문자열을 받는 부분을 Thread로 변경해야한다.

    * inner Class로 생성한다

      ```java
      class ReceiveRunnable implements Runnable {
      	private BufferedReader br;
      		
      	ReceiveRunnable(BufferedReader br) {
      		this.br = br;
      	}
      	
      	@Override
      	public void run() {
      		String msg = "";
      		try {
      			while(true) {
      				msg = br.readLine();
      				if(msg == null)
      					break;
      				printMSG(msg);
      			}
      			
      		} catch (IOException e) {
      			e.printStackTrace();
      		}
      	}
      }
      ```

      * `printMSG()`를 사용하기 위해서 inner Class로 생성했다.

  * TextField에서 진행되는 Action Event를 수정한다.

    * String을 가져와서 Socket으로 전송하는 부분만을 진행한다.

      ```java
      String msg = tf.getText();
      pr.println(msg);
      pr.flush();
      tf.clear();
      ```

  * Button의 Action Event를 수정한다.

    * 위에서 inner Class로 생성한 Receive Thread 객체를 생성하고 실행한다.

      ```java
      ReceiveRunnable r = new ReceiveRunnable(br);
      es.execute(r);
      ```

      