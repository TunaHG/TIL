# Lambda Expression

동작 파라미터화를 이용해서 변화하는 요구사항에 효과적으로 대응하는 코드를 구현할 수 있다. 그리고 익명 클래스를 이용하여 다양한 동작을 구현할 수 있지만 만족할만큼 코드가 깔끔하지 않다. 
람다 표현식은 익명클래스처럼 이름이 없는 함수면서 메소드를 인수로 전달할 수 있다. 또한 익명 클래스를 사용하는 것보다 더 간결하고 유연한 코드를 구현할 수 있다.

## 람다란 무엇인가?

**람다 표현식**은 <u>메소드로 전달할 수 있는 익명 함수를 단순화한 것</u>이다.
람다 표현식에는 이름은 없지만 파라미터 리스트, 바디, 반환 형식, 발생할 수 있는 예외리스트는 가질 수 있다.

**람다의 특징**

*   **익명**
    보통의 메소드와 달리 이름이 없으므로 익명이라 표현한다. 구현해야 할 코드에 대한 걱정거리가 줄어든다.
*   **함수**
    람다는 메소드처럼 특정 클래스에 종속되지 않으므로 함수라고 부른다. 하지만 메소드처럼 파라미터 리스트, 바디, 반환 형식, 가능한 예외 리스트를 포함한다.
*   **전달**
    람다 표현식을 메소드 인수로 전달하거나 변수로 저장할 수 있다.
*   **간결성**
    익명 클래스처럼 많은 자질구레한 코드를 구현할 필요가 없다.



람다가 기술적으로 자바 8 이전의 자바로 할 수 없었던 일을 제공하는 것은 아니다. 동작 파라미터 형식의 코드를 더 쉽게 구현할 수 있어서 코드가 간결하고 유연해진다.
Comparator 객체를 예로 들어본다.

```java
// 기존 코드
Comparator<Apple> byWeight = new Comparator<Apple>() {
  public int compare(Apple a1, Apple a2) {
    return a1.getWeight().compareTo(a2.getWeight());
  }
}

// 람다를 이용한 코드
Comparator<Apple> byWeight = (Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
```

>   코드가 훨씬 간단해진다.



**람다의 구성**

>   위의 람다를 이용한 코드를 예시로 설명한다.

*   **파라미터 리스트**
    Comparator의 compare 메소드 파라미터, Apple 두 개
*   **화살표**
    화살표(`->`)는 람다의 파라미터 리스트와 바디를 구분한다.
*   **람다 바디**
    두 사과의 무게를 비교한다. 람다의 반환값에 해당하는 표현식이다.



**자바에서 지원하는 람다 표현식 예제**

```java
(String s) -> s.length()
```

>   String 형식의 파라미터 하나를 가지며 int를 반환한다.
>   람다 표현식에는 return이 함축되어 있으므로 return 문을 명시적으로 사용하지 않아도 된다.

```java
(Apple a) -> a.getWeight() > 150
```

>   Apple 형식의 파라미터 하나를 가지며 boolean을 반환한다.

```java
(int x, int y) -> {
  System.out.println("Result:");
  System.out.println(x + y);
}
```

>   int 형식의 파라미터 두 개를 가지며 리턴값이 없다(void 리턴).
>   람다 표현식은 여러 행의 문장을 포함할 수 있다.

```java
() -> 42
```

>   파라미터가 없으며 int 42를 반환한다.

```java
(Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
```

>   Apple 형식의 파라미터 두 개를 가지며 int를 반환한다.



표현식 스타일로 알려진 

## 람다 사용법

어디에서 람다를 사용할 수 있을까?

### 함수형 인터페이스

동작 파라미터화를 공부하면서 살펴봤던 `Predicate<T>` 인터페이스로 filter 메소드를 파라미터화할 수 있었다. 바로 `Predicate<T>`가 함수형 인터페이스다.
`Predicate<T>`는 오직 하나의 추상 메소드만 지정하기 때문이다.

```java
public interface Predicate<T> {
  boolean test (T t);
}
```

**함수형 인터페이스**는 <u>정확히 하나의 추상 메소드를 지정하는 인터페이스</u>이다.
지금까지 살펴본 자바 API의 함수형 인터페이스로 Runnable, Comparator 등이 있다.

람다 표현식으로 함수형 인터페이스의 추상 메소드 구현을 직접 전달할 수 있으므로 **전체 표현식을 함수형 인터페이스의 인스턴스로 취급**할 수 있다.
기술적으로 들어가면, 함수형 인터페이스를 구현한 클래스의 인스턴스로 취급할 수 있는 것이다.
함수형 인터페이스보다 덜 깔끔하지만 익명 내부 클래스로도 같은 기능을 구현할 수 있다. 다음의 예시를 살펴본다.

