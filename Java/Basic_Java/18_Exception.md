# Exception

## Try-Catch

![img](https://postfiles.pstatic.net/MjAxOTEyMTNfNjMg/MDAxNTc2MjIxMDM5NTg3.7UjYVIlW33vl9fcH6dRcTZNvgpLXLdTGUTqzMhsy9oYg.8EMJZPqVaBXF89sdSos9u5OEYxN8pNR-C3CxzYOMaNgg.PNG.asdf0185/Exception.png?type=w773)

> Error가 아닌 Exception에 해당하는 부분을 알아본다.

* `try-catch`문을 사용하지 않아도 컴파일 에러를 발생 안하는 것이 `Unchecked Exception`이며 컴파일 에러가 발생하는 것이 `Checked Exception`이다.

* 코드에서 `try-catch-finally`문을 이용함으로써 `Error`가 발생해서 실행이 중단되는 상황을 예방할 수 있다.

  ```java
  try{
      에러가 발생할 것이라 예상되는 부분;
  } catch(감지할 에러) {
      감지할 에러가 발생하면 실행할 부분;
  } finally {
      에러가 발생하든 안하든 try문 이후에 실행할 부분;
  }
  ```

* 숫자가 아닌 값을 숫자로 변경하려 한다면 `NumberFormatException`이 발생한다.

  ```java
  String msg = "백";
  int num = 0;
  try {
      num = Integer.parseInt(msg);
  } catch(NumberFormatException e) {
      System.out.println(e);
  }
  ```

* 숫자를 0으로 나누는 경우에 `ArithmeticException`가 발생한다.

  ```java
  int res = 0;
  try {
      res = 1000/num;
  } catch(ArithmeticException e2) {
      e2.printStackTrace();
  }
  ```

  * `Exception` 타입의 변수에는 `Exception`의 발생 경로를 추적해주는 `printStackTrace()`메소드가 존재한다.

* 모든 에러를 포함하는 `Exception`이 존재한다.

* `try`문 내부에서 에러가 발생하면 에러가 발생한 라인 이후의 라인은 실행되지 않는다.

* `finally`는 어떠한 경우에도 실행되기 때문에 보통 `try`에서 사용한 객체의 자원 반납을 진행하는 코드를 작성한다.

  * `try`에 자원반납코드를 작성하는 경우가 있는데, 이는 에러가 발생했을 시 실행이 안되기 때문에 옳지않은 방법이다.

* `try` 구현부가 아닌 선언부에 ()를 이용하여 객체를 생성해줄 수 있다. 이 때는 `finally`에서 자원반납코드를 따로 작성할 필요없이 `try`가 끝남과 동시에 자원반납이 자동으로 이루어진다. 이를 `try-with-resource`라 한다.

  ```java
  try(Scanner sc = new Scanner(System.in)){
      
  } catch (Exception e){
      
  }
  ```

## Throw

> 일부러 예외를 발생시키는 방법

* `Exception`객체를 생성할 수 있다.

  ```java
  new Exception("Error");
  ```

* 생성된 `Exception`객체를 `throw`를 이용하여 강제로 예외를 발생시킬 수 있다.

  ```java
  try {
      throw new Exception("Error");
  } catch (Exception e) {
      
  }
  ```

  * `try`에서 `throw`를 만나 예외가 발생했다고 판단하여 `catch`로 넘어간다.

## Throws

> 자신이 가진 코드에서 예외가 발생했을 때 자신이 처리하는 것이 아닌 자신을 사용하는 다른 Class나 Method에서 예외를 처리하도록 보내는 것

* `throws`는 `method`의 선언부에 추가한다.

  ```java
  public void output(int money) throws Exception { }
  ```

* `throws`가 포함된 `method`를 사용하는 부분에서 `try-catch`를 사용하여 예외처리를 해야한다.

  ```java
  try{
      output(7000);
  } catch (Exception e){
      
  }
  ```

## My Exception

> 직접 예외를 만들 수 있다.

* 예외처리를 만들 땐 항상 예외중 누군가를 상속으로 받아야 예외로 처리할 수 있다.

  ```java
  class MoneyException extends Exception {}
  ```

# Codes

* [Exception](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test05_exception.java)
* [Throw](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test06_throw.java)
* [File Exception](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test07_fileexception.java)
  * [bookdata.txt](https://github.com/TunaHG/Java_Programming/blob/master/bookdata.txt)
  * [Book](https://github.com/TunaHG/Java_Programming/blob/master/src/Prob/Prob05/Book.java)
* [Throw main](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test09_throwMain.java)