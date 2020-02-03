# Annotation

> Annotation은 xml파일의 과도한 설정에 대한 부담을 줄여준다.

* Annotation을 사용한다고 하여 xml의 설정파일에 `<bean>` 등의 기존에 사용하던 설정을 사용할 수 없는 것은 아니다. **두 개를 병행하여 사용할 수있다.**

## XML Setting

* xml 설정 파일의 아래 Namespaces 탭에서 **Context**를 체크한 후 진행한다.

  * 다음과 같은 코드가 `<beans>`에 추가된다.

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans"
    	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    	xmlns:context="http://www.springframework.org/schema/context"
    	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
    		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
                            http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-4.3.xsd">
    </beans>
    ```

  * `xmlns:context`가 추가된것을 확인할 수 있다.

* 이후 `<beans>`내부에 `@Component`와 같은 **Annotation**을 사용할 수 있게 해주는 Component-scan을 선언해야한다.

  ```xml
  <context:component-scan base-package="{packageName}"/>
  ```

  * xml 설정 파일이 들어있는 package의 경로를 입력한다.

* Codes

  [XML File](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/empspring/emp.xml)

## @

### @Component

> `<bean>` Element 대신 사용하는 **Annotation**

* Class 선언부 위에 설정한다.

* `<bean>`의 id를 입력해줄수 있다. (`@Component("{id}")`)

* id를 입력해주지 않으면 Class 이름의 첫글자를 소문자로 변경한 문자열이 id가 된다.

  * MultiTV가 Class 이름이라면 id는 multiTV가 된다.

* Codes

  [VO Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/empspring/EmpVO.java)

### @Autowired

> 생성자나 메소드, 멤버변수 위에 사용하는 **Annotation**

* 대부분 멤버변수 위에 선언하여 사용한다.

* 변수 위에 붙은 `@Autowired`를 확인하는 순간 해당 변수의 타입을 체크하여
  해당 타입의 객체가 메모리에 존재하면, 그 객체를 변수에 주입한다.

* `@Autowired`가 붙은 객체가 메모리에 없다면 `NoSuchBeanDefinitionException`이 발생한다.

* 의존성 주입(DI)에 사용던 Setter 메소드나 생성자는 필요없다.

* Codes

  [DAO Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/empspring/EmpDAO.java)

### @Qualifier

> 의존성 주입 대상이 되는 특정 타입의 객체가 두 개 이상일 때 사용하는 **Annotation**
>
> 예를 들어, TV 인터페이스를 상속하는 MultiTV와 OtherTV의 경우 TV라는 변수에 `@Autowired`를 설정하면 두 개의 TV Class중 어떤 TV Class를 주입할지 몰라서 에러가 발생한다.

* 의존성 주입될 객체의 아이디나 이름을 가지고 변수 위에 선언한다.

  ```java
  @Autowired
  @Qualifier("multi")
  private TV tv;
  ```

### @Resource

> 변수의 타입을 기준으로 객체를 검색하여 의존성 주입(DI)을 처리하는 `@Autowired`와 다르게 객체의 이름을 이용하여 의존성 주입을 처리할 때 사용하는 **Annotation**

* name속성을 사용하여 해당 이름으로 생성된 객체를 검색한다.

  ```java
  @Resource(name="multi")
  private TV tv;
  ```

* `@Inject`와 동일한 기능을 가지고 있다.

### @Repository

> 데이터베이스 연동을 처리하는 DAO Class에서 사용하는 **Annotation**

* Class 선언부 위에 설정한다.

* `@Component`를 상속한다.

* DB연동 과정에서 발생하는 예외를 변환해주는 기능이 있다.

* Codes

  [DAO Codes](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/empspring/EmpDAO.java)

### @Service

> 비즈니스 로직을 처리하는 Service Class에서 사용하는 **Annotation**

* Class 선언부 위에 설정한다.

* `@Component`를 상속한다.

* Argument로 id를 입력한다. (`@Service("{id}")`)

* Codes

  [Service Code](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/annotation/servicespring/ProductServiceNo.java)

### @Controller

> 사용자 요청을 제어하는 Controller Class에서 사용하는 **Annotation**

* Class 선언부 위에 설정한다.
* `@Component`를 상속한다.
* 해당 객체를 MVC 아키텍처에서 컨트롤러 객체로 인식하게 해준다.

