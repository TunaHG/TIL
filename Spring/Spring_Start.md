# Spring Start

강사 조성희 : bluejeansh@hanmail.net

## Feature

1. Spring AOP, Spring Web, Spring Web MVC, Spring Context, Spring ORM, Spring DAO, Spring Core로 이루어진 Spring에서 mybatis로 대체된 ORM과 DAO를 제외한 나머지를 학습한다.
2. 여러가지 모듈단위
3. Class A extends HTTPServlet
   Class B : main class 실행 / 서블릿 실행 / 안드로이드 앱 실행 = plain old java object (pojo)
4. Spring 이전 개발 자바 객체를 그대로 사용 가능
5. Spring Core - ID

### IOC 기능 지원

> IOC : Inversion of Control

```java
interface B{}
class C implements B{}
class D implements B{}

class A {
    // B b1 = new B();
    B b1;
    A(B b1){
        this.b1 = b1;
    }
    setB(B b1){
        this.b1 = b1;
    }
}
```

* IOC란, 객체를 생성하는 방법을 의미한다.

#### DI

> DI : Dependency Injection

* IOC중 new를 사용하지 않는 생성자와 setter를 사용하는 방법을 의미한다.

## Setting

* JDK와 Eclipse가 설치되어 있는 상태에서 진행한다.

* 설치된 Eclipse에서 Help - Eclipse Marketplace에서 sts검색, Spring Tools 3 (Standalone Edition)을 install

* File - New - Project에 Spring폴더가 있고 내부에 Spring Legacy Project가 존재하면 성공

## Start

* File - New - Project에서 Spring Legacy Project 생성
* Next를 누르면 경고창이 하나 뜨는데, Yes 선택
* Specify Top-level package와 같은 창이 뜬다.
  * 이 창에선 a.b.c와 같은 형식으로 작성하면 된다.
  * WebContext를 의미한다.

* 생성된 Project의 pom.xml을 열어서 Line 11의 Java-version을 내 JDK 버전으로 변경하고, Line 12의 SpringFramework-version을 4.3.18로 변경한후 저장한다.
  * Project의 Maven Dependencies의 spring버전이 4.3.18로 변경되었는지 확인한다.
  * Project에서 우클릭후 Properties - Java Build Path - Libraries의 JRE Library를 더블클릭하여 1.6에서 1.8로 변경한다. (Apply 클릭)
  * Properties - Project Facets에서 Java의 버전을 1.6에서 1.8로 변경
  * Properties - Project Facets에서 우측 Runtimes에서 Tomcat 8.5 체크