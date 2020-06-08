# Reactor

## Reactor Pattern

> Protocol 추가에 유연한 Server

* Handle Map을 사용하여 변경

  * Handle Map은 Map형태로 헤더에 해당하는 키를 가진 값을 찾기 위한 객체
  * 이전에 Dispatcher에서 진행했던 Protocol들이 전부 Event Handler로 변경됨

* Handler의 형태를 정의

  * HandleMap에서 다형성을 이용하여 클래스를 관리할 수 있도록

  * EventHandler라는 인터페이스를 생성

    ```java
    import java.io.InputStream;
    
    public interface EventHandler {
    	
    	// Handler마다 가지고 있는 고유의 키값을 반환하는 Method
    	// HandlerMap에 키값으로 등록하기 위해
    	public String getHandler();
    	
    	// 데이터를 받아서 처리하는 Method
    	public void handleEvent(InputStream inputStream);
    }
    ```

* Handler를 관리하는 HandleMap Class 생성

  ```java
  import java.util.HashMap;
  
  public class HandleMap extends HashMap<String, EventHandler> {
  
  }
  ```

* 각 Protocol Class들을 Event Handler Class로 변경

  * Reactor의 Rename을 사용하여 각 Class의 이름을 변경
    * Protocol을 EventHandler로 변경
  * EventHandler를 상속 (`implements EventHandler`)
  * 구현되지 않은 `getHandler()`를 Overriding
    * 기존 Dispatcher에서 swtich로 지정해주던 헤더를 의미함
    * 해당 Method를 이용하여 HandleMap의 키값으로 사용
    * return값은 각 Protocol의 헤더를 의미하는 `0x5001`과 `0x6001`로 변경

* 이제 HandleMap에 Handler를 등록하고 호출하면 HandleMap의 키값에 해당하는 EventHanlder를 실행

  * 이 과정이 Reactor Pattern

* Reactor Class 생성

  ```java
  import java.io.IOException;
  import java.net.ServerSocket;
  
  public class Reactor {
  	private ServerSocket serverSocket;
  	private HandleMap handleMap;
  	
  	public Reactor(int port) {
  		handleMap = new HandleMap();
  		try {
  			serverSocket = new ServerSocket(port);
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
  	}
  	
  	public void startServer() {
  		
  		Dispatcher dispatcher = new Dispatcher();
  		
  		while(true) {
  			dispatcher.dispatch(serverSocket, handleMap);
  		}
  	}
  	
  	// Handler를 등록하는 Method
  	public void registerHandler(EventHandler handler) {
  		// put(Handler의 Header, Handler)
  		handleMap.put(handler.getHandler(), handler);
  	}
  	
  	public void removeHandler(EventHandler handler) {
  		handleMap.remove(handler.getHandler());
  	}
  }
  ```

* Server Class에서 Reactor를 사용하도록 변경

  ```java
  public class ServerInitializer {
  
  	public static void main(String[] args) {
  		int port = 5000;
  		System.out.println("Server ON : " + port);
  		
  		Reactor reactor = new Reactor(port);
  		
  		reactor.registerHandler(new StreamSayHelloEventHandler());
  		reactor.registerHandler(new StreamUpdateProfileEventHandler());
  		
  		reactor.startServer();
  	}
  
  }
  
  ```

* Dispatcher Class에서 HandleMap을 사용하도록 변경

  ```java
  import java.io.IOException;
  import java.io.InputStream;
  import java.net.ServerSocket;
  import java.net.Socket;
  
  public class Dispatcher {
  	
  	private final int HEADER_SIZE = 6;
  	
  	public void dispatch(ServerSocket serverSocket, HandleMap handleMap) {
  		try {
  			Socket socket = serverSocket.accept();
  			demultiplex(socket, handleMap);
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
  	}
  	public void demultiplex(Socket socket, HandleMap handleMap) {
  		InputStream inputStream;
  		try {
  			inputStream = socket.getInputStream();
  			
  			byte[] buffer = new byte[HEADER_SIZE];
  			inputStream.read(buffer);
  			String header = new String(buffer);
  			
  			handleMap.get(header).handleEvent(inputStream);
              
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
  	}
  }
  
  ```

* 실행하면 이전과 동일한 결과가 출력

## Simple Framework

> SimpleFramework를 사용하여 XML을 읽어와 Class로 사용하는 법을 학습

## 문제점

> 서버에 접속이 몰리고 느린 접속자가 있을 경우의 문제점