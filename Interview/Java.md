# Java

> 추가적인 참고자료의 URL이 명시되어 있지 않은 자료들은 모두 Github의 Interview_Question_for_Beginner에서 가져왔다.
> https://github.com/JaeYeopHan/Interview_Question_for_Beginner

## OOP

객체지향 프로그래밍 (Object Oriented Programming)
인간 중심적 프로그래밍, 현실 세계를 코드로 옮겨와 프로그래밍하는 것.
현실 세계의 사물들을 객체라고 보고 그 객체로부터 개발하고자 하는 애플리케이션에 필요한 특징들을 뽑아와 프로그래밍하는 것. 이를 추상화라 한다.

* 장점
  이미 작성한 코드에 대한 재사용성이 높다.
  자주 사용되는 로직을 라이브러리로 만들어두면 계속해서 사용할 수 있으며 그 신뢰성 또한 확보할 수 있다.
  또한 라이브러리를 각종 예외상황에 맞게 잘 만들어두면 개발자가 사소한 실수를 하더라도 그 에러를 컴파일 단계에서 잡아낼 수 있어 버그 발생이 줄어든다.
  또한 내부적으로 어떻게 동작하는지 몰라도 라이브러리가 제공하는 기능들을 사용할 수 있기에 생산성이 높아진다.
  객체 단위로 코드가 나뉘어져 작성되기 때문에 디버깅이 쉽고 유지보수에 용이하다.
  데이터 모델링시 객체와 매핑하는 것이 수월하기 때문에 요구사항을 보다 명확하게 파악하여 프로그래밍할 수 있다.
* 단점
  객체 간의 정보 교환이 모두 메시지 교환을 통해 일어나므로 실행 시스템에 많은 Overhead가 발생한다. (하드웨어의 발전으로 많은 부분 보완되었다.)
  객체가 상태를 가질 수 있다. 변수가 존재하고 이 변수를 통해 객체가 예측할 수 없는 상태를 가지게 되어 애플리케이션 내부에서 버그를 발생시킨다.

### 객체지향적 설계원칙

1. 단일 책임 원칙, SRP(Single Responsibility Principle)
   클래스는 단 하나의 책임을 가져야 하며 클래스를 변경하는 이유는 단 하나의 이유여야 한다.
2. 개방-폐쇄 원칙, OCP(Open-Closed Principle)
   확장에는 열려있어야 하고 변경에는 닫혀있어야 한다.
   확장에 대해 열려있다는 것은 요구 사항이 변경될 때 새로운 동작을 추가해 모듈을 확장할 수 있다는 의미다.
   변경에 대해 닫혀있다는 것은 모듈의 소스 코드나 바이너리 코드를 수정하지 않아도 모듈의 기능을 확장하거나 변경할 수 있다는 의미다.
   추상화를 통한 원칙, 고정되기는 해도 제한되지는 않은 가능한 동작의 묶음을 표현하는 추상화가 가능하다. 이런 모듈은 고정된 추상화에 의존하기 때문에 수정에 대해 닫혀 있을 수 있고 반대로 추상화의 새 파생 클래스를 만드는 것을 통해 확장도 가능하다.
3. 리스코프 치환 원칙, LSP(Liskov Substitution Principle)
   상위 타입의 객체를 하위 타입의 객체로 치환해도 상위 타입을 사용하는 프로그램은 정상적으로 동작해야 한다.
4. 인터페이스 분리 원칙, ISP(Interface Segregation Principle)
   인터페이스는 그 인터페이스를 사용하는 클라이언트를 기준으로 분리해야 한다.
5. 의존 역전 원칙, DIP(Dependency Inversion Principle)
   고수준 모듈은 저수준 모듈의 구현에 의존해서는 안된다.

## JVM, GC

**자바 가상 머신 (Java Virtual Machine)**
자바 애플리케이션을 클래스 로더를 통해 읽어 들여 자바 API와 함께 실행하는 것.
**Java와 OS 사이에서 중개자 역할을 수행하여 Java가 OS에 구애받지 않고 재사용을 가능하게 함.**
스택 기반의 가상머신

한정된 메모리를 효율적으로 사용하여 최고의 성능을 내기 위해서 자바 가상 머신에 대해 알아야함.

