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

## Using Thread

### Eclipse

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

* 데이터 통신을 위해 Stream을 생성한다.

  * Serial 통신에서는 Byte방식으로 통신하기 때문에 기본 Stream을 사용한다.

  ```java
  InputStream in = serialPort.getInputStream();
  OutputStream out = serialPort.getOutputStream();
  ```

* Thread를 이용해서 Arduino로부터 들어오는 데이터를 반복적으로 받는다.

  * Anonymous Inner Class를 사용한다.

  ```java
  Thread t = new Thread(new Runnable() {
  	@Override
  	public void run() {
  		
  	}
  });
  t.start();
  ```

  * Byte방식으로 들어오므로 Byte배열을 생성한다.

    ```java
    byte[] buffer = new byte[1024];
    ```

    * 데이터가 얼마나 들어오는지 모르기때문에 적당히 큰값을 잡는다.

  * InputStream으로 들어온 Byte를 읽어서 Byte배열에 넣는 과정을 반복한다.
  
    ```java
    int len = -1;
    try {
    	while((len = in.read(buffer)) != -1) {
    		System.out.print("Data: " + new String(buffer, 0, len));
    	}
    } catch (Exception e) {
    	e.printStackTrace();
  }
    ```
  
    * len은 Data의 Size를 의미한다. -1은 데이터가 존재하지 않는다는 의미다.
    * `new String()`은 buffer배열중 0번째부터 len번째까지 출력한다는 의미다.
  
* [Code]

### Arduino

* `setup()`을 다음과 같이 구성한다.

  ```c
  void setup() {
    Serial.begin(9600);
  }
  ```

  * 9600 보드레이트를 지정한다.

* `loop()`를 다음과 같이 구성한다.

  ```c
  void loop() {
    Serial.println("Hello World");
    delay(1000);
  }
  ```

  * 1초마다 Serial 통신으로 Hello World를 전송하도록 설정한다.

* 업로드하여 확인한다.

  * Arduino보드에서 TX라고 쓰여있는 부분이 1초마다 깜박인다.
  * TX가 데이터를 전송을 의미한다.
  * RX는 데이터 수신을 의미한다.

## Using Event

### Eclipse

* [Using Thread](#Using Thread)의 코드에서 Thread부분만 제거하고 나머지는 동일하게 구성한다.

  * Thread가 들어있던 부분에 Event를 이용한 처리를 넣을 예정이다.

* 이벤트를 처리하는 Listener객체를 만들기 위한 Class를 정의해야 한다.

  * `SerialPortEventListener`라는 인터페이스를 상속받는다.

    ```java
    class SerialListener implements SerialPortEventListener {}
    ```

  * 추상메소드인 `serialEvent()`를 Overriding한다.

    * 이벤트가 발생하면 호출되는 method이다.

    ```java
    @Override
    public void serialEvent(SerialPortEvent arg0) {
    
    }
    ```

* 이벤트 처리를 `serialPort`에 추가한다.

  ```java
  serialPort.addEventListener(new SerialListener(in));
  ```

  * Event처리 객체가 Arduino로부터 들어오는 Data를 받아서 처리를 진행해야 한다.

    * 인자로 InputStream을 가진다.

  * 해당 Class에도 전역변수 선언과 생성자 선언을 진행한다.

    ```java
    private InputStream in;
    	
    SerialListener(InputStream in){
    	this.in = in;
    }
    ```

  * Data가 들어왔을 때, Event 처리가 진행되도록 신호를 주는 method를 설정한다.

    ```java
    serialPort.notifyOnDataAvailable(true);
    ```

    * 해당 코드는 `addEventListener()`아래에 작성한다.

* Overriding했던 Event처리 method를 구성한다.

  * EventType을 체크한다.

    ```java
    if(arg0.getEventType() == SerialPortEvent.DATA_AVAILABLE)
    ```

  * InputStream에 데이터가 존재하는지 확인한다.

    ```java
    int k = in.available();
    ```

    * `available()`의 return값은 Data의 Size를 의미하므로 k는 Data의 크기를 의미한다.

  * Data의 size를 알기 때문에 size만큼의 byte[]를 선언한다.

    ```java
    byte[] data = new byte[k];
    ```

  * InputStream의 데이터를 읽어와서 byte[]에 저장한다.

    ```java
    in.read(data, 0, k);
    ```

  * 저장된 데이터를 출력한다.

    ````java
    System.out.println("Data: " + data);
    ````

### Arduino

* Using Thread와 동일하다.