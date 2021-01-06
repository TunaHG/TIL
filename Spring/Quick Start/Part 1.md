# Part 1

## Framework

프레임워크의 사전적 의미는 뼈대 혹은 틀로서 이 의미를 소프트웨어 관점에서 접근하면 아키텍처에 해당하는 골격코드이다.
개발과 유지보수의 일관성을 유지하기 위하여 기본이 되는 뼈대나 틀을 제공하여 개발자는 뼈대에 살을 붙이는 작업만 하면 되도록 도와주는 것

* 장점
  1. **빠른 구현 시간**
     개발자는 프레임워크에서 아키텍처로 주어진 골격 코드에 비즈니스 로직만 구현하면 되므로 제한된 시간에 많은 기능을 구현할 수 있다.
  2. **쉬운 관리**
     같은 프레임워크가 적용된 애플리케이션들은 아키텍처가 같으므로 관리가 쉽다.
     이는  결과적으로 유지보수에 들어가는 인력과 시간도 줄일 수 있다.
  3. **개발자들의 역량 획일화**
     프레임워크를 사용하면 숙련된 개발자와 초급 개발자의 코드가 비슷해진다.
     이는 관리자 입장에서 개발 인력을 더 효율적으로 구성할 수 있게 한다.
  4. **검증된 아키텍처의 재사용과 일관성 유지**
     아키텍처에 관한 별다른 고민이나 검증 없이 소프트웨어를 개발할 수 있다.
     이후 시간이 지나도 유지보수 과정에서 아키텍처가 왜곡되거나 변형되지 않는다.

## Spring F/W

복잡하고, 비싸고, 많은 시간과 노력이 필요한 EJB(Enterprise Java Beans)를 대체하는 프레임워크이다.
스프링 프레임워크는 평범한 *POJO를 사용하면서도 EJB에서만 가능했던 많은 일을 가능하도록 지원한다.

* 특징

  IoC와 AOP를 지원하는 경량의 컨테이너 프레임워크

  1. **경량(Lightweight)**
     우선 여러 개의 모듈로 구성되어 있으며, 각 모듈은 하나 이상의 JAR 파일로 구성되어 있다. 이 몇 개의 JAR 파일만 있으면 개발과 실행이 모두 가능하다.
     따라서 스피링을 이용해서 만든 애플리케이션의 배포 역시 매우 빠르고 쉽다.
     두 번째 이유는 POJO 형태의 객체를 관리하기 때문이다. 클래스를 구현하는 데 특별한 규칙이 없는 단순하고 가벼운 객체이므로 POJO 를 관리하는 것은 EJB 객체를 관리하는 것보다 훨씬 가볍고 빠를 수 밖에 없다.
  2. **제어의 역행(Inversion of Control)**
     스프링은 IoC를 통해 *낮은 결합도를 유지한다.
     IoC가 적용되기 이전에는 객체의 생성이나 객체 사이의 의존관계를 개발자가 직접 자바 코드로 처리해야 해서 의존관계에 있는 객체를 변경할 때 반드시 자바 코드를 수정해야 한다.
     IoC가 적용되면 객체 생성과 객체 사이의 의존관계를 컨테이너가 대신 처리한다. 결과적으로 소스에 의존관계가 명시되지 않으므로 결합도가 떨어져서 유지보수가 편리해진다.
  3. **관점 지향 프로그래밍(AOP, Aspect Oriented Programming)**
     AOP는 비즈니스 메소드를 개발할 때, 핵심 비즈니스 로직과 각 비즈니스 메소드마다 반복해서 등장하는 공통 로직을 분리함으로써 응집도가 높게 개발할 수 있도록 지원한다.
     **공통으로 사용하는 기능들을 외부의 독립된 클래스로 분리하고, 해당 기능을 프로그램 코드에 직접 명시하지 않고 선언적으로 처리하여 적용하는 것**이 AOP의 기본개념이다.
  4. **컨테이너(Container)**
     특정 객체의 생성과 관리를 담당하며 객체 운용에 필요한 다양한 기능을 제공한다. 일반적으로 서버 안에 포함되어 배포 및 구동된다.
     애플리케이션 운용에 필요한 객체를 생성하고 객체 간의 의존관계를 관리한다는 점에서 스프링도 일종의 컨테이너라고 할 수 있다.

