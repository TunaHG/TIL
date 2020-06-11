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
              
              socket.close();
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
  	}
  }
  
  ```

* 실행하면 이전과 동일한 결과가 출력

## Simple Framework

> SimpleFramework를 사용하여 XML을 읽어와 Class로 사용하는 법을 학습

* 서버는 서버점검이 있기도 하지만 가능하면 24시간 계속 실행되고 있어야 함

  * 하지만 서버의 메인 로직을 수정하게되면 다시 컴파일하고 서버를 재시작 해야함
  * React 패턴과 설정 정보를 외부로 분리
    * 서버가 운영중에도 XML과 JAR파일로 Handler를 추가하면 서버를 중지시키지 않고도 기능을 추가하거나 뺄 수 있음

* XML파싱에 SImpleFramework를 사용하기 위해 JAR파일을 다운로드 받음

  * [Download Site](http://simple.sourceforge.net/download.php)
  * JAR파일을 다운로드 받은 이후 Project의 Build Path로 추가

* XML파일을 하나 생성

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <serverList>
  	<server name="server1">
  		<handler header="0x5001">StreamSayHelloEventHandler</handler>
  		<handler header="0x6001">StreamUpdateProfileEventHandler</handler>
  	</server>
  	<server name="server2">
  		<handler header="0x5001">StreamSayHelloEventHandler</handler>
  		<handler header="0x6001">StreamUpdateProfileEventHandler</handler>
  	</server>
  </serverList>
  ```

  * 클래스 이름을 XML형식으로 정리
  * 미리 서버 종류에 따라 다른 핸들러를 사용하도록 생성
  * server2가 있는 이유는 차후에 핸들러를 바로 변경할 수 있게하기 위함

* XML파일을 Java에서 자동으로 인식하도록 Class를 생성

  * Annotation을 사용하여 XML의 각 인자를 잡도록 설정

  * ServerListData Class

    ```java
    import java.util.List;
    
    import org.simpleframework.xml.ElementList;
    
    public class ServerListData {
    	
    	@ElementList(entry="server", inline=true)
    	private List<HandlerListData> server;
    	
    	public List<HandlerListData> getServer(){
    		return server;
    	}
    }
    ```

  * HandlerListData Class

    ```java
    import java.util.List;
    
    import org.simpleframework.xml.Attribute;
    import org.simpleframework.xml.ElementList;
    
    public class HandlerListData {
    	
    	@ElementList(entry="handler", inline=true)
    	private List<HandlerData> handler;
    	
    	@Attribute
    	private String name;
    	
    	public List<HandlerData> getHandler() {
    		return handler;
    	}
    	
    	public String getName() {
    		return name;
    	}
    }
    ```

  * HandlerData Class

    ```java
    import org.simpleframework.xml.Attribute;
    import org.simpleframework.xml.Text;
    
    public class HandlerData {
    	@Attribute(required=false)
    	private String header;
    	
    	@Text
    	private String text;
    	
    	public String getHeader() {
    		return header;
    	}
    	
    	public String getText() {
    		return text;
    	}
    }
    ```

* Reactor Class에 새로운 Method 생성

  ```java
  // getHandler()를 사용하지 않고 XMl의 header를 가져와서 등록할 때 사용하는 MEthod 
  public void registerHandelr(String header, EventHandler handler) {
  	handleMap.put(header, handler);
  }
  ```

  * getHandler()를 사용하여 등록하는 Method와 동일한 Depth에 생성

