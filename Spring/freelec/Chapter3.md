# Chapter 3

>   Using Database with JPA in Spring boot

iBatis, MyBatis는 ORM이 아니다. SQL Mapper이다.
ORM은 Object Relational Mapping으로 객체를 매핑하는 것이고, SQL Mapper는 Query를 매핑한다.

## JPA

현대의 웹 애플리케이션에서 관계형 데이터베이스(RDB)는 빠질 수 없는 요소이다.
그러다보니 객체를 관계형 데이터베이스에서 관리하는 것이 무엇보다 중요하다.
관계형 데이터베이스가 SQL만 인식할 수 있기 때문에, 각 테이블마다 기본적인 CRUD SQL을 매번 생성해야 한다. 그렇다보니 현업 프로젝트 대부분이 **애플리케이션 코드보다 SQL로 가득**하게 되었다.
이러한 단순 반복 작업의 문제 이외에도 **패러다임 불일치** 문제가 있다. 관계형 데이터베이스는 어떻게 데이터를 저장할지에 초점을 맞춘 기술이다. 반대로 객체지향 프로그래밍 언어는 메시지를 기반으로 기능과 속성을 한 곳에서 관리하는 기술이다. 이렇듯 관계형 데이터베이스와 객체지향 프로그래밍 언어의 패러다임이 서로 다른데, 객체를 데이터베이스에 저장하려고 하니 문제가 발생한다.

JPA는 이런 문제를 해결하기 위해 등장했다.
서로 지향하는 바가 다른 2개 영역에 대해 중간에서 패러다임을 일치시켜주기 위한 기술이다. 즉, 개발자는 객체지향적으로 프로그래밍을 하고 JPA가 이를 관계형 데이터베이스에 맞게 SQL을 대신 생성해서 실행한다. 개발자는 이제 더는 SQL에 종속적인 개발을 하지 않아도 된다.
객체 중심으로 개발하게 되니 생산성 향상을 물론 유지보수하기가 편해진다.

### Spring Data JPA

JPA는 인터페이스로서 자바 표준명세서다. 인터페이스인 JPA를 사용하기 위해서는 구현체가 필요하다.
대표적으로 Hibernate, Eclipse, Link 등이 있는데, Spring에서는 이 구현체들을 직접 다루지 않는다.
구현체들을 좀 더 쉽게 사용하고자 추상화시킨 Spring Data JPA라는 모듈을 이용하여 JPA 기술을 다룬다. 이들의 관계를 살펴보면 JPA를 위해 Hibernate를 사용하고 거기에 한 단계 더 나아가서 Spring Data JPA를 사용한다. Hibernate를 쓰는 것과 Spring Data JPA를 사용하는 것에는 큰 차이가 없다.
그럼에도 **Spring Data JPA가 등장한 이유**는 크게 두 가지다.

*   **구현체 교체의 용이성**
    Hibernate 외에 다른 구현체로 쉽게 교체할 수 있다.
    Hibernate가 언젠가 수명을 다해서 새로운 JPA 구현체가 대세로 떠오를 때, Spring Data JPA를 사용중이라면 쉽게 교체할 수 있다.
    Spring Data JPA 내부에서 구현체 매핑을 지원해주기 때문이다.
*   **저장소 교체의 용이성**
    관계형 데이터베이스 외에 다른 저장소로 쉽게 교체할 수 있다.
    트래픽이 많아지면 관계형 데이터베이스로는 감당이 안될 때가 올 수 있다. 이러한 경우 MongoDB로 교체가 필요하다면 개발자는 Spring Data JPA에서 Spring Data MongoDB로 의존성만 교체해주면 된다. 이는 Spring Data의 하위 프로젝트들은 기본적인 CRUD의 인터페이스가 같기 때문이다. `save()`, `findAll()` 등을 인터페이스로 동일하게 가지고 있다.

### 실무에서 JPA

실무에서 JPA를 사용하지 못하는 가장 큰 이유로 높은 러닝 커브를 이야기한다. JPA를 잘 쓰려면 객체지향 프로그래밍과 관계형 데이터베이스를 둘 다 이해해야 한다.
하지만 그만큼 보상도 크다. CRUD 쿼리를 직접 작성할 필요가 없고, 부모-자식 관계표현, 1:N 관계표현, 상태와 행위를 한곳에서 관리하는 등 객체지향 프로그래밍을 쉽게 할 수 있다.
JPA에서는 또한 여러 성능 이슈 해결책들을 이미 준비해놓은 상태이기 때문에 이를 잘 활용하면 네이티브 쿼리만큼의 퍼포먼스를 낼 수 있다.

### 요구사항 분석

앞으로 Chapter 3부터 Chapter 6까지 하나의 웹 애플리케이션을 만들어보고 Chapter 7부터 Chapter 10까지 이 서비스를 AWS에 무중단 배포한다.
이 웹 애플리케이션의 요구사항은 다음과 같다.

*   게시판 기능
    *   게시글 조회
    *   게시글 등록
    *   게시글 수정
    *   게시글 삭제
*   회원 기능
    *   구글 / 네이버 로그인
    *   로그인한 사용자 글 작성 권한
    *   본인 작성 글에 대한 권한 관리