* **IoC Container**

  자신이 관리할 클래스들이 등록된 XML 설정 파일을 로딩하여 구동한다. 클라이언트의 요청이 들어오는 순간 XML 설정 파일을 참조하여 객체를 생성하고 객체의 생명주기를 관리한다.

### Spring Container 

#### Setting File

새 파일 생성 Wizard에서 Spring 폴더의 Spring Bean Configuration File을 선택하여 이름을 입력하면 스프링 설정 파일이 생성된다. 이때 기본적으로 `<beans>` 루트 엘리먼트와 네임스페이스 관련 설정들이 추가되어 제공된다.

사용하려고 하는 클래스 하나당 하나의 `<bean>` 설정이 필요하다.
`<bean>` 엘리먼트에서 가장 중요한 것은 class 속성값이다. 여기에 패키지 경로가 포함된 전체 클래스 경로를 지정해야 한다.

위에서 생성한 Spring Bean Configuration File을 활용하여 다른 .java파일에서 간단히 테스트를 진행해보면 환경설정 파일을 로딩하고 스프링 컨테이너를 구동하는 것을 확인해볼 수 있다.

```java
AbstractApplicationContext factory = new GenericXmlApplicationContext("applicationContext.xml");
```

> 환경설정 파일인 applicationContext.xml을 로딩하여 스프링 컨테이너 중 하나인 GenericXmlApplicationContext를 구동한다. 이는 콘솔 메시지에서도 확인할 수 있다.

중요한 것은 객체를 변경할 때 환경설정 파일만 수정하면 된다는 점이다.

#### Kinds

스프링에서는 BeanFactory와 이를 상속한 ApplicationContext 두 가지 유형의 컨테이너를 제공한다.

* **BeanFactroy**
  스프링 설정파일에 등록된 `<bean>` 객체를 생성하고 관리하는 가장 기본적인 컨테이너 기능만 제공한다.
  또한 컨테이너가 구동될 때 `<bean>` 객체를 생성하는 것이 아니라, 클라이언트의 요청에 의해서만 객체가 생성되는 **지연 로딩 방식**을 사용한다.
  따라서 일반적인 스프링 프로젝트에서는 사용할 일이 없다.
* **ApplicationContext**
  Beanfactory가 제공하는 `<bean>` 객체 관리 기능 외에도 트랜잭션 관리나 메시지 기반의 다국어 처리 등 다양한 기능을 지원한다.
  또한 컨테이너가 구동되는 시점에 `<bean>`에 등록된 클래스들을 객체 생성하는 **즉시 로딩 방식**으로 동작한다.
  그리고 웹 애플리케이션 개발도 지원하므로 대부분 스프링 프로젝트는 ApplicationContext 유형의 컨테이너를 이용한다.
  ApplicationContext의 구현 클래스 중 가장 많이 사용하는 클래스는 *GenericXmlApplicationContext*와 *XmlWebApplicationContext*이다.
  * **GenericXmlApplicationContext**
    파일 시스템이나 클래스 경로에 있는 XML 설정 파일을 로딩하여 구동하는 컨테이너
  * **XmlWebApplicationContext**
    웹 기반의 스프링 애플리케이션을 개발할 때 사용하는 컨테이너

#### Spring XML (Setting File)

스프링 컨테이너는 `<bean>` 저장소에 해당하는 XML 설정 파일을 참조하여 `<bean>`의 생명주기를 관리하고 여러 가지 서비스를 제공한다.
따라서 스프링 프로젝트 전체에서 가장 중요한 역할을 담당하며, 이 설정 파일을 정확하게 작성하고 관리하는 것이 중요하다.
설정 파일 이름은 무엇을 사용하든 상관없지만, `<beans>`를 루트 엘리먼트로 사용해야 한다.
`<beans>` 엘리먼트 시작 태그에 네임스페이스를 비롯한 XML 스키마 관련 정보가 설정된다.

`<bean>`, `<description>`, `<alias>`, `<import>` 등의 엘리먼트를 사용할 수 있지만 `<bean>`과 `<import>` 정도가 실제 프로젝트에 사용된다.