* Server Class에 SimpleFramework를 사용한 XML 객체를 생성

  ```java
  try {
  	Serializer serializer = new Persister();
  	File source = new File("HandlerList.xml");
  	ServerListData serverList = serializer.read(ServerListData.class, source);
  	
  } catch (Exception e) {
  	e.printStackTrace();
  }
  ```

  * Reactor 객체 생성 이후에 바로 생성

  * 서버 정보를 가져오고, server1의 Handler를 가져옴

    ```java
    for (HandlerListData handlerListData : serverList.getServer()) {
    	if("server1".equals(handlerListData.getName())) {
    		List<HandlerData> handlerList = handlerListData.getHandler();
    		for(HandlerData handler : handlerList) {
                         
    		}
    		break;
    	}
    }
    ```

  * handler 객체의 Data를 활용하여 Reactor에 Handler를 등록

    ```java
    try {
    	reactor.registerHandelr(handler.getHeader(), (EventHandler) Class.forName(handler.getHandler()).newInstance());
    } catch (InstantiationException e) {
    	e.printStackTrace();
    } catch (IllegalAccessException e) {
    	e.printStackTrace();
    } catch (ClassNotFoundException e) {
    	e.printStackTrace();
    }
    ```

  * 이전에 사용했던 Handler 등록하는 두 줄을 주석처리하고 실행

    ```java
    //		reactor.registerHandler(new StreamSayHelloEventHandler());
    //		reactor.registerHandler(new StreamUpdateProfileEventHandler());
    ```

## Reactor Thread

> 지금까지 작성한 Reactor의 문제점은 서버에 접속이 몰리고 느린 접속자가 있을 경우

* TestClient Class

  * while문과 Thread.sleep을 통해 여러 개의 접속을 시도

  ```java
  import java.io.IOException;
  import java.io.OutputStream;
  import java.net.Socket;
  import java.net.UnknownHostException;
  
  public class TestClient {
  
  	public static void main(String[] args) {
  		System.out.println("Client ON");
  		while (true) {
  			try {
  				String message;
  
  				Socket socket = new Socket("127.0.0.1", 5000);
  				OutputStream out = socket.getOutputStream();
  				message = "0x5001|홍길동|22";
  				out.write(message.getBytes());
  				socket.close();
  
  				Socket socket2 = new Socket("127.0.0.1", 5000);
  				OutputStream out2 = socket2.getOutputStream();
  				message = "0x6001|hong|1234|홍길동|22|남성";
  				out2.write(message.getBytes());
  				socket2.close();
  				
  				Thread.sleep(100);
  			} catch (UnknownHostException e) {
  				e.printStackTrace();
  			} catch (IOException e) {
  				e.printStackTrace();
  			} catch (InterruptedException e) {
  				e.printStackTrace();
  			}
  		}
  	}
  
  }
  
  ```

  * 이 경우 Eclipse에서는 잘 돌아가는 것 같지만, Telnet으로 연결하면 테스트 데이터가 중단되는 현상이 발생
    * 느린 접속이 오면 그 접속을 처리하느라 다른 연결을 처리하지 못하기 때문

* 이 문제를 해결하기 위해 Thread를 사용

  * 접속이 오면 Thread로 일을 처리하여 다른 접속을 할 수 있도록 변경

* Dispatcher의 Demultiplex기능을 별도의 Thread로 분리

  * 해당 기능에서 지연문제가 발생하기 때문

  * Demultiplexer Class를 생성

    ```java
    import java.io.IOException;
    import java.io.InputStream;
    import java.net.Socket;
    
    public class Demultiplexer implements Runnable {
    	private final int HEADER_SIZE = 6;
    	
    	private Socket socket;
    	private HandleMap handleMap;
    	
    	public Demultiplexer(Socket socket, HandleMap handleMap) {
    		this.socket = socket;
    		this.handleMap = handleMap;
    	}
    	
    	@Override
    	public void run() {
    		try {
    			InputStream inputStream = socket.getInputStream();
    			
    			byte[] buffer = new byte[HEADER_SIZE];
    			inputStream.read(buffer);
    			String header = new String(buffer);
    			
    			handleMap.get(header).handleEvent(inputStream);
    			
    			socket.close();
    		} catch (IOException e) {
    			e.printStackTrace();
    		}
    	}
    }
    
    ```

    * Thread로 사용해야 하기 때문에 Runnable Interface를 상속
    * Dispatcher의 Demultiplex기능을 가져오고, 생성자를 사용하여 필요한 객체를 가져옴

* Dispatcher에서 Demultiplexer를 Thread로 실행

  ```java
  import java.io.IOException;
  import java.net.ServerSocket;
  import java.net.Socket;
  
  public class Dispatcher {
  	
  	public void dispatch(ServerSocket serverSocket, HandleMap handleMap) {
  		try {
  			Socket socket = serverSocket.accept();
  			
  			Runnable demultiplexer = new Demultiplexer(socket, handleMap);
  			Thread thread = new Thread(demultiplexer);
  			thread.start();
  		} catch (IOException e) {
  			e.printStackTrace();
  		}
  	}
  }
  ```