Java Program 실행과정

> 1. 프로그램이 실행되면 JVM은 OS로부터 이 프로그램이 필요로 하는 메모리를 할당받는다.
>    JVM은 이 메모리를 용도에 따라 여러 영역으로 나누어 관리한다.
> 2. 자바 컴파일러(javac)가 자바 소스코드(.java)를 읽어들여 자바 바이트코드(.class)로 변환시킨다.
> 3. 클래스 로더를 통해 클래스파일들을 JVM으로 로딩한다.
> 4. 로딩된 클래스 파일들은 Execution Engine을 통해 해석된다.
> 5. 해석된 바이트코드는 Runtime Data Areas에 배치되어 실질적인 수행이 이루어진다.
>
> 이러한 실행과정 속에서 JVM은 필요에 따라 Thread Synchronization과 GC같은 관리작업을 수행한다.

![image-20201228150731553](C:\TIL\Interview\images\Java\image-20201228150731553.png)

### JVM 구성

* **클래스 로더 (Class Loader)**
  JVM 내로 클래스(.class)를 로드하고, 링크를 통해 배치하는 작업을 수행하는 모듈
  Runtime시에 동적으로 클래스를 로드한다.
  jar 파일 내 저장된 클래스들을 JVM위에 탑재하고 사용하지 않는 클래스들은 메모리에서 삭제한다.
  자바는 동적코드, 컴파일 타임이 아니라 런타임에 참조한다. 즉, 클래스를 처음으로 참조할 때 해당 클래스를 로드하고 링크하는 것
* **실행 엔진 (Execution Engine)**
  클래스를 실행시키는 역할.
  클래스 로더가 JVM내의 런타임 데이터 영역에 바이트 코드를 배치시키면 실행엔진에 의해 실행
  자바 바이트코드는 기계가 바로 수행할 수 있는 언어보다는 비교적 인간이 보기 편한 형태로 기술된 것이기 때문에 실행엔진이 바이트코드를 JVM내부에서 기계가 실행할 수 있는 형태로 변경한다. 이 때 두 가지 방식을 사용하여 변경한다.
  * **인터프리터 (Interpreter)**
    실행 엔진이 자바 바이트 코드를 명령어 단위로 읽어서 실행한다.
    이 방식은 한 줄 씩 수행하기 때문에 느리다는 인터프리터 언어의 단점을 그대로 가지고 있다.
  * **JIT (Just - In - Time)**
    인터프리터 방식으로 실행하다가 적잘한 시점에 바이트코드 전체를 컴파일하여 네이티브 코드로 변경하고, 이후에는 더이상 인터프리팅하지 않고 네이티브 코드로 직접 실행하는 방식
    네이티브 코드는 캐시에 보관하기 때문에 한 번 컴파일된 코드는 빠르게 수행하게 된다.
    물론 JIT 컴파일러가 컴파일하는 과정은 바이트코드를 인터프리팅하는 것보다 훨씬 오래걸리므로 한 번만 실행되는 코드라면 컴파일하지 않고 인터프리팅하는 것이 유리하다.
    그래서 JIT 컴파일러를 사용하는 JVM들은 내부적으로 해당 메소드가 얼마나 자주 수행되는지 체크하고, 일정 정도를 넘을 때에만 컴파일을 수행한다.
* **Garbage Collector**
  garbage collection을 수행하는 모듈(Thread)

#### Runtime Data Area

> 프로그램을 수행하기 위해 OS에서 할당받은 메모리 공간

![image-20201228152110547](C:\TIL\Interview\images\Java\image-20201228152110547.png)

* **PC Register**
  Thread가 시작될 때 생성되며 Thread마다 하나씩 존재한다.
  Thread가 어떤 부분을 어떤 명령으로 실행해야할 지에 대한 기록을 하는 부분으로 현재 수행 중인 JVM 명령의 주소를 가진다.

* **JVM 스택 영역**
  프로그램 실행과정에서 임시로 할당되었다가 메소드를 빠져나가면 바로 소멸되는 특성의 데이터를 저장하기 위한 영역이다.
  각종 형태의 변수나 임시 데이터, 스레드나 메소드의 정보를 저장한다.
  메소드 호출 시마다 각각의 스택프레임(그 메소드만을 위한 공간)이 생성된다.
  메소두 수행이 끝나면 프레임 별로 삭제한다. 메소드 안에서 사용되는 값들을 저장한다.
  호출된 메소드의 매개변수, 지역변수, 리턴 값 및 연산 시 일어나는 값들을 임시로 저장한다.