* `<bean>`
  스프링 설정 파일에 클래스를 등록할 때 사용한다.
  이때 id와 class 속성을 사용하는데, id 속성은 생략할 수 있지만 class 속성은 필수다.
  class 속성에 클래스를 등록할 때는 정확한 패키지 경로와 클래스 이름을 지정해야 한다.
  `<bean>` 객체를 위한 이름을 지정할 때 사용하는 속성이 id 속성이다. id 속성은 컨테이너로부터 객체를 요청할 때 사용하므로 반드시 스프링 컨테이너가 생성한 객체들 사이에서 유일해야 한다. 그래야 컨테이너가 각 객체를 식별할 수 있다. id 속성값에 해당하는 문자열은 *자바의 식별자 작성 규칙을 따르며, CamelCase를 사용한다.
  id와 같은 기능을 하는 속성이지만 자바 식별자 작성 규칙을 따르지 않는 것으로 id 속성 대신 name 속성이 존재한다. 역시 스프링 파일 내에서 유일해야 한다.

  * **init-method 속성**
    스프링 컨테이너는 Servlet 컨테이너와 마찬가지로 설정 파일에 등록된 클래스를 객체 생성할 때 디폴트 생성자를 호출한다.
    따라서 객체를 생성한 후에 멤버변수 초기화 작업이 필요하다면 `<bean>` 엘리먼트에 **init-method** 속성을 추가한다.

    ```xml
    <bean id="tv" class="package.class" init-method="initMethod"/>
    ```

    > 객체를 생성한 후에 init-method 속성으로 지정된 initMethod() 메소드를 호출한다. 여기서 초기화 작업을 처리한다.

  * **destroy-method 속성**
    init-method와 마찬가지로 `<bean>` 엘리먼트에서 destroy-method 속성을 이용하여 스프링 컨테이너가 객체를 삭제하기 직전에 호출될 메소드를 지정할 수 있다.

    ```xml
    <bean id="tv" class="package.class" destroy-method="destroyMethod"/>
    ```

    > 컨테이너가 종료되기 직전에 컨테이너는 자신이 관리하는 모든 객체를 삭제하는데, 이 때 호출된다.

  * **lazy-init 속성**
    ApplicationContext를 이용하여 컨테이너를 구동하면 컨테이너 구동 시점에 객체들을 생성하는 즉시 로딩 방식으로 동작한다.
    그런데 어떤 `<bean>` 은 자주 사용되지 않으면서 메모리를 많이 차지하여 시스템에 부담을 주는 경우도 있다.
    따라서 스프링에서는 컨테이너가 구동되는 시점이 아닌 해당 `<bean>` 이 사용되는 시점에 객체를 생성하도록 lazy-init 속성을 제공한다.

    ```xml
    <bean id="tv" class="package.class" lazy-init="true"/>
    ```

    > 해당 `<bean>`을 미리 생성하지 않고 클라이언트가 요청하는 시점에 생성한다. **결국 메모리 관리를 더 효율적으로 할 수 있게 된다.**

  * **scope 속성**
    프로그램 개발 중에 하나만 생성되도 상관없는 객체들이 있다.
    하나의 객체만 생성하여 유지하려면 가장 쉬운 방법은 객체를 생성하고 주소를 복사하여 재사용한다. 하지만 그렇게 개발하는 것은 거의 불가능에 가깝다.
    자연스럽게 하나의 객체만 생성하도록 제어하기위해 GoF 디자인 패턴 중 하나인 **Singletone Pattern**을 사용한다. 그러나 싱글톤 패턴을 구현하려면 일일이 클래스에 패턴 관련 코드를 작성해야 하므로 귀찮다.
    결국 클래스로부터 객체를 생성하는 쪽에서 자동으로 싱글톤 객체로 생성해주는 것이 가장 바람직하며 이 때 **scope** 속성을 사용한다.

    ```xml
    <bean id="tv" class="package.class" scope="singletone"/>
    ```

    > 해당 `<bean>`이 스프링 컨테이너에 의해서 단 하나만 생성되어 운용되도록 하며, 기본값이 singletone이다

    scope 속성 값이 "prototype"인 경우가 있는데, 이는 스프링 컨테이너가 매번 새로운 객체를 생성하여 반환하는 것이다.

