# IOC

> IOC : Inversion of Control
>
> 제어의 역전이란, 어떠한 일을  하도록 만들어진 프레임워크에 제어의 권한을 넘김으로써 클라이언트 코드가 신경 써야 할 것을 줄이는 개념

* 소스에서 객체 생성과 의존관계에 대한 코드가 사라져 낮은 결합도의 컴포넌트를 구현할 수 있다.

## 기존에 사용하던 객체 생성 방법

### New 사용

```java
class A{
    B b1 = new B();
}
```

### 생성자 사용

```java
class A{
    B b1;
    A(B b1){
        this.b1 = b1;
    }
}
```

### setter 메소드 사용

```java
class A{
    B b1;
    public void setB(B b1){
        this.b1 = b1;
    }
}
```

## DI

> DI : Dependency Injection
>
> IOC를 적용하는 프로그래밍 방식

### Contructor



### Setter

외부(스프링)로부터 만들어진 객체를 전달받자.

`<bean>`가 객체를 만들고 `<property>`가 setter메소드를 호출한다.



IOC, DI >> 스프링 내부 규칙

1. 같은이름, 같은 타입의 객체는 1개만 생성 - 이후엔 만들어진 객체를 리턴해서 공유
2. 스프링 공장, 생성되어진 객체만 전달받는다. - XML파일에 설정된 것
3. 스프링 규칙대로 강제적 사용
4. 객체생성 <bean>, setter 호출 <property>
   1. <property>에서 인자의 값을 받아올 때는 value를 사용, 객체를 받아올 때는 ref를 사용한다.
      나중엔 value를 form으로 받을것이기 때문에 property를 사용하지 않는다.
   2. <property>의 id부분은 setter메소드를 찾아내는 방법임. setProductVO를 가져오려면 productVO가 되어야함.

스프링 설정파일 > XML

1. @ annotation 
   1. DAO >> `@Repository("dao")` = `<bean id="dao" class="xxx.DAO">`
      `@Repository` >> 이름이 없다면 Class랑 같은 이름(EmpDAO라면 empDAO로 입력된다.)
      `@Repository`가 `<bean>`과 같은 역할을 수행한다.
      Class위에 붙여준다. >> DAO Class에 권장
   2. `@Component` = `@Repository` >> 모든 Class에 권장
   3. `@Autowired` : 변수 선언시 Annotation한다.
      EmpVO로 생성된 객체를 찾아서 가져온다. 변수위에 붙여준다. 객체를 변수로 가질때만 사용가능함
      
   4. EmpVO와 같이 전달받을 값이 있으면 `<bean>`을 사용해야 한다.





VO, DAO, Service

VO : 값 임시 저장소

DAO : 값 접근 객체, 1개 SQL 실행 단위 = 1개 Method

Service : 1개 기능 단위



회원가입

0. select id
1. insert(EmpVO vo) sql