* **Native Method Stack**
  바이트 코드가 아닌 실제 실행할 수 있는 기계어로 작성된 프로그램을 실행시키는 영역이다.
  Java가 아닌 다른 언어로 작성된 코드를 위한 공간이다. Java Native Interface를 통해 바이트 코드로 전환하여 저장한다.
  일반 프로그램처럼 커널이 스택을 잡아 독자적으로 프로그램을 실행시키는 영역이다. 이 부분을 통해 C Code를 실행시켜 커널에 접근할 수 있다.

* **Method Area**
  Class Area, Static Area
  클래스 정보를 처음 메모리 공간에 올릴 때 초기화되는 대상을 저장하기 위한 메모리 공간이다.
  올라가게 되는 메소드의 바이트 코드는 프로그램의 흐름을 구성하는 바이트 코드이다.
  자바 프로그램은 main 메소드의 호출에서부터 계속된 메소드의 호출로 흐름을 이어가기 때문이다.
  대부분 인스턴스의 생성도 메소드 내에서 명령하고 호출한다.
  사실상 컴파일 된 바이트코드의 대부분이 메소드 바이트코드이기 때문에 거의 모든 바이트코드가 올라간다고 봐도 상관없다.

  * **Runtime Constant Pool**
    상수 자료형을 저장하여 참조하고 중복을 막는 역할을 한다.

  **올라가는 정보의 종류**

  * **Field Information**
    멤버변수의 이름, 데이터 타입, 접근 제어자에 대한 정보
  * **Method Information**
    메소드의 이름, 리턴타입, 매개변수, 접근제어자에 대한 정보
  * **Type Information**
    class인지 interface인지의 여부 저장

  Method Area는 클래스 데이터를 위한 공간이라면 Heap영역이 객체를 위한 공간이다.
  Heap과 마찬가지로 GC의 관리 대상에 포함된다.

* **Heap 영역**
  객체를 저장하는 가상 메모리 공간이다.
  new 연산자로 생성된 객체와 배열을 저장한다. 물론 Class Area에 올라온 클래스들만 객체로 생성할 수 있다.
  Heap은 세 부분으로 나눌 수 있다.
  ![image-20201228153722615](C:\TIL\Interview\images\Java\image-20201228153722615.png)

  * **Permanent Generation**
    생성된 객체들의 정보의 주소값이 저장된 공간이다.
    클래스 로더에 의해 로드되는 클래스, 메소드등에 대한 메타정보가 저장되는 영역이고 JVM에 의해 사용된다.
    Reflection을 사용하여 동적으로 클래스가 로딩되는 경우에 사용된다.
    내부적으로 Reflection 기능을 자주 사용하는 Spring Framework를 이용할 경우 이 영역에 대한 고려가 필요하다.
  * **New/Young 영역**
    * **Eden**
      객체들이 최초로 생성되는 공간
    * **Survivor 0 / 1**
      Eden에서 참조되는 객체들이 저장되는 공간
  * **Old 영역**
    New Area에서 일정 시간 참조되고 있는, 살아남은 객체들이 저장되는 공간
    대부분 Young 영역보다 크게 할당하며, 크기가 큰 만큼 Young 영역보다 GC는 적게발생한다.
  Eden 영역에 객체가 가득차게 되면 첫번째 GC(minor GC)가 발생한다. Eden 영역에 있는 값들은 Survivor 1 영역에 복사하고 이 영역을 제외한 나머지 영역의 객체를 삭제한다. 
  
  인스턴스는 소멸 방법과 소멸 시점이 지역 변수와는 다르기에 Heap이라는 별도의 영역에 할당된다.
  JVM은 더이상 인스턴스의 존재 이유가 없을 때 소멸시킨다.

#### 참고

https://asfirstalways.tistory.com/158

### GC

> Garbage Collection