* `<import>`
  스프링 설정 파일 하나에 모든 클래스를 등록하고 관리할 수도 있지만, 그렇게 하면 설정 파일이 너무 길어지고 관리도 어렵다.
  결국 기능별 여러 XML 파일로 나누어 설정하는 것이 더 효율적인데, 이렇게 분리하여 작성한 설정 파일들을 하나로 통합할때 사용한다.

  ```xml
  <beans>
      <import resource="context-database.xml"/>
      <import resource="context-transaction.xml"/>
  </beans>
  ```

  > `<import>` 태그를 이용하여 여러 스프링 설정 파일을 포함함으로써 한 파일에 작성하는 것과 같은 효과를 낼 수 있다.


## Dependency Injection

의존성(Dependency) 관계란 객체와 객체의 결합 관계이다.
즉, 하나의 객체에서 다른 객체의 변수나 메소드를 이용해야 한다면 이용하려는 객체에 대한 객체 생성과 생성된 객체의 레퍼런스 정보가 필요하다.

Spring F/W의 가장 중요한 특징은 객체의 생성과 의존관계를 컨테이너가 자동으로 관리한다는 점이다.
이러한 IoC를 Spring은 **Dependency Lookup**과 **Dependency Injection** 두 가지 형태로 지원한다.

* **Dependency Lookup**
  컨테이너가 애플리케이션 운용에 필요한 객체를 생성하고 클라이언트는 컨테이너가 생성한 객체를 검색(Lookup)하여 사용하는 방식이다.
  실제 애플리케이션 개발과정에서는 사용하지 않는다.

