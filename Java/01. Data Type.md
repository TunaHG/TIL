# Data Type

> Data는 변수(Variable)이라고 한다.

## 1. Variable Naming Rule

> 변수명은 다음 4가지의 규칙을 가지고 작성해야 한다.

1. 대소문자가 구분되며 길이에 제한은 없다.
   ex) `Abc`, `abc` 두 변수명은 다른 변수명이다.
2. 예약어를 사용해서는 안된다.
   ex) `class`, `static`, `final` 등 Java에서 예약어로 지정된 단어들은 안된다.
3. 숫자로 시작해서는 안된다.
   ex) `abc1`과 같은 변수명은 가능하지만 `1abc`와 같은 변수명은 안된다.
4. 특수문자는 `_`와 `$`만을 허용한다.
   ex) `_abc`와 `abc$`와 같은 변수명은 가능하지만 `#abc`와 같은 변수명은 안된다.

## 2. Primitive Data Types
### 1. Data declaration

* 다음과 같이 선언한다.

  ```java
  int num = 99;
  ```

  * int가 Data Type, num이 변수명(Variable name), 99가 변수 값(value)이다.

### 2. Logical Data

> 논리형 기본 데이터 타입은 boolean이 있다.

* `boolean`은 참을 뜻하는 true, 거짓을 뜻하는 false 두가지 값만을 가질 수 있다.

### 3. Character Data

> 문자형 기본 데이터 타입은 char이 있다.

* `char`는 `'a'`와 같이 `''`안에 단일 문자로 값을 가질 수 있다.

### 4. Numeric Data

> 각 데이터 타입은 -2의 (자신의 bit크기 - 1)제곱부터 2의 (자신의 bit크기 -1)제곱 -1까지의 값을 가질 수 있다.

#### 1. 정수형

> 정수형 기본 데이터 타입은 byte, short, int, long이 있다

* `byte`는 1byte의 크기를 가진다.

* `short`는 2byte의 크기를 가진다.

* `int`는 4byte의 크기를 가진다.

  * Java에서 기본 정수형의 데이터 타입이다.

* `long`은 8byte의 크기를 가진다.

  * long으로 선언하기 위해서는 다음과 같이 선언해야 한다.

    ```java
    long num1 = 12l;
    long num2 = 12L;
    ```

#### 2. 실수형

> 실수형 기본 데이터 타입은 float, double이 있다.

* `float`는 4byte의 크기를 가진다.

  * `float`로 선언하기 위해서는 다음과 같이 선언해야 한다.

    ```java
    float num1 = 12f;
    float num2 = 12F;
    ```

* `double`은 8byte의 크기를 가진다.

  * Java에서 기본 실수형의 데이터 타입이다.

### 5. Printf

> `printf()`에서 %를 사용하여 기본형 데이터 타입을 출력하는 방법을 알아본다.

```java
int a = 1;
double b = 1.1;
char c = 'A';
boolean d = true;
String e = "Hello";

System.out.printf("%d %f %c %b %s", a, b, c, d, e);
```

### 6. Casting (데이터 변환)

> 형 변환은 맞지 않는 자료형을 선언한 자료형에 맞게 맞춰주는 것인데, 이는 작은 byte형이 큰 byte형으로 변환되는 것은 아무런 문제없이 자동적으로 변환된다. 하지만 큰 byte형이 작은 byte형으로 변환되는 것은 자동적으로 되지 않고 강제로 변환해줘야한다.

* 다음과 같은 방식으로 Casting을 진행한다

  ```java
  int num = 65;
  char c = (int)num;
  ```

* ASCII를 활용한 Casting활용 방안

  ```java
  char c = 'A';
  System.out.println('C'-c); // 2
  System.out.println(c+1);   // 66
  System.out.println(++c);   // B
  System.out.println(c++);   // B
  System.out.println(c+=1);  // D
  ```

## 3. Reference Data Types

### 1. Data declaration

* 다음과 같이 선언한다.

  ```java
  java.util.Date date = new java.util.Date();
  ```

*   패키지를 가져왔다면 다음과 같이 선언한다.

  ```java
  import java.util.Date;
  Date date = new Date();
  ```

### 2. String

> String은 문자열로써 많이 사용하므로 먼저 알아둔다.
>
> String은 참조형 데이터 타입중 new를 이용하여 객체를 생성하지 않는 유일한 데이터 타입이다.

* 하지만 객체를 생성할 수 있다.

  ```java
  String str = new String(); // 가능하다.
  String str = "Hello World!";
  ```

* String에서 사용할 몇가지 함수를 알아본다.

  ```java
  String str = "Hello java!";
  char[] c = str.toCharArray();
  System.out.println(str.substring(0, 5));  // Hello, start와 end부분까지의 일부분 추출
  System.out.println(str.substring(6));     // java!, start부분부터 끝까지 추출
  System.out.println(str.indexOf("a"));     // 7    , "a"가 발견되는 첫 위치 추출
  System.out.println(str.lastIndexOf("a")); // 9    , "a"가 발견되는 마지막 위치 추출
  ```

### 3. Class File

> 객체의 Class파일을 Ctrl + MLB(Mouse Left Button)을 통해 찾을 수 있다.

* Source Not Found에러가 발생한다면 다음 사이트에서 문제를 해결한다.
  * [문제 해결 사이트](https://treasurebear.tistory.com/42)

# Codes

* [Simple println()](https://github.com/TunaHG/Java_Programming/blob/master/src/Day01/Sample01.java)

* [Simple print()](https://github.com/TunaHG/Java_Programming/blob/master/src/Day01/Sample02.java)

* [Simple printf()](https://github.com/TunaHG/Java_Programming/blob/master/src/Day01/Sample03.java)

* [Simple Data Type -1](https://github.com/TunaHG/Java_Programming/blob/master/src/Day01/Sample04.java)

* [Simple Data Type -1](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test01.java)

* [Simple RDT](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test02.java)

* [Simple String](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test03.java)

* [Print Integer](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test05.java)