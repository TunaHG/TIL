# Java IO

* Stream을 이용해서 처리한다.

  * Stream : Data를 받아들이고 보낼 수 있는 통로

* Java Program에서 표준출력(Dos창)에 문자열을 출력하고 싶다면,
  Java Program과 연결된 Dos창에 대한 Stream이 존재해야 한다.

* 평소에 간단하게 사용했던 Stream에 대해 알아본다.

  ```java
  System.out.println("Print Message");
  ```

  * System.out : 표준출력(Dos)에 연결된 Stream
    * 이미 우리에게 제공된 Stream
  * Stream이 가지는 `println()`이라는 method를 이용하여 실제 문자열을 Dos에 전달

## Stream

* Stream은 객체로 존재한다.
  * 이는 Class가 존재하는 것을 의미한다.
* 객체로 생성된 Stream의 method를 이용해서 Data의 입출력을 수행한다.
* Stream은 입력Stream과 출력Stream 두 개로 나뉜다.
  * 이 데이터 연결 통로는 단방향이다.
  * InputStream
    * 가장 기본적인 입력 Stream
  * OutputStream
    * 가장 기본적인 출력 Stream
  * 가장 기본적인 Stream은 성능이 좋지 않다.
    * 다른 Stream과 결합하여 더 좋은 Stream을 만들 수 있다.

### InputStream

> Dos에서 문자열을 입력받고 싶을 때 사용

* 기본적으로 InputStream이 존재해야 Data를 받을 수 있다.

* System.in

  * Dos와 연결된 InputStream

* InputStream은 효율도 좋지 않고 문자열을 읽어들이기에 좋지 않다.

* InputStream을 문자열 입력받기 좋은 InputStreamReader로 업그레이드한다.

  ```java
  InputStreamReader isr = new InputStreamReader(System.in);
  ```

* InputStreamReader보다 좋은 BufferedReader로 업그레이드한다.

  ```java
  BufferedReader br = new BufferedReader(isr);
  ```

  * InputStreamReader를 이용한다.

  * BufferedReader를 이용하면 `readLine()`이라는 method를 사용할 수 있기에 추천된다.

    * InputStreamReader에서는 한 줄씩 읽을 수 없고, 한 문자씩 읽는다.

    ```java
    String msg = br.readLine();
    ```

    * Exception을 처리한다.
      * try-catch문으로 묶어주거나 throws exception처리를 한다. (IOException)

### ObjectStream

> 단순 문자열이 아닌 객체 또한 Stream으로 전달할 수 있다.

* HashMap객체를 Stream으로 전달해볼 예정이므로 해당 객체를 생성한다.

  ```java
  Map<String, String> map = new HashMap<String, String>();
  ```

  * 객체에 값을 넣는다.

    ```java
    map.put("1", "홍길동");
    map.put("2", "신사임당");
    map.put("3", "강감찬");
    map.put("4", "유관순");
    ```

* Text 파일로 Output을 저장할 예정이므로 File 객체를 생성한다.

  ```java
  File file = new File("asset/StringData.txt");
  ```

  * Eclipse에서 진행한다면 해당 Project내에 asset폴더를 생성해야한다.
  * 파일은 생성되어있지 않으면 자동적으로 생성한다.

* File객체로 보내기위한 Stream을 생성한다.

  ```java
  FileOutputStream fos = new FileOutputStream(file);
  ```

* Object 객체를 보내기 위한 Stream을 생성한다.

  ```java
  ObjectOutputStream oos = new ObjectOutputStream(fos);
  ```

  * 생성한 객체를 이용하여 HashMap객체를 Stream에 넣고 전달한다.

    ```java
    oos.writeObject(map);
    oos.flush();
    			
    oos.close();
    fos.close();
    ```

    * 닫는 순서는 여는 순서의 반대로 닫아주어야 한다.

## FileReader

* 특정 파일의 위치를 정해줌으로써 해당 파일을 읽어올 수 있다.

  ```java
  FileReader fr = new FileReader(fileDirectory);
  ```

* 해당 객체를 BufferedReader로 넘겨줌으로써 한줄 씩 읽어올 수 있다.

  ```java
  BufferedReader br = new BufferedReader(fr);
  ```

* 역시 Exception 처리를 해줘야한다.

  * File에 대한 FileNotFoundException
  * BufferedReader에 대한 IOException

