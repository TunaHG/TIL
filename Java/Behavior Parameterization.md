# Behavior parameterization

>   동적 파라미터화

**동적 파라미터화**란, <u>아직은 어떻게 실행할 것인지 결정하지 않은 코드블록을 의미</u>한다.
이를 이용하면 자주 바뀌는 요구사항에 효과적으로 대응할 수 있다.

## 변화하는 요구사항에 대응하기

하나의 예제를 선정하고 그 예제를 점차 개선하면서 유연한 코드를 만드는 모범사례를 보여준다.

기존의 농장 재고목록 애플리케이션에 리스트에서 "녹색" 사과만 필터링하는 기능을 추가한다고 가정한다.

### 첫 번째 시도, 녹색 사과 필터링

사과 색을 정의하는 다음과 같은 Color enum이 존재한다고 가정한다.

```java
enum Color { RED, GREEN }
```

다음은 첫 번째 시도 결과 코드다.

```java
public static List<Apple> filterGreenApples(List<Apple> inventory) {
  List<Apple> result = new ArrayList<>();
  for (Apple apple : inventory) {
    if(GREEN.equals(apple.getColor())) { // 녹색 사과를 선택하는데 필요한 조건
      result.add(apple);
    }
  }
  return result;
}
```

하지만 여기서 녹색이 아닌 빨간색 사과도 필터링하고 싶어졌다면 filterRedApples라는 새로운 메소드를 만들고 if문의 조건을 변경할 수 있다.
이렇게 진행하면 빨간색 사과는 필터링 할 수 있겠지만 이후 더 다양한 색으로 필터링하는 등의 변화에는 적절하게 대응할 수 없다.