```java
Runnable r1 = () -> System.out.println("Hello World 1");

Runnable r2 = new Runnable() {
  public void run() {
    System.out.println("Hello World 2");
  }
}

public static void process(Runnable r) {
  r.run();
}
process(r1); // Hello World 1 출력
process(r2); // Hello World 2 출력
process(() -> System.out.println("Hello World 3")); // 직접 전달된 람다 표현식으로 Hello World 3 출력
```

### 함수 디스크립터

함수형 인터페이스의 추상 메소드 시그니처는 람다 표현식의 시그니처를 가리킨다. 람다 표현식의 시그니처를 서술하는 메소드를 **함수 디스크립터**라고 부른다.
예를 들어, Runnable 인터페이스의 유일한 추상 메소드 run은 인수와 반환값이 없으므로 Runnable 인터페이스는 인수와 반환값이 없는 시그니처로 생각할 수 있다.
`() ->  void` 표기는 파라미터 리스트가 없으며 void를 반환하는 함수를 의미한다. 앞서 말한 Runnable이 이에 해당한다. 

람다 표현식은 변수에 할당하거나 함수형 인터페이스를 인수로 받는 메소드로 전달할 수 있으며 함수형 인터페이스의 추상 메소드와 같은 시그니처를 갖는다. 예를 들어, 위의 코드에서 process 메소드에 직접 람다 표현식을 전달한 예제를 살펴본다.

```java
public void process(Runnable r) {
  r.run();
}

process(() -> System.out.println("This is awesome"));
```

process 내부의 람다 표현식은 인수가 없으며 void를 반환한다. 이는 Runnable 인터페이스의 run 메소드 시그니처와 같다.

참고로 함수형 인터페이스를 가리키는 어노테이션으로 `@FunctionalInterface`가 존재한다. 추상 메소드가 한 개 이상인 경우 등 함수형 인터페이스가 아니라면 컴파일러가 에러를 발생시킨다.

## 실행 어라운드 패턴

자원 처리에 사용하는 순환 패턴(Recurrent Pattern)은 자원을 열고 처리한 다음에 자원을 닫는 순서로 이루어진다. 설정(Setup)과 정리(Cleanup) 과정은 대부분 비슷하다. 즉, <u>실제 자원을 처리하는 코드를 설정과 정리 두 과정이 둘러 싸는 형태</u>를 가진다. 이처럼 중복되는 준비 코드와 정리 코드가 작업 A와 B를 감싸고 있는 형식의 코드를 **실행 어라운드 패턴**이라고 한다.\

파일에서 한 행을 읽는 다음의 예제 코드를 활용하며 진행한다.

```java
public String processFile() throws IOException {
  try(BufferedReader br = new BufferedReader(nwe FileReader("data.txt"))) {
    return br.readLine();
  }
}
```

>   자바 7에 새로 추가된 try-with-resources 구문이다.
>   자원을 명시적으로 닫을 필요가 없으므로 간결한 코드를 구현하는데 도움을 준다.

### 1단계, 동작 파라미터화를 기억하라

예제 코드는 파일에서 한 번에 한 줄만 읽는다. 한 번에 두 줄을 읽거나 가장 자주 사용되는 단어를 반환하려면 기존의 설정, 정리과정은 재사용하고 processFile 메소드만 다른 동작을 수행하도록 명령한다. processFile의 동작을 파라미터화하는 것이다. processFile 메소드가 BufferedReader를 이용해서 다른 동작을 수행할 수 있도록 processFile 메소드로 동작을 전달해야 한다.

람다를 이용해서 동작을 전달할 수 있다.

```java
String result = processFile((BufferedReader br) -> br.readLine() + br.readLine());
```

### 2단계, 함수형 인터페이스를 이용해서 동작 전달

함수형 인터페이스 자리에 람다를 사용할 수 있다. `BufferedReader -> String`과 `IOException`을 던질 수 있는 시그니처와 일치하는 함수형 인터페이스를 만들어야 한다.

```java
@FunctionalInterface
public interface BufferedReaderProcessor {
  String process(BufferedReader b) throws IOException;
}
```

정의한 인터페이스를 processFile 메소드의 인수로 전달할 수 있다.

```java
public String processFile(BufferedReaderProcessor p) throws IOException {
  ...
}
```

### 3단계, 동작 실행

이제 BufferedReaderProcessor에 정의된 process 메소드의 시그니처 (`BufferedReader -> String`)와 일치하는 람다를 전달할 수 있다.
람다 표현식으로 함수형 인터페이스의 추상 메소드 구현을 직접 전달할 수 있으며 전달된 코드는 함수형 인터페이스의 인스턴스로 전달된 코드와 같은 방식으로 처리한다. 따라서 processFile 바디 내에서 BufferedReaderProcessor 객체의 process를 호출할 수 있다.