**Java는 프로그램 코드에서 메모리를 명시적으로 지정하여 해제하지 않는다.**
가끔 명시적으로 해제하려고 해당 객체를 null로 지정하거나 System.gc() 메소드를 호출하는 개발자가 있는데, null로 지정하는 것은 큰 문제가 안되지만 System.gc() 메소드를 호출하는 것은 시스템의 성능에 큰 영향을 끼치므로 절대 사용하면 안된다.
개발자가 프로그램 코드로 메모리를 명시적으로 해제하지 않기 때문에 **Garbage Collector가 더이상 필요 없는 객체를 찾아 지우는 작업을 한다.**
Garbage Collector는 두 가지 가설 하에 만들어졌다.

* 대부분의 객체는 금방 접근 불가능 상태(unreachable)가 된다.
* 오래된 객체에서 젊은 객체로의 참조는 아주 적게 존재한다.

이러한 가설을 **Weak generational hypothesis**라고 한다.
이 가설의 장점을 살리기 위해 Young 영역과 Old 영역이 나누어진 것이다.

* **minor GC**
  새로 생성된 대부분의 객체(Instance)는 Eden 영역에 위치한다.
  Eden 영역에서 GC가 한 번 발생한 후 살아남은 객체는 Survivor 영역 중 하나로 이동된다.
  이 과정을 반복하다가 계속해서 살아남아 있는 객체는 일정시간 참조되고 있다는 뜻이므로 Old 영역으로 이동시킨다.
* **Major GC (Full GC)**
  Old 영역에 있는 모든 객체들을 검사하여 참조되지 않은 객체들을 한꺼번에 삭제한다.
  시간이 오래걸리고 실행 중 프로세스가 정지된다. 이를 **stop-the-world**라고 하는데 Major GC가 발생하면 GC를 실행하는 Thread를 제외한 나머지 Thread는 모두 작업을 멈춘다. GC 작업을 완료한 이후에야 중단했던 작업을 다시 시작한다.
  어떤 GC 알고리즘을 사용하더라도 stop-the-world는 발생한다. 대개의 경우 **GC 튜닝이란 이 시간을 줄이는 것**이다.

**GC는 어떤 원리로 소멸시킬 대상을 선정하는가?**

GC는 Heap 내의 객체 중에서 Garbage를 찾아내고 찾아낸 Garbage를 처리해서 Heap의 메모리를 회수한다.
참조되고 있지 않은 객체를 garbage라고하며 객체가 garbage인지 아닌지 판단하기 위해서 **reachability**라는 개념을 사용한다.
**어떤 Heap 영역에 할당된 객체가 유효한 참조가 있으면 reachability, 없으면 unreachability로 판단**한다.
하나의 객체는 다른 객체를 참조하고, 다른 객체는 또 다른 객체를 참조할 수 있기 때문에 참조 사슬이 형성이 되는데 이 **참조 사슬 중 최초에 참조한 것을 Root Set**이라고 칭한다.
Heap 영역에 있는 객체들은 총 4가지 경우에 대한 참조를 하게 된다.
![image-20201228154355308](C:\TIL\Interview\images\Java\image-20201228154355308.png)|

1. Heap 내의 다른 객체에 의한 참조
2. Java 스택, 즉 Java 메소드 실행 시에 사용하는 지역변수와 파라미터들에 의한 참조
3. 네이티브 스택(JNI, Java Native Interface)에 의해 생성된 객체에 대한 참조
4. 메소드 영역의 정적 변수에 의한 참조

2, 3, 4는 Root Set. 즉, 참조 사슬 중 최초에 참조한 것이다.

인스턴스가 GC의 대상이 되었다고 해서 바로 소멸되는 것은 아니다.
빈번한 GC의 실행은 시스템에 부담이 될 수 있기에 성능에 영향을 미치지 않도록 GC 실행타이밍은 별도의 알고리즘 기반으로 계산된다.

* **Serial GC**
  데스크톱의 CPU 코어가 하나만 있을 때 사용하기 위해서 만든 방식이므로 애플리케이션의 성능이 많이 떨어진다. 사용하지 말 것
  Mark-Sweep-Compact 라는 알고리즘을 사용한다.
  Old 영역에 살아 있는 객체를 식별하는 Mark단계, Heap의 앞 부분부터 확인하여 살아 있는 것만 남기는 Sweep 단계, 각 객체들이 연속되게 쌓이도록 Heap의 가장 앞 부분부터 채워서 객체가 존재하는 부분과 객체가 없는 부분으로 나누는 Compaction 단계
  Serial GC는 적은 메모리와 CPU 코어 개수가 적을 때 적합한 방식이다.