* 이후 Telnet으로 데이터 전송이 지연시켜도 TestClient는 문제없이 데이터를 전송

  * 하지만 이렇게 코드를 구성하면 매번 접속이 들어올 때마다 Thread가 생성됨
  * Thread가 많아지면 Context Switching에 엄청난 비용이 소모되어 서버가 전체적으로 느려지고 메모리에 문제가 생김
    * 결국 서버가 죽는 일이 발생

* Thread Pool을 사용하여 위의 문제를 해결

  * Dispatcher Class의 Class명을 Rename을 사용하여 ThreadPerDispatcher로 수정
    * 기존에 존재하던 방식을 그대로 두고, 다른 방식을 만들 것이기 때문

* Dispatcher Interface 생성

  ```java
  import java.net.ServerSocket;
  
  public interface Dispatcher {
  	public void dispatch(ServerSocket serverSocket, HandleMap handleMap);
  }
  ```

  * ThreadPerDispatcher와 ThreadPoolDispatcher를 관리하기 편하게 하는 Interface

* ThreadPerDispatcher Class와 Reactor Class 변경

  * ThreadPerDispatcher Class의 dispatch() 내용을 while문으로 묶어줌
  * Reactor Class의 startServer()에 구성했던 while문을 제거

* ThreadPoolDispatcher Class 생성

  ```java
  import java.io.IOException;
  import java.net.ServerSocket;
  import java.net.Socket;
  
  public class ThreadPoolDispatcher implements Dispatcher {
  	
  	static final String NUMTHREADS = "8";
  	static final String THREADPROP = "Threads";
  	
  	private int numThreads;
  	
  	public ThreadPoolDispatcher() {
  		// 시스템 정보의 Thread 수를 가져오거나 기본 값을 가져옴
  		numThreads = Integer.parseInt(System.getProperty(THREADPROP, NUMTHREADS));
  	}
  	
  	public void dispatch(final ServerSocket serverSocket, final HandleMap handleMap) {
  		for (int i = 0; i < (numThreads - 1); i++) {
  			Thread thread = new Thread() {
  				public void run() {
  					dispatchLoop(serverSocket, handleMap);
  				}
  			};
  			thread.start();
  			System.out.println("Created and started Thread = " + thread.getName());
  		}
  		System.out.println("Iterative server starting in main thread " + Thread.currentThread().getName());
  		
  		dispatchLoop(serverSocket, handleMap);
  	}
  	
  	private void dispatchLoop(ServerSocket serverSocket, HandleMap handleMap) {
  		while (true) {
  			try {
  				Socket socket = serverSocket.accept();
  				Runnable demultiplexer = new Demultiplexer(socket, handleMap);
  				demultiplexer.run();
  			} catch (IOException e) {
  				 e.printStackTrace();
  			}
  		}
  	}
  }
  ```

  * 생성자를 만들어 Thread 수를 정함
  * dispatch()를 만들며 dispatchLoop()를 실행하도록 생성
  * dispatchLoop()를 생성
    * 여기서 Demultiplexer를 실행

* Reactor Class에서 ThreadPer이 아닌 ThreadPool을 실행

  ```java
  public void startServer() {
  
  //		Dispatcher dispatcher = new ThreadPerDispatcher();
  		Dispatcher dispatcher = new ThreadPoolDispatcher();
  
  //		while (true) {
  			dispatcher.dispatch(serverSocket, handleMap);
  //		}
  }
  ```

* 동시에 Pool의 갯수만큼의 Thread를 동시에 처리하고 나머지 접속에 대해서는 처리를 미룸

  * 결국엔 Thread수가 많아야 동시에 처리할 수 있는게 많아짐
    * 하지만 Thread수가 너무 많으면 안됨
  * Thread를 적게 쓰면서 처리 효율을 좋게하는 방법은 없을까?

* **참고내용**

  * 동기 vs 비동기
    * Client와 Server간의 관계
    * Server내에서 User Level과 Kernel Level과의 관계 Blocking vs Non-Blocking