```java
public String processFile(BufferedReaderProcessor p) throws IOException {
  try(BufferedReader br = new BufferedReader(new FileReader("data.txt"))) {
    return p.process(br);
  }
}
```

### 4단계, 람다 전달

람다를 이용해서 다양한 동작을 processFile 메소드로 전달할 수 있다.

```java
String oneLine = processFile((BufferedReader br) -> br.readLine());
String twoLine = processFile((BufferedReader br) -> br.readLine() + br.readLine());
```

## 함수형 인터페이스, 형식 추론

함수형 인터페이스는 오직 하나의 추상 메소드를 지정한다. 함수형 인터페이스의 추상 메소드는 람다 표현식의 시그니처를 묘사한다.
함수형 인터페이스의 추상 메소드 시그니처를 함수 디스크립터라고 한다. 다양한 람다 표현식을 사용하려면 공통의 함수 디스크립터를 기술하는 함수형 인터페이스의 집합이 필요하다.

이미 자바 API는 Comparable, Runnable, Callable 등의 다양한 함수형 인터페이스를 포함하고 있으며 자바 8 라이브러리 설계자들은 java.util.function 패키지로 여러 가지 새로운 함수형 인터페이스를 제공한다.

### Predicate

`java.util.function.Predicate<T>` 인터페이스는 test라는 추상 메소드를 정의하며 test는 제네릭 형식 T의 객체를 인수로 받아 boolean을 반환한다. 동적 파라미터화를 학습하며 만들었던 인터페이스와 같은 형태인데 따로 정의할 필요 없이 바로 사용할 수 있다는 점이 특징이다. T 형식의 객체를 사용하는 boolean 표현식이 필요한 상황에서 Predicate 인터페이스를 사용할 수 있다.

Predicate 인터페이스의 JavaDoc 명세를 살펴보면 and, or 같은 메소드도 존재함을 알 수 있다.

```java
@FunctionalInterface
public interface Predicate<T> {
  boolean test(T t);
}

public <T> List<T> filter(List<T> list, Predicate<T> p) {
  List<T> results = new ArrayList<>();
  for(T t : list) {
    if(p.test(t)) {
      results.add(t);
    }
  }
  return results;
}
Predicate<String> nonEmptyStringPredicate = (String s) -> !s.isEmpty();
List<String> nonEmpty = filter(listOfStrings, nonEmptyStringPredicate);
```

### Consumer

`java.util.function.Consumer<T>` 인터페이스는 제네릭 형식 T 객체를 받아서 void를 반환하는 accept라는 추상 메소드를 정의한다. T 형식의 객체를 인수로 받아서 어떤 동작을 수행하고 싶을 때 Consumer 인터페이스를 사용한다.

```java
@FunctionalInterface
public interface Consumer<T> {
  void accept(T t);
}

public <T> void forEach(List<T> list, Consumer<T> c) {
  for(T t : list) {
    c.accept(t);
  }
}
forEach(Arrays.asList(1, 2, 3, 4, 5), (Integer i) -> System.out.println(i));
```

### Function

`java.util.function.Function<T, R>` 인터페이스는 제네릭 형식 T를 인수로 받아서 제네릭 형식 R 객체를 반환하는 추상 메소드 apply를 정의한다. 입력을 출력으로 매핑하는 람다를 정의할 때 Function 인터페이스를 활용할 수 있다. 

```java
@FunctionalInterface
public interface Function<T, R> {
  R apply(T t);
}

public <T, R> List<R> map(List<T> list, Function<T, R> f) {
  List<R> result = new ArrayList<>();
  for(T t: list) {
    result.add(f.apply(t));
  }
  return result;
}

List<Integer> l = map(Arrays.asList("lambdas", "in", "action"), (String s) -> s.length());
```

### ETC

자바의 모든 형식은 참조형(Byte, Integer, Object, List) 아니면 기본형(int, double, byte, char)에 해당한다. 하지만 제네릭 파라미터에는 참조형만 사용할 수 있다. 

자바에서는 <u>기본형을 참조형으로 변환</u>하는 **박싱** 기능과 <u>참조형을 기본형으로 변환</u>하는 **언박싱** 기능을 제공한다. 또한 프로그래머가 편리하게 코드를 구현할 수 있도록 <u>박싱과 언박싱이 자동으로 이루어지는</u> **오토박싱**이라는 기능도 제공한다.

```java
List<Integer> list = new ArrayList<>();
for(int i = 300; i < 400; i++) {
  list.add(i);
}
```