* **Parallel GC**
  기본적인 GC 알고리즘은 Serial GC와 동일하지만 Parallel GC는 GC를 처리하는 Thread가 여러 개라서 보다 빠른 GC를 수행한다.
  메모리가 충분하고 코어의 개수가 많을 때 유리하다.
* **Parallel Old GC (Parallel Compacting GC)**
  JDK 5 update 6부터 제공한 GC방식이다.
  별도로 살아있는 객체를 식별한다는 부분에서 보다 복잡한 단계로 수행된다.
* **CMS GC**
  Initial Mark 단계에서 클래스 로더에서 가장 가까운 객체 중 살아 있는 객체만 찾는 것으로 끝낸다. 따라서 멈추는 시간은 매우 짧다.
  Concurrent Mark 단계에서는 방금 살아있다고 확인한 객체에서 참조하고 있는 객체들을 따라가면서 확인한다. 이 단계의 특징은 다른 스레드가 실행 중인 상태에서 동시에 진행된다는 점이다.
  Remark 단계에서는 Concurrent Mark 단계에서 새로 추가되거나 참조가 끊긴 객체를 확인한다.
  Concureent Sweep 단계에서 쓰레기를 정리하는 작업을 실행한다. 이 작업도 다른 스레드가 실행되고 있는 상황에서 진행한다.
  이렇게 진행되는 GC 방식이기 때문에 stop-the-world 시간이 매우 짧다. 그래서 Low Latency GC라고도 부른다.
  하지만 단점으로 다른 GC 방식보다 메모리와 CPU를 더 많이 사용하며, Compaction 단계가 기본적으로 제공되지 않는 점이 있다.
  따라서, 조각난 메모리가 많아 Compaction 작업을 실행하면 다른 GC 방식보다 stop-the-world 시간이 길기 때문에 Compaction 작업이 얼마나 자주, 오랫동안 수행되는지 확인하고 신중히 검토한 후 사용해야 한다.
* **G1 GC**
  바둑판의 각 영역에 객체를 할당하고 GC를 실행한다. 그러다가 해당 영역이 꽉 차면 다른 영역에서 객체를 할당하고 GC를 실행한다.
  Young 영역에서 Old 영역으로 데이터가 이동하는 단계가 사라진 GC방식이다.
  가장 큰 장점은 성능이다. 이전까지 설명한 GC 방식보다 빠르다.

#### 참고

https://asfirstalways.tistory.com/159

https://d2.naver.com/helloworld/1329

https://d2.naver.com/helloworld/329631 (추가적인 내용 있을 수 있음)

## Collection

다수의 Data를 다루는데 표준화된 클래스들을 제공해주기 때문에 Data Structure를 직접 구현하지 않고 편하게 사용할 수 있는 기능
배열과 다르게 객체를 보관하기 위한 공간을 미리 정하지 않아도 되므로, 상황에 따라 객체의 수를 동적으로 정할 수 있다. 이는 프로그램의 공간적인 효율성을 높여준다.

* List
  대표적인 구현체로 ArrayList가 존재하며, 이외에도 LinkedList가 존재한다.

  ```java
  import java.util.ArrayList;
  import java.util.LinkedList;
  
  ...
      
  ArrayList<Integer> list = new ArrayList<Integer>();
  LinkedList<Integer> linkedList = new LinkedList<Integer>();
  ```

* Map
  대표적인 구현체로 HashMap가 존재하며, Key에 대한 순서를 보장하는 LinkedHashMap이 존재한다.
  key-value의 구조로 이루어져 있으며 key를 기준으로 중복된 값을 저장하지 않으며 순서를 보장하지 않는다.

  ```java
  import java.util.Map;
  import java.util.HashMap;
  
  ...
  
  Map<Integer, Integer> map = new HashMap<>();
  ```