* **Dependency Injection**

  객체 사이의 의존관계를 스프링 설정 파일에 등록된 정보를 바탕으로 컨테이너가 자동으로 처리해준다.
  따라서 의존성 설정을 바꾸고 싶을 때 프로그램 코드를 수정하지 않고 스프링 설정 파일 수정만으로 변경사항을 적용할 수 있어 유지보수가 향상된다.
  Setter 메소드를 기반으로 하는 **Setter Injection**과 생성자를 기반으로 하는 **Constructor Injection**으로 나뉜다.

  * **Constructor Injection**
    스프링 컨테이너는 XML 설정 파일에 등록된 클래스를 찾아서 객체를 생성할 때 기본적으로 매개변수가 없는 기본(default) 생성자를 호출한다.
    하지만 다른 생성자를 호출하도록 설정할 수 있는데, 이를 이용하여 **Constructor Injection**을 처리한다.
    생성자 인젝션을 사용하면 생성자의 매개변수로 의존관계에 있는 객체의 주소 정보를 전달할 수 있다.
    생성자 인젝션을 위해서는 `<bean>` 등록 설정에서 시작 태그와 종료 태그 사이에 `<constructor-arg>` 엘리먼트를 추가한다.
    그리고 생성자 인자로 전달할 객체의 아이디를 `<constructor-arg>` 엘리먼트에 ref 속성으로 참조한다.

    ```xml
    <bean id="tv" class="package.class">
    	<constructor-arg ref="sony"></constructor-arg>
    </bean>
    <bean id="sony" class="package.class"></bean>
    ```

    스프링 컨테이너는 기본적으로 bean이 등록된 순서대로 객체를 생성하며, 모든 객체는 기본 생성자 호출을 원칙으로 한다.
    그런데 생성자 인젝션으로 의존성 주입될 sony가 먼저 객체생성되었으며, 해당 객체를 매개변수로 받아들이는 생성자를 호출하여 객체를 생성하였다.

    여러 개의 값을 매개변수로 전달하고자 한다면, `<constructor-arg>` 엘리먼트를 여러 개 추가한다.
    이 때 인자로 전달될 데이터가 `<bean>`으로 등록된 다른 객체일 때는 **ref 속성**을 이용하여 해당 객체의 아이디나 이름을 참조하지만, 고정된 문자열이나 정수 같은 기본형 데이터일 때는 **value 속성**을 사용한다.

    그런데 생성자가 여러 개 오버로딩 되어있다면 어떤 생성자를 호출해야 할지 분명하지 않을 수 있다.
    이를 위해 index 속성을 지원하며, **index 속성**을 이용하면 어떤 값이 몇 번째 매개변수로 매핑되는지 지정할 수 있다. index는 0부터 시작한다.

    ```xml
    <bean id="tv" class="package.class">
    	<constructor-arg index="0" ref="sony"></constructor-arg>
    	<constructor-arg index="1" value="27000000"></constructor-arg>
    </bean>
    <bean id="sony" class="package.class"></bean>
    ```

  * **Setter Injection**
    Setter 메소드를 호출하여 의존성 주입을 처리하는 방법이다.
    코딩 컨벤션에 따라 Setter/Constructor 둘 중 한 가지로 통일해서 사용하는데 대부분은 Setter를 사용한다. Setter 메소드가 제공되지 않는 클래스에 대해서만 Constructor Injection을 사용한다.

    Setter 메소드는 스프링 컨테이너가 자동으로 호출하며, 호출하는 시점은 `<bean>` 객체 생성 직후이다. 따라서, Setter Injection이 동작하려면 Setter 메소드뿐만 아니라 기본 생성자도 반드시 필요하다.
    Setter 인젝션을 위해서는 `<constructor-arg>` 엘리먼트 대신 `<property>` 엘리먼트를 사용한다.

    ```xml
    <bean id="tv" class="package.class">
    	<property name="speaker" ref="sony"></constructor-arg>
    	<property name="price" value="27000000"></constructor-arg>
    </bean>
    <bean id="sony" class="package.class"></bean>
    ```

    > name 속성값이 호출하고자 하는 메소드 이름이다. 즉, name 속성값이 speaker라면 호출되는 메소드는 setSpeaker()이다.
    > 생성자 인젝션과 마찬가지로 다른 `<bean>` 객체를 넘기려면 ref 속성을, 기본형 데이터를 넘기려면 value 속성을 사용한다.

    * **p Namespace**
      Setter Injection을 설정할 때, p 네임스페이스를 이용하면 더 효율적으로 의존성 주입을 처리할 수 있다.
      p 네임스페이스는 네임스페이스에 대한 별도의 schemaLocation이 없어서 네임스페이스만 적절히 선언하고 사용할 수 있다.
      p 네임스페이스는 다음과 같이 사용한다.

      ```xml
      <bean id="tv" class="package.class" p:speaker-ref="sony" p:price="2700000"/>
      <bean id="sony" class="package.class"/>
      ```

      > **p:변수명-ref="참조할 객체의 이름이나 아이디"**와 같은 형태로 참조형 변수에 참조할 객체를 할당하고
      > **p:변수명="설정할 값"**과 같은 형태로 기본형이나 문자형 변수에 직접 값을 설정한다.

      STS 기능을 이용하면, 스프링 설정 파일에서 [Namespace] 탭을 선택하고 p 네임스페이스를 체크하면 `<beans>` 엘리먼트에 자동으로 추가된다.

    * **Collection 객체 설정**
      배열이나 List 같은 컬렉션 객체를 매핑하는 엘리먼트가 존재한다.
      java.util.List나 배열은 `<list>`, java.util.Set은 `<set>`, java.util.Map은 `<map>`, java.util.Properties는 `<props>`로 사용한다.
      스프링 설정 파일에 다음과 같이 `<bean>`을 등록한다.

      * List 타입

        ```xml
        <bean id="tv" class="package.class">
            <property name="list">
            	<list>
                	<value>값1</value>
                    <value>값2</value>
                </list>
            </property>
        </bean>
        ```

        > 두 개의 문자열 주소가 저장된 List 객체를 setList() 메소드를 호출할 때, 인자로 전달하여 list멤버변수를 초기화하는 설정이다.

      * Set 타입

        ```xml
        <bean id="tv" class="package.class">
            <property name="list">
    			<set value-type="java.lang.String">
                	<value>값1</value>
                    <value>값2</value>
                    <value>값1</value>
                </set>
            </property>
        </bean>
        ```
        
        > Set 컬렉션에서는 같은 데이터를 중복해서 저장하지 않으므로 "값1"이라는 데이터는 하나만 저장된다.
        
      * Map 타입
      
        ```xml
        <bean id="tv" class="package.class">
            <property name="list">
                <map>
                	<entry>
                    	<key><value>키1</value></key>
                        <value>값1</value>
                    </entry>
                    <entry>
                    	<key><value>키2</value></key>
                        <value>값2</value>
                    </entry>
                </map>
            </property>
        </bean>
        ```
      
      * Properties 타입
      
        ```xml
        <bean id="tv" class="package.class">
            <property name="list">
        		<props>
                	<prop key="키1">값1</prop>
                    <prop key="키2">값2</prop>
                </props>
            </property>
        </bean>
        ```
      

## Annotation-based Configuration