>   int가 Integer로 박싱되는 경우

이러한 변환과정은 비용이 소모된다. 박싱한 값은 기본형을 감싸는 래퍼며 힙에 저장된다. 박싱한 값은 메모리를 더 소비하여 기본형으로 가져올 때도 메모리를 탐색하는 과정이 필요하다. 자바 8에서는 기본형을 입출력으로 사용하는 상황에서 오토박싱 동작을 피할 수 있도록 특별한 버전의 함수형 인터페이스를 제공한다.
예를 들어 `IntPredicate`는 1000이라는 값을 박싱하지 않지만, `Predicate<Integer>`는 1000이라는 값을 Integer 객체로 박싱한다. 일반적으로 특정 형식을 입력으로 받는 함수형 인터페이스의 이름 앞에는 DoublePredicate, IntConsumer, LongBinaryOperator, IntFunction 처럼 형식명이 붙는다. Function 인터페이스는 `ToIntFunction<T>`, `IntToDoubleFunction`등의 다양한 출력 형식 파라미터를 제공한다.



함수형 인터페이스는 확인된 예외를 던지는 동작을 허용하지 않는다. 즉, 예외를 던지는 람다 표현식을 만들려면 확인된 예외를 선언하는 함수형 인터페이스를 직접 정의하거나 람다를 try/catch 블록으로 감싸야 한다.

```java
// 함수형 인터페이스를 직접 정의하는 방법
@FunctionalInterface
public interface BufferedReaderProcessor {
  String process(BufferedReader b) throws IOException;
}
BufferedReaderProcessor p = (BufferedReader br) -> br.readLine();

// 람다를 try/catch 블록으로 감싸는 방법
Function<BufferedReader, String> f = (BufferedReader b) -> {
  try{
    return b.readLine();
  }
  catch(IOException e) {
    throw new RuntimeException(e);
  }
}
```

## 형식 검사, 형식 추론, 제약

람다로 함수형 인터페이스의 인스턴스를 만들 수 있다. 하지만 람다 표현식 자체에는 람다가 어떤 함수형 인터페이스를 구현하는지의 정보가 포함되어 있지 않으니 람다 표현식을 제대로 이해하려면 람다의 실제 형식을 파악해야 한다.

### 형식 검사

람다가 사용되는 Context를 이용해서 람다의 Type을 추론할 수 있다. 어떤 Context(람다가 전달될 메소드 파라미터나 람다가 할당되는 변수 등)에서 기대되는 람다 표현식의 형식을 대상 형식이라고 부른다.

다음의 람다 표현식을 사용할 때 어떤 일이 발생하는지 예제를 활용하여 파악해본다. 람다표현식이 예외를 던질 수 있다면 추상 메소드도 같은 예외를 던질 수 있도록 throws로 선언해줘야 한다.

```java
List<Apple> heavierThan150g = filter(inventory, (Apple apple) -> apple.getWeight() > 150);
```

이 코드는 다음과 같은 순서로 형식 확인 과정이 진행된다.

1.  **filter 메소드의 선언을 확인한다.**
    람다가 사용된 컨텍스트의 정의를 확인한다.
2.  **filter 메소드는 두 번째 파라미터로 `Predicate<Apple>` 형식(대상 형식)을 기대한다.**
    T가 Apple로 대체된 것을 확인할 수 있는 대상 형식을 확인한다.
3.  **`Predicate<Apple>`은 test라는 한 개의 추상 메소드를 정의하는 함수형 인터페이스다.**
    대상 형식의 추상 메소드가 무엇인지 확인한다.
4.  **test 메소드는 Apple을 받아 boolean을 반환하는 함수 디스크럽터를 묘사한다.**
    Apple을 인수로 받아 boolean을 반환하는 test 메소드라는 함수 디스크럽터를 확인한다.
5.  **filter 메소드로 전달된 인수는 이와 같은 요구사항을 만족해야 한다.**
    함수 디스크럽터가 `Apple -> boolean`이므로 람다의 시그니처와 일치하는 것을 확인한다. 람다도 Apple을 인수로 받아 boolean을 반환하므로 코드 형식 검사가 성공적으로 완료된다.

### 같은 람다, 다른 함수형 인터페이스

대상 형식이라는 특징때문에 같은 람다 표현식이더라도 호환되는 추상 메소드를 가진 다른 함수형 인터페이스로 사용될 수 있다.
예를 들어, Callable과 PrivilegedAction 인터페이스는 인수를 받지 않고 제네릭 형식 T를 반환하는 함수를 정의한다.

```java
Callable<Integer> c = () -> 42;
PrivilegedAction<Integer> p = () -> 42;
```

>   두 할당문 모두 유효한 코드다.