끊임없이 변화하는 요구사항에 맞추기 위하여 우리는 다음의 규칙을 따라야 한다.
**거의 비슷한 코드가 반복 존재한다면 그 코드를 추상화한다.**
이는 소프트웨어 공학의 DRY(Don't Repeat Yourself) 원칙을 지키는 것이기도 하다.

### 두 번째 시도, 색을 파라미터화

filterGreenApples의 코드를 반복하지 않고 filterRedApples를 구현하려면 색을 파라미터화할 수 있도록 메소드에 파라미터를 추가하면 변화하는 요구사항에 좀 더 유연한 코드를 만들 수 있다.

```java
public static List<Apple> filterApplesByColor(List<Apple> inventory, Color color) {
  List<Apple> result = new ArrayList<>();
  for (Apple apple : inventory) {
    if(apple.getColor().equals(color)) {
      result.add(apple);
    }
  }
  return result;
}
```

변화하는 색에 적절하게 대응하여 유연한 코드가 되었다.
하지만 색 이외에도 무게로 구분하려 한다면 filterApplesByColor를 복사하여 filterApplesByWeight라는 메소드를 Color 대신 Weight를 사용하여 생성하여야 한다.
결국 Color와 Weight로 필터링 하는 부분을 제외한 나머지 코드가 중복된다. 

### 세 번째 시도, 가능한 모든 속성으로 필터링

Color와 Weight를 메소드로 합치는 방법도 있다. 그러면 어떤 기준으로 사과를 필터링할지 구분하는 다른 방법이 필요하다. 색이나 무게 중 어떤 것을 기준으로 필터링할지 가리키는 플래그를 추가할 수 있다.

```java
public static List<Apple> filterApplesByColor(List<Apple> inventory, Color color, int weight, boolean flag) {
  List<Apple> result = new ArrayList<>();
  for (Apple apple : inventory) {
    if((flag && apple.getColor().equals(color)) || (!flag && apple.getWeight() > weight)) {
      result.add(apple);
    }
  }
  return result;
}
```

위처럼 진행하면 flag 인자에 들어갈 true, false가 무엇을 의미하는지 코드만 보고 직관적으로 파악할 수 없으며 요구사항이 바뀌었을 때 유연하게 대응할 수도 없다.
결국 여러 중복된 필터 메소드를 만들거나 아니면 모든 것을 처리하는 거대한 하나의 필터 메소드를 구현해야 한다.

지금까지 진행했던 문자열, 정수, 불리언 등의 값으로 filter 메소드를 파라미터화하는 방법이 아닌, 동적 파라미터화를 이용해서 유연성을 얻는 방법을 학습한다.

## 동적 파라미터화

<u>참 또는 거짓을 반환하는 함수</u>를 **프레디케이트**라고 한다. 
이러한 프레디케이트를 고려하여 선택 조건을 결정하는 인터페이스를 정의한다.

```java
public interface ApplePredicate {
  boolean test(Apple apple);
}

public class AppleHeavyWeightPredicate implements ApplePredicate {
  public boolean test(Apple apple) {
    return apple.getWeight() > 150;
  }
}

public class AppleGreenColorPredicate implements ApplePredicate {
  public boolean test(Apple apple) {
    return GREEN.equals(apple.getColor());
  }
}
```

조건에 따라 filter 메소드가 다르게 동작할 것이라고 예상할 수 있다. 이를 **전략 디자인 패턴**이라고 한다.
전략 디자인 패턴은 <u>각 알고리즘(전략)을 캡슐화하는 알고리즘 패밀리를 정의해둔 다음에 런타임에 알고리즘을 선택하는 기법</u>이다.
프레디케이트 인터페이스가 알고리즘 패밀리에 해당하며 선택 조건을 의미하는 하위 클래스가 전략에 해당한다.
Filter 메소드에서 프레디케이트 인터페이스 객체를 받아 조건을 검사하도록 메소드를 수정해야 한다. 이렇게 동작 파라미터화 즉, 메소드가 다양한 동작(전략)을 받아서 내부적으로 다양한 동작을 수행할 수 있다. 이렇게 filter 메소드가 프레디케이트 객체를 인수로 받도록 수정하면 filter 메소드 내부에서 컬렉션을 반복하는 로직과 컬렉션의 각 요소에 적용할 동작을 분리할 수 있다는 점에서 소프트웨어 엔지니어링적으로 큰 이득을 얻는다.

### 네 번째 시도, 추상적 조건으로 필터링

```java
public static List<Apple> filterApples(List<Apple> inventory, ApplePredicate p) {
  List<Apple> result = new ArrayList<>();
  for(Apple apple: inventory) {
    if(p.test(apple)) {
      result.add(apple);
    }
  }
  return result;
}
```

이러한 구현에서 중요한 것은 선택 조건을 의미하는 test 메소드다. Filter 메소드의 새로운 동작을 정의하는 것이 test 메소드인데, 메소드는 객체만 인수로 받으므로 test 메소드를 프레디케이트 객체로 감싸서 전달해야 한다.
Test 메소드를 구현하는 객체를 이용해서 불리언 표현식을 전달할 수 있으므로 이는 코드를 전달할 수 있는 것이나 다름 없다. 람다와 함께 사용하면 여러 개의 프레디케이트 클래스를 정의하지 않고도 조건에 해당하는 표현식을 filter 메소드로 전달하는 방법이 있다.

**한 개의 파라미터, 다양한 동작**
컬렉션 탐색 로직과 각 항목에 적용할 동작을 분리할 수 있다는 것이 동작 파라미터화의 강점이다.

## 복잡한 과정 간소화

하지만 위처럼 동적 파라미터화를 적용하면 프레디케이트 인터페이스를 구현하는 여러 클래스를 정의한 다음 인스턴스화해야 한다.
이를 개선하기 위해 자바는 클래스의 선언과 인스턴스화를 동시에 수행할 수 있도록 **익명 클래스**라는 기법을 제공한다.

익명 클래스는 자바의 지역 클래스(블록 내부에 선언된 클래스)와 비슷한 개념이다. 이를 이용하면 즉석에서 필요한 구현을 만들어서 사용할 수 있다.

익명 클래스를 이용하면 코드는 filter 메소드의 두 번째 인자로 주어지던 프레디케이트 클래스를 다른 곳에서 생성하지 않고 그 자리에 바로 생성하며 진행한다.

```java
List<Apple> redApples = filter(inventory, new ApplePredicate() {
  public boolean test(Apple apple) {
    return RED.equals(apple.getColor());
  }
})
```

>   익명 클래스는 GUI 애플리케이션에서 이벤트 핸들러 객체를 구현할 때 종종 사용한다.

하지만 익명 클래스로도 아직 부족한 점이 많다. 익명 클래스에서 return을 제외한 다른 부분들이 모두 반복될 예정이기 때문이다.
코드는 한눈에 이해할 수 있어야 좋은 코드인데 이렇게 코드가 반복되면 코드가 장황해져서 구현하고 유지보수하기 어렵고 동료 개발자들로부터 외면받을 수 있다.

동작 파라미터화에 **람다 표현식**을 이용하면 더 간단하게 코드를 정리할 수 있다. 람다 표현식을 이용한 코드는 다음과 같다.

```java
List<Apple> redApples = filter(inventory, (Apple apple) -> RED.equals(apple.getColor()));
```

한 단계 더 나아가서 **제네릭 타입**을 활용한다.
filter 메소드를 선언할 때 인수로 받는 프레디케이트에 `<T>`를 사용하여 제네릭 타입을 붙여주면 기존에 진행한 T 클래스 말고도 정수, 문자열 등의 리스트에 필터 메소드를 사용할 수 있다.

```java
public interface Predicate<T> {
  boolean test(T t);
}

public static <T> List<T> filter(List<T> list, Predicate<T> p) {
  List<T> result = new ArrayList<>();
  for(T e : list) {
    if(p.test(e)) {
      result.add(e);
    }
  }
  return result;
}
```

>   여기서 return 타입 앞에 붙는 `<T>`는 Method Generic Type으로 관련 내용은 [여기](#Footnote)를 참고한다.

## 실전 예제

### Comparator로 정렬하기

자바 8의 List에는 sort 메소드가 포함되어 있다. (Collections.sort도 존재한다.) 다음과 같은 인터페이스를 가지는 java.util.Comparator 객체를 이용해서 sort의 동작을 파라미터화 할 수 있다.

```java
public interface Comparator<T> {
  int campare(T o1, T o2);
}
```

Comparator를 구현해서 sort 메소드의 동작을 다양화할 수 있다. 예를 들어, 익명 클래스를 이용하여 무게가 적은 순서로 목록에서 사과를 정렬한다.

```java
inventory.sort(new Comparator<Apple>() {
  public int compare(Apple a1, Apple a2) {
    return a1.getWeight().compareTo(a2.getWeight());
  }
})
```

농부의 요구사항이 바뀌면 새로운 요구사항에 맞는 Comparator를 만들어 sort 메소드에 전달할 수 있다. 실제 정렬 세부사항은 추상화되어 있으므로 신경쓸 필요가 없다.

람다 표현식을 사용하면 다음처럼 간단하게 코드를 구현할 수 있다.

```java
inventory.sort((Apple a1, Apple a2) -> a1.getWeight().compareTo(a2.getWeight()));
```

### Runnable로 코드 블록 실행하기

자바 스레드를 이용하면 병렬로 코드 블록을 실행할 수 있다. 여러 스레드가 각자 다른 코드를 실행할 수 있으므로 나중에 실행할 수 있는 코드를 구현할 방법이 필요하다.
자바 8까지는 Thread 생성자에 객체만 전달할 수 있었으므로 보통 결과를 반환하지 않는 void run 메소드를 포함하는 익명 클래스가 Runnable 인터페이스를 구현하도록 하는 것이 일반적인 방법이였다.

Runnable 인터페이스를 이용해서 실행할 코드 블록을 지정할 수 있다. 또한 다양한 동작을 스레드로 실행할 수 있다.

```java
Thread t = new Thread(new Runnable() {
  public void run() {
    System.out.println("Hello World");
  }
})
```

Java 8부터 지원하는 람다 표현식을 이용하면 다음처럼 스레드 코드를 구현할 수 있다.

```java
Thread t = new Thread(() -> System.out.println("Hello World"));
```

### Callable을 결과로 반환하기

자바 5부터 지원하는 ExecutorService 인터페이스는 태스크 제출과 실행 과정의 연관성을 끊어준다. 태스크를 스레드 풀로 보내고 결과를 Future로 저장할 수 있다는 점이 Thread와 Runnable을 이용하는 방식과 다르다. 이 방식은 Runnable의 업그레이드 버전이라고 생각할 수 있다.

```java
ExecutorService executorService = Executors.newCachedThreadPool();
Future<String> threadName = executorService.submit(nwe Callable<String>() {
  @Override
  public String call() throws Exception {
    return Thread.currentThread().getName();
  }
})
```

람다를 이용하면 다음처럼 코드를 줄일 수 있다.

```java
Future<String> threadName = executorService.submit(() -> Thread.currentThread().getName());
```

### GUI 이벤트 처리하기

일반적으로 GUI 프로그래밍은 마우스 클릭이나 문자열 위로 이동하는 등의 이벤트에 대응하는 동작을 수행하는 식으로 동작한다.
모든 동작에 반응할 수 있어야 하기 때문에 변화에 대응할 수 있는 유연한 코드가 필요하다.
자바FX에서는 setOnAction 메소드에 EventHandler를 전달함으로써 어떻게 이벤트에 반응할지 설정할 수 있다.

```java
Button button = new Button("Send");
button.setOnAction(new EventHandler<ActionEvent>() {
  public void handle(ActionEvent event) {
    label.setText("Sent!!!");
  }
})
```

즉, EventHandler는 setOnAction 메소드의 동작을 파라미터화한다. 람다 표현식을 이용하여 다음처럼 구현할 수 있다.

```java
button.setOnAction((ActionEvent event) -> label.setText("Sent!!"));
```

# Footnote

*   **출처**
    **모던 자바 인 액션**

*   **Method Generic Type**

    ```java
    public static <T> List<T> filter(List<T> list, Predicate<T> p) {
      ...
    }
    ```

    *   Class에 Generic Type을 선언하지 않고, 각 메소드마다 Generic Type을 선언해 사용한다.
    *   메소드의 파라미터에 `<T>`가 선언되어 있다면, 리턴타입 바로 앞에 `<T>` 제네릭 타입을 선언해 주어야 한다. 
    *   `<T>`는 타입이 아직 정해져 있지 않은 제네릭 변수를 의미한다.