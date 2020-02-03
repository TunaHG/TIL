# AOP

> AOP : Aspect Oriented Programming
>
> 관점 지향 프로그래밍, 어떤 로직을 기준으로 핵심적인 관점과 부가적인 관점으로 나누어서 보고 그 관점을 기준으로 각각 모듈화하는 것
>
> 우리가 그동안 사용한 Java는 OOP(Object Oriented Programming, 객체 지향 프로그래밍)이다.

## Feature

* 여러 Java Framework의 기능들 중 Spring에만 있는 특징

* 서로 다른 Class들에서 공통적으로 들어가는 Code가 존재할 때, 별도의 Class로 분리하여 공통 Code를 작성한 후 다른 Class에 붙이거나 떼면서 작업하여 결합도를 낮추는 것.

* **관심분리**

  ![image-20200203101015200](image/image-20200203101015200.png)

  * 횡단관심이 공통된 Code가 작성된 Class이다.
  * 구현이 필요한 코드 - **핵심관심코드** (= 종단관심코드)
  * 공통된 Code가 작성될 반복구현사항들 - **공통관심코드** (= 횡단관심코드)

### Proxy Pattern

> 23가지 자바 개발 디자인 패턴 중 AOP와 비슷한 패턴

* ProxyInter라는 Interface를 상속받는 A, B, C중 A와 C는 변경되더라도 B는 변경되지 않는다.
  * 이 때의 B Class의 역할은 공통 실행 내용 객체 (= 공통관심코드)
  * A, C Class는 구현하는 서로 다른 Class (= 핵심관심코드)
  
* B의 Action을 실행하면 공통부분을 실행하고 p의 Action을 실행하면 공통부분이 없다.

* **Codes**

  [Interface Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/proxypattern/ProxyInter.java), [A Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/proxypattern/A.java), [B Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/proxypattern/B.java), [C Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/proxypattern/C.java), [Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/proxypattern/ProxyMain.java)

  * A와 C Class가 핵심관심코드이며 B Class가 공통관심코드이다.

## Setting

### Weaver Library Download