하나의 람다 표현식으로 다양한 함수형 인터페이스에 사용할 수 있다.

```java
Comparator<Apple> c1 = (Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
ToIntBiFunction<Apple, Apple> c2 = (Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
BiFunction<Apple, Apple, Integer> c3 = (Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
```



**다이아몬드 연산자**
주어진 클래스 인스턴스 표현식을 두 개 이상의 다양한 Context에 사용할 수 있다. 이 때 인스턴스 표현식의 형식 인수는 Context에 의해 추론된다.

```java
List<String> listOfStrings = new ArrayList<>();
List<Integer> listOfIntegers = new ArrayList<>();
```

**특별한 void 호환 규칙**
람다의 바디에 일반 표현식이 있으면 void를 반환하는 함수 디스크립터와 호환된다.

```java
Predicate<String> p = s -> list.add(s);
Consumer<String> b = s -> list.add(s);
```

### 형식 추론

자바 컴파일러는 람다 표현식이 사용된 대상 형식을 이용해서 람다 표현식과 관련된 함수형 인터페이스를 추론한다. 즉 대상 형식을 이용해서 함수 디스크립터를 알 수 있으므로 컴파일러는 람다의 시그니처도 추론할 수 있다. 결과적으로 컴파일러는 람다 표현식의 파라미터 형식에 접근할 수 있으므로 람다 문법에서 이를 생략할 수 있다. 즉, 자바 컴파일러는 다음처럼 람다 파라미터 형식을 추론할 수 있다.

```java
List<Apple> greenApples = filter(inventory, apple -> GREEN.equals(apple.getColor()));
```

여러 파라미터를 포함하는 람다 표현식에서는 코드 가독성 향상이 두드러진다.

```java
Comparator<Apple> c = (Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight());
Comparator<Apple> c = (a1, a2) -> a1.getWeight().compareTo(a2.getWeight());
```

상황에 따라 명시적으로 형식을 포함하는 것이 좋을 때도 있고 형식을 배제하는 것이 가독성을 향상시킬 때도 있다.

### 지역 변수 사용

람다 표현식에서 익명 함수가 하는 것처럼 자유 변수(파라미터로 넘겨진 변수가 아닌 외부에서 정의된 변수)를 활용할 수 있다.
이러한 동작을 람다 캡쳐링이라고 부른다.

```java
int portNumber = 1337;
Runnable r = () -> System.out.println(portNumber);
```

자유 변수에도 약간의 제약이 있다. 람다는 인스턴스 변수와 정적 변수를 자율롭게 캡처할 수 있다. 하지만 그러려면 지역 변수는 명시적으로 final로 선언되어 있어야 하거나 실질적으로 final로 선언되 변수와 똑같이 사용되어야 한다. 즉, 람다 표현식은 한 번만 할당할 수 있는 지역 변수를 캡처할 수 있다.

**지역변수의 제약**
내부적으로 인스턴스 변수와 지역 변수는 태생부터 다르다. 인스턴스 변수는 힙에 저장되는 반면 지역 변수는 스택에 위치한다. 람다에서 지역 변수에 바로 접근할 수 있다는 가정하에 람다가 스레드에서 실행된다면 변수를 할당한 스레드가 사라져서 변수 할당이 해제되었는데도 람다를 실행하는 스레드에서는 해당 변수에 접근하려 할 수 있다. 따라서 자바 구현에서는 원래 변수에 접근을 허용하는 것이 아니라 자유 지역 변수의 복사본을 제공한다.

**클로저**
원칙적으로 클로저란, 함수의 비지역 변수를 자유롭게 참조할 수 있는 함수의 인스턴스를 가리킨다. 자바 8의 람다와 익명 클래스는 클로저와 비슷한 동작을 수행한다. 람다와 익명 클래스 모두 메소드의 인수로 전달될 수 있으며 자신의 외부 영역의 변수에 접근할 수 있다. 다만 정의된 메소드의 지역 변수 값은 바꿀 수 없다. 람다가 정의된 메소드의 지역 변수값은 final 변수여야 한다. 덕분에 람다는 변수가 아닌 값에 국한되어 어떤 동작을 수행한다는 사실이 명확해진다.

## 메소드 참조

메소드 참조를 이용하면 기존의 메소드 정의를 재활용해서 람다처럼 전달할 수 있다. 때로는 람다 표현식보다 메소드 참조를 사용하는 것이 더 가독성이 좋으며 자연스러울 수 있다. 다음은 메소드 참조와 `java.util.Comparator.comparing`을 활용한 예제 코드다.

```java
// 기존의 코드
inventory.sort((Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight()));

// 메소드 참조를 활용한 코드
inventory.sort(comparing(Apple::getWeight));
```

### 요약

