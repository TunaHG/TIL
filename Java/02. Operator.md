# Operator

## 1. 산술 연산자

### 1. 사칙연산, 나머지연산

> `+`, `-`, `*`, `/`, `%`를 활용하여 연산한다. 코드를 활용하여 알아본다.

```java
System.out.println(3 + 2); // 덧셈,  5
System.out.println(3 - 2); // 뺄셈,  1
System.out.println(3 * 2); // 곱셈,  6
System.out.println(3 / 2); // 나눗셈, 1
System.out.println(3 / 2.);// 나눗셈, 1.5
System.out.println(3 % 2); // 나머지, 1
```

### 2. + 대입연산자

> `+=`, `-=`, `*=`, `/=`, `%=` 등의 연산자가 존재한다.

```java
int num1 = 3, num2 = 2;
System.out.println(num1 += num2);
System.out.println(num1 -= num2);
System.out.println(num1 *= num2);
System.out.println(num1 /= num2);
System.out.println(num1 %= num2);
```

### 3. ++, --연산자

> `num++`, `++num`, `num--`, `--num`등의 연산자가 존재한다.

```java
int num = 1;
System.out.println(num++); // 1
System.out.println(++num); // 3
System.out.println(num--); // 3
System.out.println(--num); // 1
```

* 변수 뒤에 ++나 --가 붙는다면 해당 코드를 실행한 이후에 1을 더하거나 뺀다는 의미이며, 변수 앞에 ++나 --가 붙는다면 해당 코드를 실행하기 전에 1을 더하거나 뺀다는 의미다.

## 2. 비교연산자

> `>`, `<`, `<=`, `>=`, `==`, `!=`등의 연산자가 존재한다.

```java
System.out.println(3 > 2);  // true
System.out.println(3 >= 3); // true
System.out.println(3 < 3);  // false
System.out.println(3 <= 3); // true
System.out.println(3 == 3); // true
System.out.println(3 != 3); // false
```

### 참조형 데이터 타입에서의 비교

* 기본형 데이터 타입과 참조형 데이터 타입의 비교는 다르다.

  ```java
  String str1 = new String("Hello World!");
  String str2 = new String("Hello World!");
  
  System.out.println(str1 == str2);      // false
  System.out.println(str1.equals(str2)); // true
  ```

  * str1과 str2는 각각 객체의 주소를 값으로 가지고 있기 때문에 값을 비교하는 ==는 맞지않다.
  * 객체를 비교하는 메소드는 equals()메소드이다.

* 하지만 String 타입에 한하여 객체를 생성하지 않는다면 ==도 괜찮다.

  ```java
  String str1 = "Hello World!";
  String str2 = "Hello World!";
  
  System.out.println(str1 == str2);      // true
  System.out.println(str1.equals(str2)); // true
  ```

## 3. 논리연산자

> and를 의미하는 `&&`와 or을 의미하는 `||`가 존재한다.

```java
System.out.println(3 > 3 && 4 > 3); // false
System.out.println(3 > 3 || 4 > 3); // true
```

* `&`와 `|`도 논리연산자로 사용이 가능하다. 하지만 &&와 ||의 사용을 추천하는 이유는 &와 |가 비트연산자로 사용되는 경우도 있고 두 값을 모두 비교하는 &, |와는 다르게 앞의 값만으로 값이 확정된다면 뒤의 값을 보지않고 결과를 반환하는 것이 &&와 ||기 때문이다.
  * ex) 위의 코드에서 첫번째 코드는 3>3이 false고 &&연산자가 사용되었다. 그렇다면 뒤의 값이 false인지 true인지에 관계없이 결과값이 false로 정해졌다. 그런 경우 뒤의값을 보지 않기 때문에 &&와 ||가 더 빠르다

## 4. 연산자 우선순위

> 연산자를 사용할 때 가장 중요하게 고려해야 할 부분이다.

![img](https://noritersand.github.io/images/java-operator-1.png)

* 우선순위를 신경쓰지 않는 가장 좋은 방법은 원하는 우선순위대로 괄호로 묶어주는 방법이다.

# Codes

* [Swapping](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test04.java)

* [Operator](https://github.com/TunaHG/Java_Programming/blob/master/src/Day02/Test06.java)

* [Equals](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test01.java)

* [Bit Operator](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test02.java)