* `pom.xml`의 `<dependency>`를 추가함으로써 Eclipse에서 자동으로 설치하도록 만들 수 있다.
  * 이 때, `<dependency>`내부에 들어갈 Content를 알아야 하는데, [Mvn Repository](https://mvnrepository.com)에서 가져올 수 있다.
  * **aspectjweaver**로 검색한 후 사용자가 많은 첫 번째로 들어가서 역시나 사용자가 많은 1.9.2버전을 선택
  * 중간쯤의 Maven탭을 살펴보면 `<dependency>` 코드가 나와있으므로 복사한다.
  * `pom.xml`에서 `<dependencies>` 내부에 해당 코드를 붙여넣기한다.
  * 저장하면 Eclipse에서 Library를 자동으로 설치한다. 이후에 **Maven Dependency**에서 확인할 수 있다.
* xml 설정 파일에서 아래의 **Namespaces** 탭을 눌러서 **AOP**를 체크해준 후 진행한다.

## AOP Word

### JoinPoint

> 클라이언트가 호출하는 모든 비즈니스 메소드(핵심관심 메소드)

* 포인트컷 대상, 포인트컷 후보라고도 한다.
  * JoinPoint중에서 Pointcut이 선택되기 때문이다.
* JoinPoint에서 제공하는 유용한 메소드
  * `Signature getSignature()` : 시그니처(return type, 이름, 매개변수) 정보가 저장된 객체 return
    * `String getName()` : 메소드 이름 return
    * `String toLongString()` : 메소드의 return type, 이름, 매개변수를 패키지 경로까지 포함하여 return
    * `String toShortString()` : 메소드 Signature를 축약한 문자열로 return
  * `Object getTartget()` : 비즈니스 메소드를 포함하는 비즈니스 객체 return
  * `Object[] getArgs()` : 메소드를 호출할 때 넘겨준 인자 목록을 Object 배열로 return
* Around에서 사용한 ProceedingJoinPoint는 JoinPoint를 상속했다.
  * 추가적으로 메소드를 실행시키는 `proceed()` 메소드를 사용할 수 있다.
  * Around에서만 사용가능하며 다른 5가지 Advice에서는 JoinPoint를 사용해야 한다.
    * Around에서만 `proceed()`가 필요하기 때문

### PointCut

> 필터링된 JoinPoint

* 원하는 특정 메소드에서만 횡단 관심에 해당하는 공통 기능을 수행시키기 위해서 사용한다.

  * 공통 관심 메소드는 모든 핵심 관심메소드에서 동작할 필요가 없다. 
    특정 핵심관심 메소드에서만 동작하면 된다.

* 다음과 같이 사용한다.

  ```xml
  <aop:pointcut expression="execution (public * aop1.*.*(..))" id="pc"/>
  ```

  * execution 형식 : `{Modifier} {returntype} {package}.{class}.{method}({parameter})`
    * 주어진 형식에 맞는 메소드를 선택한다.
    * `{Modifier}`
      * 특정 Modifier가 아닌 모든 Modifier를 적용하려면 `*`를 입력하는 것이 아니라 입력하지 않는다.
    * `{Return Type}`
      * `*` : 모든 return type
      * `void` : return type이 void인 메소드만 선택
      * `!void` : return type이 void가 아닌 메소드만 선택
      * `com.springbook.biz.UserVO` : return type이 UserVO인 메소드만 선택(java.lang 패키지에 포함된 기본형 데이터가 아니라면 모든 패키지 경로를 명시해야 한다.)
    * `{package}`
      * `*` : 모든 package
      * `com.springbook.biz` : 정확하게 해당 패키지만 선택
      * `com.springbook.biz..` : 해당 패키지로 시작하는 모든 패키지 선택
      * `com.springbook..impl` : `com.springbook` 패키지로 시작하며 마지막 패키지 이름이 `impl`로 끝나는 패키지 선택
    * `{class}`
      * `{Class Name}` : 특정 클래스만 선택
      * `*Impl` : 클래스 이름이 Impl로 끝나는 클래스만 선택
      * `{Class Name}+` : 뒤에 `+`가 붙으면 해당 클래스로부터 파생된 모든 자식클래스 선택 (인터페이스도 마찬가지)
    * `{Method}`
      * `*(..)` : 모든 메소드 선택
      * `get*(..)` : 메소드 이름이 get으로 시작하는 모든 메소드 선택
    * `{parameter}`
      * `(..)` : 매개변수의 개수와 타입에 제약이 없음 (모든 메소드 선택)
      * `(*)` : 반드시 1개의 매개변수를 가지는 메소드 선택
      * `(com.springbook.biz.UserVO)` : UserVO를 매개변수로 가지는 메소드만 선택 (클래스의 패키지 경로가 반드시 포함되어야 한다.)
      * `(!com.springbook.biz.UserVO)` : UserVO를 매개변수로 가지지 않는 메소드만 선택
      * `(Integer, ..)` : 한 개 이상의 매개변수를 가지되 첫 번째 매개변수 타입이 Integer인 메소드만 선택
      * `(Integer, *)` : 반드시 두 개의 매개변수를 가지되 첫 번째 매개변수 타입이 Integer인 메소드만 선택
  * `expression`에는 `execution`이 아닌 `bean()` 혹은 `within()` 등이 올 수 있다.
    * `bean()`은 bean의 id를 활용하여 선택한다.
      * ex : `bean("common")` (Coomon Class 내부의 모든 Method)
    * `within()`은 특정 메소드가 아닌 특정 클래스나 인터페이스 내에 존재하는 모든 메소드를 선택
      * ex : `within("aop1.Common")` (Common Class 내부의 모든 Method)

### Advice

> 횡단 관심에 해당하는 공통 기능의 코드를 의미한다.

* 독립된 Class의 메소드로 작성된다.

#### Before

* `pointcut-ref`로 지정된 메소드 **이전**에 `method`로 지정된 메소드를 실행한다.

  ```xml
  <aop:before method="a" pointcut-ref="pc"/>
  ```

#### After

* `pointcut-ref`로 지정된 메소드 **이후**에 `method`로 지정된 메소드를 실행한다.

  ```xml
  <aop:after method="b" pointcut-ref="pc"/>
  ```

  * `try-catch-finally`에서 `finally`블록처럼 비즈니스 메소드가 실행된후 무조건 실행

* `after-returning` : 비즈니스 메소드가 성공적으로 return되면 동작

  * `<aop:after>`에 인자로 `returning= `추가

* `after-throwing` : 비즈니스 메소드 실행 중 예외가 발생하면 동작

  * `try-catch`에서 `catch`블록에 해당하는 것처럼
  * `<aop:after>`에 인자로 `throwing=` 추가

#### Around

* `pointcut-ref`로 지정된 메소드 **이전과 이후**에 `method`로 지정된 메소드를 실행한다.

  ```xml
  <aop:around method="c" pointcut-ref="pc"/>
  ```

* 메소드에서 `ProceedingJoinPoint` 객체를 매개변수로 받아서 `proceed()` 메소드를 사용하면 `pointcut-ref`로 지정된 메소드를 실행 시킨 이후에 `method`로 지정된 메소드의 나머지 부분을 실행한다.

* `ProceedingJoinPoint` : `JoinPoint` 중 하나, 클라이언트가 호출하는 모든 비즈니스 메소드.

  * `proceed()` : 메소드를 실행한다.
  * `getTarget()` : 실행되는 메소드의 클래스를 알 수 있다.
  * `getArgs()` : 객체의 Argument를 반환한다.
  * `toLongString()` : `expression`이 어떤 것으로 동작하였는지 확인할 수 있다.

#### Codes

* [XML File](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/aop.xml)
* [Common Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/Common.java) => 횡단관심 코드

### Weaving

> 핵심관심 메소드가 호출될 때, advice에 해당하는 공통관심 메소드가 삽입되는 과정

* 컴파일타임 위빙, 로딩타임 위빙, 런타임 위빙이 있지만 Spring에서는 런타임 위빙 방식만 지원한다.

### Aspect

> PointCut과 Advice의 결합, 어떤 PointCut Method에서 어떤 Advice Method를 실행할지 결정

* 다음과 같이 구성되어 있다.

  ```xml
  <aop:config>
  	<aop:pointcut expression="execution (public * aop1.*.*(..))" id="pc"/>
  	<aop:aspect	id="aspect1" ref="common">
  		<aop:before method="a" pointcut-ref="pc"/>
  	</aop:aspect>
  </aop:config>
  ```

  1. `pointcut-ref`로 설정된 `pc`, Pointcut Method가 호출될 때,
  2. `aspect1`이라는 Advice 객체의 
  3. `a()`메소드가 실행되고
  4. 이 때, `a()`메소드의 동작 시점이 `<aop:before>`이라는 내용의 설정이다.

* Aspect를 설정할 때 `<aop:aspect>` element를 사용하는데, 트랜잭션 설정에서는 `<aop:advisor>`을 사용한다.

  * 둘이 같은용어라는 것만 확인한다.

## AOP Element

### Config

> `<aop:config>`,Root Element

* 설정 파일 내에 여러번 사용할 수 있다.
* 내부에는 `<aop:pointcut>`, `<aop:aspect>`등의 element가 위치할 수 있다.

### Pointcut

> `<aop:pointcut>`, Pointcut을 지정하기 위해 사용

* `<aop:config>`나 `<aop:aspect>`의 자식 element로 사용할 수 있다.
  * `<aop:aspect>`하위에 설정된 pointcut은 해당 aspect에서만 사용할 수 있다.
* pointcut은 여러 개 정의할 수 있으며, 유일한 ID를 할당하여 Aspect를 설정할 때 Pointcut을 참조하는 용도로 사용한다.

### Aspect

> `<aop:aspect>`, 핵심 관심에 해당하는 Pointcut Method와 횡단 관심에 해당하는 Advice Method를 결합하기 위해 사용

* Aspect를 어떻게 설정하느냐에 따라서 Weaving 결과가 달라지므로 AOP에서 가장 중요한 설정이다.

### Advisor

> `<aop:advisor>`, Pointcut과 Advice를 결합한다는 점에서 Aspect와 같은 기능

* 트랜잭션 설정 같은 몇몇 특수한 경우는 Aspect가 아닌 Advisor를 사용해야 한다.

## Codes

* [Member Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/Member.java), [Board Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/Board.java), [Common Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/Common.java), [Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/AopMain.java), [XML File](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/aop1/aop.xml)
* Member와 Board Class는 핵심관심코드이며 Common Class는 공통관심코드이다.

## Annotation

> Annotation을 적용하여 xml 설정파일의 Line을 줄여본다.

### Setting

* xml 설정파일에서 **Namespaces** 탭으로 진입하여 **context, aop**를 체크한 후 진행한다.

* 이후 xml 설정파일의 `<beans>`내부에 다음과 같은 코드를 작성한다.

  ```xml
  <context:component-scan base-package="{package directory}"/>
  <aop:aspectj-autoproxy/>
  ```

  * `<context:component-scan>`은 `@Autowired`, `@Repository`, `@Component`, `@Service` 등의 **Annotation**을 탐색하는 태그
  * `<aop:aspectj-autoproxy>`는 `@Aspect`, `@Pointcut`, `@Before`, `@After`, `@Around` 등의 **Annotation**을 탐색하는 태그
  * 이외의 `<bean>`과 `<aop:config>`는 각 Class의 **Annotation**으로 대체되니 삭제한다.

### PointCut

* 객체로 생성할 각 Class 선언부 위에 `@Component`혹은 `@Service`를 기능에 맞게 선언한다.

* 공통관심코드가 포함된 Class 선언부 위에는 `@Component`뿐만 아니라 `@Aspect`도 선언한다.

  * 해당 Class에 다음과 같은 **구현부가 빈 메소드**를 선언한다.

    ```java
    public void pc() { }
    ```

    * 해당 메소드 위에 `@Pointcut`을 선언한다. 이 메소드는 `@Pointcut`의 대상이 되는 메소드다.
    * `@Pointcut`의 Argument로 Weaving에서 `<aop:pointcut expression="">`에 진행한 값을 넣는다. `execution ()`와 같은 것을 넣으면 된다.
    
  * `@Pointcut`만 존재하는 Class에서는 `@Aspect`를 선언할 필요가 없다.

    * `@Aspect`는 Pointcut과 Advice가 결합된 Class에서 사용한다.

### Advice

* 공통관심코드 메소드 위에 어디서 실행할 것인지에 따라 `@Before`, `@After`, `@Around`를 메소드 위에 선언한다.

  * 각 **Annotation**에 Argument로 `@Pointcut`의 대상이 되는 메소드의 이름을 선언한다. (여기서는 `pc()`)

### Codes

* [Member Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/aop1/Member.java), [Board Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/aop1/Board.java), [Common Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/aop1/Common.java), [Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/aop1/AopMain.java), [XML File](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/aop1/aop.xml)
  * Member와 Board Class는 핵심관심코드이며 Common Class는 공통관심코드이다.