메소드 참조는 특정 메소드만을 호출하는 람다의 축약형이라고 생각할 수 있다. 메소드 참조를 이용하면 기존 메소드 구현으로 람다 표현식을 만들 수 있다. 이 때 명시적으로 메소드명을 참조함으로써 가독성을 높일 수 있다.

메소드 참조는 메소드 명 앞에 구분자(`::`)를 붙이는 방식으로 활용할 수 있다. `Apple::getWeight`는 Apple 클래스에 정의된 getWeight 메소드 참조이다. 실제로 메소드를 호출하는 것은 아니므로 괄호는 필요 없다. 결과적으로 메소드 참조는 람다 표현식 `(Apple a) -> a.getWeight()`를 축약한 것이다

메소드 참조를 새로운 기능이 아니라 하나의 메소드를 참조하는, 람다를 편리하게 표현할 수 있는 문법으로 간주할 수 있다. 메소드 참조를 이용하면 같은 기능을 더 간결하게 구현할 수 있다.

**메소드 참조를 만드는 방법**
메소드 참조는 세 가지 유형으로 구분할 수 있다.

1.  **정적 메소드 참조**
    Integer의 parseInt 메소드는 Integer::parseInt로 표현할 수 있다.
    
2.  **다양한 형식의 인스턴스 메소드 참조**
    String의 length 메소드는 String::length로 표현할 수 있다.
    `(String s) -> s.toUpperCase()`라는 람다 표현식을 String::toUpperCase로 표현할 수 있다.
    
3.  **기존 객체의 인스턴스 메소드 참조**
    Transaction 객체를 할당받은 expensiveTransaction 지역 변수가 있고, Transaction 객체에는 getValue 메소드가 있다면, 이를 expensiveTransaction::getValue라고 표현할 수 있다. `() -> expensiveTransaction.getValue()`를 `expensiveTransaction::getValue`로 줄여서 표현할 수 있다는 의미다.

    이 유형의 메소드 참조는 비공개 헬퍼 메소드를 정의한 상황에서 유용하게 활용할 수 있다.

    ```java
    private boolean isValidName(String string) {
      return Character.isUpperCase(string.charAt(0));
    }
    
    filter(words, this::isValidName);
    ```

예제를 통해 파악해 본다. List에 포함된 문자열을 대소문자를 구분하지 않고 정렬하는 프로그램을 구현한다. List의 sort 메소드는 인수로 Comparator를 기대하고 Comparator는 `(T, T) -> int`라는 함수 디스크립터를 가진다.

```java
List<String> str = Arrays.asList("a", "b", "A", "B");
// 람다 표현식
str.sort((s1, s2) -> s1.compareToIgnoreCase(s2));

// 메소드 참조
str.sort(String::compareToIgnoreCase);
```

컴파일러는 람다 표현식의 형식을 검사하던 방식과 비슷한 과정으로 메소드 참조가 주어진 함수형 인터페이스와 호환하는지 확인한다. 즉, 메소드 참조는 Context의 형식과 일치해야 한다.

### 생성자 참조

`ClassName::new`처럼 클래스명과 new 키워드를 이용해서 기존 생성자의 참조를 만들 수 있다. 이는 정적 메소드의 참조를 만드는 방법과 비슷하다.

인수가 없는 생성자 즉, Supplierdml `() -> Apple` 과 같은 시그니처를 갖는 생성자가 있다고 가정한다.

```java
Supplier<Apple> c1 = () -> new Apple();

Supplier<Apple> c1 = Apple::new;
Apple a1 = c1.get();
```

>   1번째 줄과 3번째 줄은 동일한 동작을 하는 코드이다.
>
>   Supplier의 get 메소드를 호출하여 새로운 Apple 객체를 만들 수 있다.
>   람다 표현식은 디폴트 생성자를 가진 Apple을 만든다.

`Apple(Integer weight)`라는 시그니처를 가지는 생성자는 Function 인터페이스의 시그니처와 같으므로 다음과 같이 구현할 수 있다.

```java
Function<Integer, Apple> c2 = (weight) -> new Apple(weight);

Function<Integer, Apple> c2 = Apple::new;
Apple a2 = c2.apply(110);
```

>   1번째 줄과 3번째 줄은 동일한 동작을 하는 코드이다.
>
>   Function의 apply 메소드에 무게를 인수로 호출해서 새로운 Apple 객체를 만들 수 있다.

`Apple(String color, Integer weight)` 처럼 두 인수를 가지는 생성자는 BiFunction 인터페이스와 같은 시그니처를 가지므로 다음과 같이 구현할 수 있다.