* Set
  대표적인 구현체로 HashSet이 존재하며, key에 대한 순서를 보장하는 LinkedHashSet이 존재한다.
  value에 대해서 중복된 값을 저장하지 않는다. 사실 Set은 Map의 key-value 구조에서 key대신 value가 들어가 value를 key로 하는 자료구조일 뿐이다.

  ```java
  import java.util.Set;
  import java.util.HashSet;
  
  ...
  
  Set<Integer> set = new HashSet<>();
  ```

* Stack, Queue
  Stack 객체는 직접 new 키워드로 사용할 수 있으며, Queue 인터페이스는 LinkedList에 new 키워드를 적용하여 사용할 수 있다.

  ```java
  import java.util.Stack;
  import java.util.Queue;
  import java.util.LinkedList;
  
  ...
  
  Stack<Integer> stack = new Stack<>();
  Queue<Integer> queue = new LinkedList<>();
  ```

## Annotation

본래 주석이란 뜻으로, 인터페이스를 기반으로 한 문법.
주석과는 그 역할이 다르지만 주석처럼 코드에 달아 클래스에 특별한 의미를 부여하거나 기능을 주입하거나 해석되는 시점을 정할수도 있다.

* built-in annotation
  JDK에 내장되어 있는 어노테이션
  상속받아서 메소드를 오버라이딩 할 때 나타나는 `@Override`가 대표적인 예시.
* Meta annotation
  어노테이션에 사용되는 어노테이션으로 해당 어노테이션의 동작 대상을 결정한다. 주로 새로운 어노테이션을 정의할 때 사용한다.
  어노테이션의 동작 대상을 결정하는 Meta annotation에도 여러 가지가 존재한다.
* Custom annotation
  개발자가 직접 만들어내는 어노테이션

### 참고

https://asfirstalways.tistory.com/309

## Generic

자바에서 안정성을 맡고 있다.
다양한 타입의 객체들을 다루는 메소드나 Collection 클래스에서 사용하는 것으로, 컴파일 과정에서 타입체크를 해주는 기능이다.
그렇기에 객체의 타입 안전성을 높이고 형변환의 번거로움을 줄여준다.

## Final keyword

* **final class**
  다른 클래스에서 상속하지 못한다.
* **final method**
  다른 메소드에서 오버라이딩하지 못한다.
* **final variable**
  변하지 않는 상수값이 되어 새로 할당할 수 없는 변수가 된다.
* finally
  try-catch 혹은 try-catch-resource 구문을 사용할 때, 정상적으로 작업을 한 경우와 에러가 발생했을 경우를 포함하여 마무리해줘야하는 작업이 존재하는 경우에 해당하는 코드를 작성해주는 코드 블록이다.
* finalize()
  GC에 의해 호출되는 함수로 절대 호출해서는 안되는 함수이다.
  Object 클래스에 정의되어 있으며 GC가 발생하는 시점이 불분명하기 때문에 해당 메소드가 실행된다는 보장이 없다.
  해당 메소드가 오버라이딩 되어 있으면 GC가 이루어질때 바로 Garbage Collecting 되지 않는다. GC가 지연되며 OOME(Out of Memory Exception)이 발생할 수 있다.

## Overriding vs Overloading

둘 다 다형성을 높여주는 개념이지만 전혀 다른 개념이라고 볼만큼 차이가 있다.

* 오버라이딩 (Overriding)
  상위 클래스 혹은 인터페이스에 존재하는 메소드를 하위 클래스에서 필요에 맞게 재정의하는 것을 의미한다.
  Java의 경우 오버라이딩 시 동적바인딩된다.
* 오버로딩 (Overloading)
  메소드 이름과 return 타입은 동일하지만, 매개변수만 다른 메소드를 만드는 것을 의미한다.
  다양한 상황에서 메소드가 호출될 수 있도록 한다.
  Java의 경우 오버로딩은 다른 시그니쳐를 만드는 것으로, 아예 다른 함수를 만든것과 비슷하다.
  시그니쳐가 다르므로 정적바인딩으로 처리 가능하며, Java의 경우 정적으로 바인딩된다.

## Access Modifier

변수 또는 메소드의 접근 범위를 설정해주기 위해서 사용하는 Java의 예약어를 의미하며 4가지 종류가 존재한다.

* **public**
  어떤 클래스에서라도 접근이 가능하다.
