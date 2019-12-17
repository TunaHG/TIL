# StringTokenizer

> String을 공백을 기준으로 나눠서 사용할 수 있는 Class이다.

* `java.util`패키지에 존재하는 Class다

  ```java
  import java.util.StringTokenizer;
  ```

* String을 입력받고 `nextToken()`을 사용하여 공백을 기준으로 하나씩 출력한다.

  ```java
  Scanner scan = new Scanner(System.in);
  StringTokenizer st = new StringTokenizer(scan.nextLine());
  String title = st.nextToken();
  int price = Integer.parseInt(st.nextToken());
  ```

  * `nextToken()`의 `return`타입은 `String`이다.

# Codes

* [StringTokenizer](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test08_StringTokenizer.java)
  * [bookdata.txt](https://github.com/TunaHG/Java_Programming/blob/master/bookdata.txt)
  * [Book](https://github.com/TunaHG/Java_Programming/blob/master/src/Prob/Prob05/Book.java)