```java
BiFunction<String, Intger, Apple> c3 = (color, weight) -> new Apple(color, weight);

BiFunction<Color, Integer, Apple> c3 = Apple::new;
Apple a3 = c3.apply(GREEN, 110);
```

>   역시 1번째 줄과 3번째 줄은 동일한 동작을 하는 코드이다.
>
>   BiFunction의 apply메소드에 색과 무게를 인수로 제공해서 새로운 Apple 객체를 만들 수 있다.

## 람다, 메소드 참조 활용하기 (정리)

처음에 다룬 사과 리스트를 다양한 정렬 기법으로 정렬하는 문제를 더 세련되고 간결하게 해결해본다.

### 1단계, 코드 전달

자바 8의 List API에서  sort 메소드를 제공하므로 정렬 메소드를 직접 구현할 필요는 없다. sort 메소드는 다음과 같은 시그니처를 가진다.
`void sort(Comparator<? super E> c)`
이는 Comparator 객체를 인수로 받아 두 사과를 비교한다. 객체 안에 동작을 포함시키는 방식으로 다양한 전략을 전달할 수 있다. 이제 **sort의 동작은 파라미터화되었다**고 말할 수 있다. 즉, sort에 전달된 정렬 전략에 따라 sort의 동작이 달라질 것이다.

1단계의 코드는 다음과 같다.

```java
public class AppleComparator implements Comparator<Apple> {
  public int compare(Apple a1, Apple a2) {
    return a1.getWeight().compareTo(a2.getWeight());
  }
}
inventory.sort(new AppleComparator());
```

### 2단계, 익명 클래스 사용

한 번만 사용할 Comparator를 1단계 코드처럼 구현하는 것보다는 익명 클래스를 이용하는 것이 좋다.

```java
inventory.sort(new Comparator<Apple>() {
  public int compare(Apple a1, Apple a2) {
    return a1.getWeight().compareTo(a2.getWeight());
  }
})
```

### 3단계, 람다 표현식 사용

자바 8에서는 람다 표현식이라는 경량화된 문법을 이용해서 코드를 전달할 수 있다. 함수형 인터페이스를 기대하는 곳 어디에서나 람다 표현식을 사용할 수 있다.
함수형 인터페이스란 오직 하나의 추상 메소드를 정의하는 인터페이스이며 추상 메소드의 시그니처(함수 디스크립터)는 람다 표현식의 시그니처를 정의한다.
Comparator의 함수 디스크립터는 `(T, T) -> int`다. 여기서는 사과를 이용할 것이므로 `(Apple, Apple) -> int`로 표현할 수 있다. 코드를 개선하면 다음과 같다.

```java
inventory.sort((Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight()));
```

자바 컴파일러는 람다 표현식이 사용된 Context를 활용해서 람다의 파라미터 형식을 추론한다. 따라서 코드를 다음과 같이 더 줄일 수 있다.

```java
inventory.sort((a1, a2) -> a1.getWeight().compareTo(a2.getWeight()));
```

Comparator는 Comparable키를 추출해서 Comparator객체로 만드는 Function함수를 인수로 받는 정적 메소드 comparing을 포함한다. 이를 활용하여 코드의 가독성을 향상시킨다.

```java
Comparator<Apple> c = Comparator.comparing((Apple a) -> a.getWeight());
```

3단계의 코드는 다음과 같다.

```java
import static java.util.Comparator.comparing;
inventory.sort(comparing(apple -> apple.getWeight()));
```

### 4단계, 메소드 참조 사용

메소드 참조를 이용하면 람다 표현식의 인수를 더 깔끔하고 간결하게 전달할 수 있다.

```java
inventory.sort(comparing(Apple::getWeight));
```

## 람다 표현식을 조합할 수 있는 유용한 메소드

자바 8 API의 몇몇 함수형 인터페이스는 다양한 유틸리티 메소드를 포함한다. Comparator, Function, Predicate 같은 함수형 인터페이스는 람다 표현식을 조합할 수 있도록 유틸리티 메소드를 제공한다. 이를 활용해 간단한 여러 개의 람다 표현식을 조합해 복잡한 람다 표현식을 만들 수 있다.
이는 함수형 인터페이스에서 디폴트 메소드를 제공하기에 가능한 일이다.

### Comparator 조합

정적 메소드 Comparator.comparing을 이용해서 비교에 사용할 키를 추출하는 Function기반의 Comparator를 반환할 수 있다.

```java
Comparator<Apple> c = Comparator.comparing(Apple::getWeight);
```

#### 역정렬

사과의 무게를 내림차순으로 정렬하고 싶을 경우 다른 Comparator 인스턴스를 만들 필요 없이 인터페이스 자체에서 제공하는 주어진 비교자의 순서를 뒤바꾸는 reverse라는 디폴트 메소드를 사용한다. 따라서 다음 코드처럼 처음 비교자 구현을 그대로 재사용해서 역정렬할 수 있다.

