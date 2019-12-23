# Scanner

> Java의 입력 클래스중 가장 간단한 Scanner에 대해 알아본다.

```java
import java.util.Scanner;
Scanner scan = new Scanner(System.in);
```

* `Scanner`는 `java.util Package` 내부에 존재하는 `Class`이다.
* `System.in`은 가장 기본적인 입력장치, 키보드를 의미한다.

## 주의할점 1

> `\n`이 마지막에 남는 경우

* 숫자를 가져올 때 `nextInt()`를 주로 사용하는데, 이는 엔터는 같이 가져오지 않는다. 그래서 엔터를 제거해줘야 Scanner가 제대로 다음 Line을 읽을 수 있다.

```java
Scanner scan = new Scanner(System.in);

int num = scan.nextInt();
scan.nextLine();
```

* 다음과 같이 엔터를 그 어떤 변수에도 할당하지 않고 소모함으로써 해결할 수 있다.

## 주의할점 2

> 메모리 영역을 낭비하는 경우

* `Scanner` 객체를 사용할 때 `close()`로 마무리해주지 않는 경우, 메모리 영역을 낭비하게 된다. 당장 문제가 생길만큼 많은 메모리 영역을 사용하지 않아 문제가 되지 않아보이지만 자원의 연결을 해제해주는 것이 일반적이므로 해제해주도록 한다.

```java
scan.close();
scan = null;
```

* 연결된 자원을 해제하는 `close()`메소드를 사용하고, `GC(garbage collection)`에게 메모리 영역을 정리해도 된다는 것을 알려주기 위한 `null sign`을 보내주는 것이 좋다.

# Codes

* [Scanner](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test03_Scanner.java)