* **protected**
  클래스가 정의되어 있는 해당 패키지 내 그리고 해당 클래스를 상속받은 외부 패키지의 클래스에서 접근이 가능하다.
* **(default)**
  클래스가 정의되어 있는 해당 패키지 내에서만 접근이 가능하도록 접근 범위를 제한한다.
  생략이 가능하다.
* **private**
  정의된 해당 클래스에서만 접근이 가능하도록 접근 범위를 제한한다.

## Wrapper Class

기본 자료형 (Primitive data type)에 대한 클래스 표현을 의미한다. `Integer`, `Float`, `Boolean`등이 예시이다.
Collection에서 Generic을 사용하기 위해서 Wrapper Class를 사용해야 하고 `null`값을 반환해야만 하는 경우에 return type을 Wrapper Class로 지정하여 `null`을 반환하도록 할 수 있다.
일반적인 상황에서 Wrapper Class를 사용해야 하는 이유는 객체지향적인 프로그래밍이 아니고서야 없다.
기본 자료형의 경우 `==`를 사용하여 값을 비교할 수 있지만, Wrapper Class의 경우 `intValue()` 메소드를 통해 값을 가져와 비교해야 한다.

### Autoboxing

JDK 1.5부터 제공하는 기능.
각 Wrapper Class에 상응하는 기본 자료형일 경우에만 가능하다.
`Integer`라는 Wrapper Class로 설정한 Collection 데이터에 add할 때 Integer 객체로 감싸서 넣지 않는다. Java 내부에서 Autoboxing 해주기 때문이다.

## Multi-Thread 환경에서의 개발

* Field member
  field란 클래스에 변수를 정의하는 공간을 의미한다.
  이곳에 변수를 만들어두면 메소드끼리 변수를 주고 받는데 있어서 참조하기 쉬우므로 정말 편리한 공간 중 하나이다.
  하지만 객체에 여러 Thread가 접근하는 싱글톤 객체라면 field에서 상태값을 갖고 있으면 안된다. 모든 변수를 parameter로 넘겨받고 return하는 방식으로 코드를 구성해야 한다.

* 동기화 (Synchronized)
  필드에 Collection이 불가피하게 필요할 때는 synchronized 키워드를 사용하여 Thread간 race condition을 통제한다.
  이 키워드를 기반으로 구현된 Collection으로 List를 대신한 Vector와 Map을 대신한 HashTable을 사용할 수 있다. 하지만 이 Collection들은 제공하는 API가 적고 성능도 좋지 않다.
  기본적으로 Collections라는 util 클래스에서 제공되는 static 메소드를 통해 이를 해결할 수 있다.
  `Collections.synchronizedList()`, `Collections.synchronizedMap()`, `Collections.synchronizedSet()` 등이 존재한다.
  JDK 1.7 부터는 `concurrent package`를 통해 `ConcurrentHashMap`이라는 구현체를 제공한다. Collections util을 사용하는 것보다 `synchronized` 키워드가 적용된 범위가 좁아서 보다 좋은 성능을 낼 수 있는 자료구조이다.

* ThreadLocal
  Thread 사이에 간섭이 없어야 하는 데이터에 사용한다.
  멀티스레드 환경에서는 클래스의 필드에 멤버를 추가할 수 없고 매개변수로 넘겨받아야하기 때문이다.
  즉, Thread 내부의 싱글톤을 사용하기 위해 사용한다. 주로 사용자 인증, 세션 정보, 트랜잭션 컨텍스트에 사용한다.

  Thread Pool 환경에서 ThreadLocal을 사용하는 경우 ThreadLocal 변수에 보관된 데이터의 사용이 끝나면 반드시 해당 데이터를 삭제해 주어야 한다.
  그렇지 않을 경우 재사용되는 Thread가 올바르지 않은 데이터를 참조할 수 있다.

  ThreadLocal을 사용하는 방법은 간단하다.

  1. ThreadLocal 객체를 생성한다.
  2. ThreadLocal.set() 메소드를 이용하여 현재 Thread의 로컬 변수에 값을 저장한다.
  3. ThreadLocal.get() 메소드를 이용하여 현재 Thread의 로컬 변수 값을 읽어온다.
  4. ThreadLocal.remove() 메소드를 이용하여 현재 Thread의 로컬 변수 값을 삭제한다.