대부분의 프레임워크가 그렇듯 Spring F/W 역시 XML 설정이 매우 중요하다.
그만큼 XML 파일의 과도한 설정에 대한 부담도 크며, 이로 인해 프레임워크 사용을 꺼리기도 한다.

**Context Namespace 추가**
어노테이션 설정을 추가하려면 스프링 설정 파일의 루트 엘리먼트인 `<beans>`에 Context 관련 네임스페이스와 스키마 문서의 위치를 등록해야 한다.
이는 p 네임스페이스를 추가했을 때처럼 Namespace 탭을 선택하고 context 항목만 체크하면 추가할 수 있다.

**Component-scan 설정**
스프링 설정파일에 애플리케이션에서 사용할 객체들을 `<bean>`등록하지 않고 자동으로 생성하려면 `<context:component-scan/>`을 정의해야 한다.
이 설정을 추가하면 스프링 컨테이너는 클래스 패스에 있는 클래스들을 스캔하여 **@Component**가 설정된 클래스들을 자동으로 객체 생성한다.
중요한 것은 해당 엘리먼트의 base-package 속성인데, `com.springbook.biz`형태로 지정하면 해당 패키지로 시작하는 모든 패키지를 스캔대상에 포함한다.

**@Component**
Component-scan을 설정했으면 스프링 설정 파일에 클래스들을 일일이 `<bean>` 엘리먼트로 등록할 필요가 없다.
클래스 선언부 위에 @Component만 설정하면 된다.
당연히 <u>해당 클래스에 기본 생성자가 있어야만 컨테이너가 객체를 생성</u>할 수 있다.
또, 클라이언트가 스프링 컨테이너가 생성한 객체를 요청하려면 요청할 때 사용할 아이디나 이름이 반드시 설정되어 있어야 한다.
`@Component("tv")`와 같이 사용한다. 만약 id나 name속성을 지정하지 않았다면, <u>컨테이너가 자동으로 이름을 설정</u>한다.
자동으로 설정하는 이름 규칙은 <u>클래스 이름의 첫 글자를 소문자로 변경</u>하기만 하면 된다.

**Dependency Injection Annotation**
스프링에서는 @Autowired와 @Qualifier를 제공하지만, 나머지는 제공하지 않는다.

* **@Autowired**
  생성자나 메소드, 멤버변수 위에 모두 사용할 수 있다. <u>대부분은 멤버변수 위에 선언하여 사용</u>한다.
  스프링 컨테이너는 멤버변수 위의 `@Autowired`를 확인하는 순간 **해당 변수의 타입을 체크**한다. 해당 타입의 객체가 메모리에 존재하는지를 확인한 후에, 객체를 변수에 주입한다. 만약 `@Autowired`가 붙은 객체가 메모리에 없다면 컨테이너가 `NoSuchBeanDefinitionException`을 발생시킨다.
  해당 객체를 `<bean>`선언하는 XML 방법이나 `@Component`를 붙이는 Annotation 방법을 활용하여 메모리에 객체를 생성해놔야 한다.
  어떤 방법을 사용하든 해당 객체가 메모리에 생성만 되면 `@Autowired`에 의해서 컨테이너가 객체를 변수에 자동으로 할당한다.
* **@Qualifier**
  동일한 타입의 객체가 두 개 이상일 때 `@Autowired`를 사용하면 `NoUniqueBeanDefinitionException`이 발생한다.
  이러한 경우 `@Autowired`와 함께 `@Qualifier`를 사용하면된다. `@Qualifier`를 이용하면 의존성 주입될 객체의 `id`나 `name`을 지정할 수 잇는데, 이 때 객체의 이름중 하나를 지정하면 간단하게 처리할 수 있다.
* **@Resource**
  변수의 타입을 기준으로 객체를 검색하여 의존성 주입을 처리하는 `@Autowired`와 다르게 `@Resource`는 객체의 이름을 이용하여 의존성 주입을 처리한다.
  `name`속성을 사용할 수 있어서, 스프링 컨테이너가 해당 이름으로 생성된 객체를 검색하여 의존성 주입을 처리한다.

