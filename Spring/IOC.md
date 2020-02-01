# IoC

> IoC : Inversion of Control
>
> 제어의 역전이란, 어떠한 일을  하도록 만들어진 프레임워크에 제어의 권한을 넘김으로써 클라이언트 코드가 신경 써야 할 것을 줄이는 개념

* IoC 가 적용되기 전에는 객체의 생성이나 객체 사이의 의존관계를 개발자가 직접 자바 코드로 처리했다. 이런 상황에서는 의존관계에 있는 객체를 변경할 때, 반드시 자바 코드를 수정해야한다.
* IoC가 적용되면 객체 생성을 자바 코드로 직접 처리하는 것이 아닌 컨테이너가 대신 처리하기 때문에 객체 사이의 의존 관계 역시 컨테이너가 처리한다.
  * 소스에 의존관계가 명시되지 않으므로 결합도가 떨어져서 유지보수가 편리해진다.

### Container

> 특정 객체의 생성과 관리를 담당하며 객체 운용에 필요한 다양한 기능을 제공
>
> 일반적으로 서버 안에 포함되어 배포 및 구동

* 자신이 관리할 클래스들이 등록된 XML 설정 파일을 로딩하여 구동한다.
  * 요청이 들어오는 순간 XML 설정 파일을 참조하여 객체를 생성하고, 생명주기를 관리한다.

### High Coupling Program Example

1. 서로 다른 두 개의 TV 클래스가 있을 때, 각 클래스의 메소드 역할은 같으나 이름이 다를 수 있다.
   * 다른 클래스를 사용하기 위해선 사용한 메소드 이름을 전부 변경해줘야 한다.
2. 결합도를 낮추기 위한 방법중 하나인 다형성(Polymorphism)을 이용한다.
   * TV 라는 인터페이스를 만든 후 TV를 상속받는 서로 다른 두 개의 TV 클래스를 만든다.
   * 이 때 인터페이스 TV에는 공통으로 가져야 할 메소드를 추상 메소드로 선언한다
   * TV 인터페이스 타입의 변수로 서로 다른 두 개의 TV를 변수로 가지면 다른 TV로 객체를 변경할 때 참조하는 객체만 변경하면 되므로 객체를 쉽게 교체할 수 있다.
   * 위의 첫 번째 방법보다 결합도가 낮아지며 유지보수가 좀 더 편해진다.
   * [Multi TV Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/MultiTV.java), [Other TV Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/OtherTV.java), [TV Interface Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/TV.java), [TV Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/Main.java)
3. 두 번째 방법에서도 결국 TV를 변경하고자 하면 객체를 생성하는 소스를 변경해야 한다. 여기서 유지보수를 더욱 편하게 하기 위해 디자인 패턴을 이용한다.
   * Factory 패턴을 적용한다. 객체 생성을 캡슐화 하여 TV Main과 TV사이를 느슨한 결합 상태로 만들어준다.
   * TV 객체를 생성할 때 TVFactory 클래스를 이용하여 생성하도록 한다.
   * [TV Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/Main.java), [TV Factory Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/nonspring/TVFactory.java)
     * 실행할 떄 Run Configurations의 Arguments을 이용하여 매개변수를 전달해줘야한다.

#### Spring IoC

> Example로 사용한 TV Class에 Spring IoC를 적용시켜 낮은 결합도가 되도록 변경해본다.

1. **Spring Bean Configuration File을 생성한다.**

   * 기본으로 `<beans>` 루트 Element와 Namespace관련 설정들이 추가되어 제공된다.

   * 객체로 생성할 클래스 하나당 하나의 `<bean>` 설정이 필요하다. (`<beans>` 태그 내부에 입력한다.)

     ```xml
     <beans {Basic Setting}>
     	<bean id="tv" class="{packagename}.MultiTV"/>
     	<bean id="tv2" class="{packagename}.OtherTV"/>
     </beans>
     ```

     * 가장 중요한 것은 `class`속성값이다. 패키지 경로가 포함된 전체 클래스 경로를 지정해야 한다.
       STS기능을 이용하여 Ctrl + Space를 누르면 자동완성 기능을 이용할 수 있다.

     [TV XML Codes](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/tvspring/TV.xml)

   * `<beans>` 내부에 `<import>`를 사용하여 다른 xml파일을 통합할 수 있다. (resource 속성을 이용)

   * `<bean>`의 id값은 자바의 식별자 작성 규칙을 따르며, 일반적으로 **낙타표기법**을 사용한다.

     * 숫자로 시작하거나, 공백이 포함되어 있거나, 특수기호를 사용하면 에러가 발생한다.
     * id와 같은 기능으로 name속성이 존재한다. name은 규칙을 따르지 않는다.

   * `init-method="{initMethod}"`를 속성에 추가하면 객체가 생성된 이후에 메소드를 호출한다.

     * `{initMethod}()`를 클래스 내부의 메소드로 선언해두어야 한다.

   * `destroy-method="{destroyMethod}"`를 속성에 추가하면 객체가 삭제될 때 메소드를 호출한다.

     * 컨테이너가 종료되기 직전에 컨테이너는 자신이 관리하는 모든 객체를 삭제한다.

   * ApplicationContext를 이용하면 컨테이너가 구동되는 시점에 설정파일에 등록된 `<bean>`들을 생성하는 **즉시 로딩 방식**으로 동작한다.

     * 즉시 로딩 방식이 아닌 `<bean>`이 사용되는 시점에 객체를 생성하도록 `lazy-init="true"` 속성을 `<bean>`에 추가할 수 있다.

   * `<bean>`을 사용하여 만들어진 객체는 같은 이름, 같은 타입일 경우 1개만 생성된다. 이후에 호출되는 `<bean>`은 이미 생성된 객체를 리턴하여 공유한다.

     * 이는 `scope` 속성의 default값이 `singleton`이기 때문이다. 값을 `prototype`으로 변경하면 `<bean>`이 요청될 때마다 새로운 객체를 생성하여 반환한다.

2. **TV Main Class의 코드를 변경한다.**

   * Spring Container를 구동한다.

     ```java
     ApplicationContext container = new ClassPathXmlApplicationContext("{packagename}/tv.xml");
     ```

     * 환경설정 파일인 tv.xml을 로딩하여 Spring Container중 하나인 ClassPathXmlApplicationContext를 구동했다.

   * `getBean()` 메소드를 이용하여 xml에서 id를 tv로 설정한 객체를 요청한다.

     ```java
     TV tv = container.getBean("tv", TV.class);
     ```

   * TV Main을 수정하지 않아도 동작하는 TV를 변경할 수 있으며 Factory를 사용했던 것보다 유지보수가 좀 더 편해졌다.

   [TV Main Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/tvspring/Main.java), 이외의 TV들의 코드는 위와 동일하며 패키지만 변경하면 된다.