```java
inventory.sort(comparing(Apple::getWeight).reversed());
```

#### Comparator 연결

무게가 같은 두 사과가 존재하는 경우 어떤 사과를 먼저 나열해야 하는지 비교결과를 더 다듬을 수 있다.
thenComparing 메소드로 두 번째 비교자를 만들 수 있다. 이는 comparing 메소드처럼 함수를 인수로 받아 첫 번째 비교자를 이용해서 두 객체가 같다고 판단되면 두 번째 비교자에 객체를 전달한다.

```java
inventory.sort(comparing(Apple::getWeight)
              .reversed()
              .thenComparing(Apple::getCountry));
```

>   두 사과의 무게가 같으면 국가별로 정렬한다.

### Predicate 조합

Predicate 인터페이스는 복잡한 프레디케이트를 만들 수 있도록 negate, and, or 세 가지 메소드를 제공한다.

특정 프레디케이트를 반전시킬 때 negate 메소드를 사용할 수 있다.

```java
Predicate<Apple> notRedApple = redApple.negate();
```

그리고 and 메소드를 이용해서 두 람다를 조합할 수 있다.

```java
Predicate<Apple> redAndHeavyApple = redApple.and(apple -> apple.getWeight() > 150);
```

또한 or을 이용해서 다양한 조건을 만들 수 있다.

```java
Predicate<Apple> redAndHeavyAppleOrGreen = 
  redApple.and(apple -> apple.getWeight() > 150)
  				.or(apple -> GREEN.equals(a.getColor()));
```

이는 단순한 람다표현식을 조합해서 더 복잡한 람다 표현식을 만들 수 있으며 람다 표현식을 조합해도 코드 자체가 문제를 잘 설명한다는 점에서 대단하다.

### Function 조합

Function 인터페이스는 Function 인터페이스를 반환하는 andThen, compose 두 개의 디폴트 메소드를 제공한다.

andThen 메소드는 주어진 함수를 먼저 적용한 결과를 다른 함수의 입력으로 전달하는 함수를 반환한다.

```java
Function<Integer, Integer> f = x -> x + 1;
Function<Integer, Integer> g = x -> x * 2;
Function<Integer, Integer> h = f.andThen(g); // g(f(x))
int result = h.apply(1); // 4
```

>   숫자를 1 증가시키는 f 함수와 숫자를 2를 곱하는 g 함수
>   f와 g를 조립해서 숫자를 1 증가시킨 후 2를 곱하는 h라는 함수

Compose 메소드는 인수로 주어진 함수를 먼저 실행한 다음에 그 결과를 외부 함수의 인수로 제공한다.

```java
Function<Integer, Integer> f = x -> x + 1;
Function<Integer, Integer> g = x -> x * 2;
Function<Integer, Integer> h = f.compose(g); // f(g(x))
int result = h.apply(1); // 3
```

## 정리

**람다 표현식**은 익명 함수의 일종이다. 이름은 없지만 파라미터 리스트, 바디, 반환 형식을 가지며 예외를 던질 수 있다.

람다 표현식으로 간결한 코드를 구현할 수 있다.

**함수형 인터페이스**는 하나의 추상 메소드만을 정의하는 인터페이스다.

함수형 인터페이스를 기대하는 곳에서만 람다 표현식을 사용할 수 있다.

람다 표현식을 이용해서 함수형 인터페이스의 추상 메소드를 즉석으로 제공할 수 있으며 **람다 표현식 전체가 함수형 인터페이스의 인스턴스로 취급된다.**

java.util.function 패키지는 `Predicate<T>`, `Function<T, R>`, `Supplier<T>`, `Consumer<T>`, `BinaryOperator<T>`등을 포함해서 자주 사용하는 다양한 함수형 인터페이스를 제공한다.

자바 8은 `Predicate<T>`와 `Function<T, R>` 같은 제네릭 함수형 인터페이스와 관련된 박싱 동작을 피할 수 있는 IntPredicate, IntToLongFunction 등과 같은 기본형 특화 인터페이스도 제공한다.

실행 어라운드 패턴을 람다와 활용하면 유연성과 재사용성을 추가로 얻을 수 있다.

람다 표현식의 기대 형식을 대상 형식이라 한다.

메소드 참조를 이용하면 기존의 메소드 구현을 재사용하고 직접 전달할 수 있다.

Comparator, Predicate, Function 같은 함수형 인터페이스는 람다 표현식을 조합할 수 있는 다양한 디폴트 메소드를 제공한다.

# Footnote

*   **출처**
    **모던 자바 인 액션**