**Annotation과 XML 설정 병행사용**
XML 설정은 Java Source를 수정하지 않고 XML 파일의 설정만 변경하면 실행되는 객체를 교체할 수 있어서 유지보수가 편하다. 하지만 Java Source에 의존관계와 관련된 어떤 메타데이터도 없으므로 XML 설정을 해석해야만 무슨 객체가 의존성 주입되는지를 확인할 수 있다는 부담이 있다.
반면 Annotation 설정은 XML 설정에 대한 부담도 없고 의존관계에 대한 정보가 Java Source에 들어있어서 사용하기는 편하다. 하지만 의존성 주입할 객체의 이름이 Java Source에 명시되어야 하므로 Source를 수정하지 않고 객체를 교체할 수 없다는 문제가 생긴다.
이런 문제를 서로의 장점을 조합하는 것으로 해결할 수 있다.
@Autowired로 할당받을 객체를 @Component를 사용하지 않고 `<bean>`을 사용하는 것이다. 이러한 경우 객체를 변경하고자 할 때 Java Source는 수정하지 않고 XML 수정만으로 객체를 교체할 수 있다.
또한 우리가 직접 개발한 클래스는 Annotation, XML 둘 다 사용할 수 있지만, 라이브러리 형태로 제공되는 클래스는 반드시 XML 설정을 통해서만 사용할 수 있다.

**추가 어노테이션**
사용자의 요청을 제어하는 Controller Class, 비즈니스 로직을 처리하는 ServiceImpl Class, 데이터베이스 연동을 담당하는 DAO Class
이러한 시스템을 구성하는 모든 Class에 @Component를 할당하면 어떤 클래스가 어떤 역할을 수행하는지 파악하기 어렵다.
Spring F/W에서는 이런 클래스들을 분류하기 위해 @Component를 상속하여 다음 세 개의 어노테이션을 추가로 제공한다.

* @Service
  ServiceImpl Class에 할당하며 비즈니스 로직을 처리하는 Service Class임을 의미한다.
* @Repository
  DAO Class에 할당하며 데이터베이스 연동을 처리하는 DAO Class임을 의미한다.
  DB 연동 과정에서 발생하는 예외를 변환해주는 특별한 기능이 추가되어 있다.
* @Controller
  Controller Class에 할당하며 사용자 요청을 제어하는 Controller Class임을 의미한다.
  MVC 아키텍처에서 해당 객체를 Controller 객체로 인식하도록 해준다.

## Example

비즈니스 컴포넌트에 대한 실습으로 Spring Quick Start 책의 p.109 ~ p.139 에 서술되어있다.
예제 실습들이므로 해당 문서에서는 자세하게 다루지 않으나 생각해야할 부분을 작성해본다.

**폴더 구조**
프로젝트마다 조금씩 다르겠지만 일반적으로 비즈니스 컴포넌트는 4개의 Java 파일로 구성된다.
책에서 사용한 방식을 예로 들어 설명하면, `/src/main/java`에 `com.springbook.biz.board`패키지와 `com.springbook.biz.board.impl`패키지가 존재하며 각각의 패키지에는 `BoardService.java`, `BoardVO.java`와 `BoardDAO.java`, `BoardServiceImpl.java`가 포함되어 있다. 그리고 `/src/test/java`의 `com.springbook.biz.board`패키지에 `BoardServiceClient.java`가 존재한다.

```bash
└── src
    ├── main
    	└── java
    		├── com.springbook.biz.board
    			├── BoardService.java
    			└── BoardVO.java
    		└── com.springbook.biz.board.impl
    			├── BoardServiceImpl.java
    			└── BoardDAO.java
    └── test
    	└── java
    		└── com.springbook.biz.board
    			└── BoardServiceClient.java
```

------

# Footnote

- ***POJO**
  Plain Old Java Object란 말 그대로 옛날 자바 객체를 의미한다. 우리 마음대로 만들 수 있는 클래스.
  반대로 Not POJO클래스가 Servlet 클래스이다. Servlet 클래스는 우리 마음대로 만들 수 없으며, 요구하는 규칙에 맞게 만들어야 실행할 수 있다.

- ***낮은 결합도**
  비즈니스 컴포넌트를 개발할 때, 항상 신경쓰는 것이 낮은 결합도와 높은 응집도이다.
  결합도를 낮추는 방법은 상속과 Overriding, 형변환의 다형성을 이용하는 방법과 Factory 패턴 등의 디자인 패턴을 이용하는 방법이 있다.

* ***자바의 식별자 작성 규칙**
  숫자로 시작하거나 공백이 포함되어 있거나 특수기호를 사용하는 경우 문제가 발생한다.