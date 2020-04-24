# Serial Communication

> Serial 통신을 이용하여 Eclipse와 Arduino간의 데이터 통신을 진행한다.

## Setting

* [Download Site](http://rxtx.qbang.org/wiki/index.php/Download)에서 RXTX를 다운로드 받아야한다.
  * zip파일을 다운로드받으면 RXTXcomm.jar파일이 존재한다.
  * 또한 각 운영체제 폴더가 존재하는데 Windows에 rxtxSerial.dll과 rxtxParallel.dll이 존재한다.
* 환경변수 JAVA_HOME으로 설정된 Java설치 폴더를 탐색한다.
  * 해당 Java폴더의 bin폴더 내에 rxtxSerial.dll파일을 붙여넣는다.
* Eclipse의 Project에 생성되어있는 Library폴더를 탐색한다.
  * RXTXcomm.jar파일을 붙여넣는다.
  * 해당 Project의 Java Build Path로 진입하여 Add Jar를 통해 해당 jar파일을 Library로 등록한다.

## Eclipse

> Eclipse부터 작업을 진행한다.

* Thread를 이용하여 Arduino와 데이터 통신을 진행한다.

  * 새로운 Class를 생성한다.

* Serial 통신을 하기위한 COM포트를 설정한다.

  ```java
  CommPortIdentifier portIdentifier = null
  ```

  * `CommPortIdentifier`가 RXTXcomm.jar에 존재하는 Class이다.

  * null로 지정해준 이유

    * 이후에 try-catch문을 사용하여 예외처리를 진행하며 객체를 생성할 예정이다.

  * 객체 생성은 `CommPortIdentifier`의 **static method**를 이용하여 처리한다.

    ```java
    portIdentifier = CommPortIdentifier.getPortIdentifier("COM9");
    ```

    * `getPortIdentifier`의 인자는 Arduino가 연결되었을때 연결된 포트번호를 입력한다.

* 해당 포트가 다른 프로세스에 의해 점유되고 있는지 확인

  * 포트가 사용되고 있는지 확인한다.

  ```java
  if(portIdentifier.isCurrentlyOwned()) {
  	System.out.println("포트가 사용중입니다.");
  }
  ```

  * 포트가 사용중이 아니라면, 

    * Port를 열어서 Port 객체를 생성한다.

      ```java
      else {
          CommPort commPort = portIdentifier.open("PORT_OPEN", 2000);
      ```

      * `open()`의 두 인자는 Description이므로 사용자 임의로 지정하면 된다.

* Port객체를 얻어온 후 사용할 수 있는 Port는 두 개가 있다.

  * `SerialPort`, `ParallelPort`

  * Serial은 단일 선으로 연결되어 있는 것처럼 입출력단자가 한개씩인 경우다.

  * Parallel은 여러 개의 선으로 연결되어 있는 것처럼 입출력단자가 여러 개인 경우다.

    * 데이터를 병렬방식으로 전송하며 Arduino에 입출력단자가 여러개가 필요하다.

  * `SerialPort`로 이용할 수 있으므로 `ParallelPort`가 들어오면 프로그램을 끝낸다.

    ```java
    if(commPort instanceof SerialPort) {
    	
    } else {
    	System.out.println("Serial Port만 이용할 수 있다.");
    }
    ```

  * `SerialPort`임을 확인했으면 `commPort`를 `SerialPort`로 **Casting**한다.

    ```java
    SerialPort serialPort = (SerialPort)commPort;
    ```

  * Port의 통신속도를 설정한다.

    ```java
    serialPort.setSerialPortParams(9600, 
                                   SerialPort.DATABITS_8, 
                                   SerialPort.STOPBITS_1, 
                                   SerialPort.PARITY_NONE);
    ```

    * 첫 번째 인자는 Arduino의 보드레이트이다.
    * 2, 3, 4번째 인자는 전송비트, 중단비트, 패리티를 의미하는데 보통 위의 코드를 사용한다.