## Applying Spring Data JPA to the project

먼저 build.gradle에 JPA와 H2 database의 의존성들을 등록한다.

```
implementation('org.springframework.boot:spring-boot-starter-data-jpa')
implementation('com.h2database:h2')
```

>   build.gradle의 dependencies에 위의 코드를 추가한다.
>
>   Spring-boot-starter-data-jpa는 스프링 부트용 Spring Data JPA 추상화 라이브러리이다. 스프링 부트 버전에 맞춰 자동으로 JPA 관련 라이브러리들의 버전을 관리해준다.
>
>   h2는 In-Memory 관계형 데이터베이스이다. 별도의 설치가 필요없이 프로젝트 의존성만으로 관리할 수 있다. 메모리에서 실행되기 때문에 애플리케이션을 재시작할 때마다 초기화된다는점을 이용하여 테스트 용도로 많이 사용된다.

의존성이 등록되었다면, 맨 처음 만들었던 `com.tunahg.book.springboot`아래에 `domain`패키지를 추가한다.
이 domain 패키지는 [**도메인*](#Footnote)을 담을 패키지다. 기존에 Mybatis와 같은 쿼리 매퍼를 사용했다면 DAO 패키지를 떠올리겠지만 DAO와는 조금 다르다. 그간 XML에 쿼리를 담고 클래스는 오로지 쿼리의 결과만 담던 일들이 모두 도메인 클래스에서 해결된다.
**domain 패키지에 posts 패키지와 Posts 클래스**를 만든다. Posts 클래스의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.domain.posts;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class Posts {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(length = 500, nullable = false)
    private String title;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String content;
    
    private String author;
    
    @Builder
    public Posts(String title, String content, String author) {
        this.title = title;
        this.content = content;
        this.author = author;
    }
}
```

>   @Entity는 테이블과 링크될 클래스임을 나타낸다. 기본값으로 클래스의 카멜케이스 이름을 언더스코어 네이밍으로 테이블 이름을 매칭한다.
>   Ex) SalesManager.java -> sales_manager table
>
>   @Id는 해당 테이블의 PK 필드를 나타낸다. 웬만하면 Entity의 PK는 Long 타입의 Auto_increment를 추천한다. (MySQL 기준으로 이렇게하면 bigint 타입이 된다) [**그이유*](#Footnote)
>
>   @GeneratedValue는 PK의 생성규칙을 나타낸다. 스프링 부트 2.0에서는 GenrationType.IDENTITY를 추가해야만 auto_increment가 된다.
>
>   @Column은 테이블의 칼럼을 나타내며 굳이 선언하지 않더라도 해당 클래스의 필드는 모두 칼럼이 된다. 사용하는 이유는 기본값 외에 추가로 변경이 필요한 옵션이 있으면 사용한다. 문자열의 경우 VARCHAR(255)가 기본값인데, 사이즈를 500으로 늘리고싶거나 타입을 TEXT로 변경하고 싶은 등의 경우에 사용된다.

어노테이션 순서를 **주요 어노테이션을 클래스에 가깝게 둔다.**
@Entity는 JPA의 어노테이션이며, @Getter와 @NoArgsConstructor는 Lombok의 어노테이션이다.
Lombok은 코드를 단순화시켜주지만 필수 어노테이션은 아니다. 그러다보니 주요 어노테이션인 @Entity를 클래스에 가깝게 두고 Lombok 어노테이션을 그 위로 두었다. 이렇게하면 이후 코틀린 등의 새 언어 전환으로 Lombok이 더이상 필요 없을 경우 쉽게 삭제할 수 있다.

여기서 Posts 클래스는 실제 DB의 테이블과 매칭될 클래스이며 **Entity 클래스**라고 한다.
JPA를 사용하면 DB 데이터에 작업할 경우 실제 쿼리를 날리기보다는 이 Entity 클래스의 수정을 통해 작업한다. JPA에서 제공하는 어노테이션이 있다.

# Footnote

*   ***도메인**
    게시글, 댓글, 회원, 정산, 결제 등 소프트웨어에 대한 요구사항 혹은 문제영역
*   ***Entity의 PK는 왜 Long 타입으로 할까?**
    주민등록번호와 같이 비즈니스상 유니크 키나 여러 키를 조합한 복합키로 PK를 잡을 경우 난감한 상황이 발생한다.
    1.  FK를 맺을 때 다른 테이블에서 복합키 전부를 갖고 있거나, 중간 테이블을 하나 더 둬야하는 상황이 발생한다.
    2.  인덱스에 좋은 영향을 끼치지 못한다. [참고 링크](https://mikyung.net/1267)
        InnoDB에서는 기본키 순서대로 데이터가 저장되기 때문에 Random PK 저장시 불필요한 I/O가 발생가능
        InnoDB의 PK는 갱신될 시 갱신된 행 이후 데이터를 하나씩 새 위치로 옮겨야 하므로 절대 갱신되지 않도록 유지한다.ㅇ
    3.  유니크한 조건이 변경될 경우 PK 전체를 수정해야 하는 일이 발생한다.