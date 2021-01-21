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
>
>   @NoArgsConstructor는 기본생성자를 자동으로 추가하는 Lombok 어노테이션이다.. `Public Posts() {}`와 같은 효과이다.
>
>   @Builder는 해당 클래스의 빌더 패턴 클래스를 생성하는 Lombok 어노테이션이다. 생성자 상단에 선언 시 생성자에 포함된 필드만 빌더에 포함된다.

어노테이션 순서를 **주요 어노테이션을 클래스에 가깝게 둔다.**
@Entity는 JPA의 어노테이션이며, @Getter와 @NoArgsConstructor는 Lombok의 어노테이션이다.
Lombok은 코드를 단순화시켜주지만 필수 어노테이션은 아니다. 그러다보니 주요 어노테이션인 @Entity를 클래스에 가깝게 두고 Lombok 어노테이션을 그 위로 두었다. 이렇게하면 이후 코틀린 등의 새 언어 전환으로 Lombok이 더이상 필요 없을 경우 쉽게 삭제할 수 있다.

여기서 Posts 클래스는 실제 DB의 테이블과 매칭될 클래스이며 **Entity 클래스**라고 한다.
JPA를 사용하면 DB 데이터에 작업할 경우 실제 쿼리를 날리기보다는 이 Entity 클래스의 수정을 통해 작업한다. JPA에서 제공하는 어노테이션이 있다.

이 Posts 클래스에는 **Setter 메소드가 없다.**
자바빈 규약을 생각하면서 Getter/Setter 메소드를 무작정 생성하면, **해당 클래스의 인스턴스 값들이 언제 어디서 변해야 하는지 코드상으로 명확하게 구분할 수가 없어서 차후 기능 변경시 복잡해진다.** 그래서 Entity 클래스에서는 절대 Setter 메소드를 만들지 않는다. 대신 해당 필드의 값 변경이 필요하면 명확히 **그 목적과 의도를 나타낼 수 있는 메소드를 추가**해야만 한다.
`setStatus()`와 같이 Setter 메소드를 사용하여 status값을 변경하는 것이 아니라 `cancelOrder()`와 같이 목적과 의도를 나타내는 메소드를 추가하는 것이다.

그렇다면 Setter가 없는 상황에서 **어떻게 값을 채워 DB에 삽입하는가?**
기본적인 구조는 **생성자를 통해 최종값을 채운 후 DB에 삽입**하는 것이며, 값 변경이 필요한 경우 해당 이벤트에 맞는 public 메소드를 호출하여 변경하는 것을 전제로 한다. 책에서는 생성자 대신에 **@Builder를 통해 제공되는 빌더 클래스를 사용**한다. 생성자나 빌더는 생성 시점에 값을 채워주는 역할은 똑같으나 생성자의 경우 지금 채워야 할 필드가 무엇인지 명확히 지정할 수 없다. 

```java
public Example(String a, String b) {
  this.a = a;
  this.b = b;
}
Example(b, a); // ???

Example.builder()
  .a(a)
  .b(b)
  .build(); // Good!
```

>   생성자와 빌더의 사용 예를 들어보면, 생성자 내의 파라미터 두 개의 위치를 바꿔도 코드를 실행하기 전까지는 문제를 찾을 수 없다는 점이다. 
>   하지만 빌더를 사용하게 되면 어느 필드에 어떤 값을 채워야할지 명확하게 인지할 수 있다.

Posts 클래스 생성이 끝났다면, Posts 클래스로 DB를 접근하게 해줄 JPARepository를 생성한다.
domain 패키지의 posts 패키지 내에 PostsRepository 인터페이스를 생성한다.

```java
package com.tunahg.book.springboot.domain.posts;

import org.springframework.data.jpa.repository.JpaRepository;

public interface PostsRepository extends JpaRepository<Posts, Long> {
}
```

>   보통 ibatis나 MyBatis 등에서 DAO라고 불리는 DB Layer 접근자이다. JPA 에서는 Repository라고 부르며 인터페이스로 생성한다.
>   단순히 인터페이스 생성 후 `JpaRepository<Entity 클래스, PK 타입>`을 상속하면 기본적인 CRUD 메소드가 자동으로 생성된다.
>
>   @Repository를 추가할 필요도 없다.
>
>   여기서 주의할 점은 Entity 클래스와 기본 Entity Repository는 같은 패키지에 위치해야 한다는 점이다. Entity 클래스는 기본 Repository 없이는 제대로 역할을 수행할 수 없다. 나중에 프로젝트가 커져 도메인별로 프로젝트를 분리해야 한다면 Entity 클래스와 기본 Repository는 함께 움직여야 하므로 도메인패키지에서 함께 관리한다.

모두 작성되었다면, 테스트 코드로 기능을 검증한다.

## Write test code about Spring Data JPA

PostsRepository 클래스에서 Command + Shift + T 단축키를 통해 Test 클래스를 생성한다. Test 클래스에서 save(), findAll() 기능을 테스트한다.

```java
package com.tunahg.book.springboot.domain.posts;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(SpringExtension.class)
@SpringBootTest
class PostsRepositoryTest {

    @Autowired
    PostsRepository postsRepository;

    @AfterEach
    public void cleanup() {
        postsRepository.deleteAll();
    }

    @Test
    public void 게시글저장_불러오기() {
        String title = "테스트 게시글";
        String content = "테스트 본문";

        postsRepository.save(Posts.builder()
        .title(title)
        .content(content)
        .author("hkkim448@gmail.com")
        .build());

        List<Posts> postsList = postsRepository.findAll();

        Posts posts = postsList.get(0);
        assertThat(posts.getTitle()).isEqualTo(title);
        assertThat(posts.getContent()).isEqualTo(content);
    }
}
```

>   @AfterEach는 JUnit에서 단위테스트가 끝날때마다 수행하는 메소드를 지정한다. JUnit4에서는 org.junit.After 였지만 JUnit5에서org.junit.jupiter.api.AfterEach로 변경되었다. 보통은 배포 전 전체 테스트를 수행할 때 테스트간 데이터 침범을 막기 위해 사용한다. 여러 테스트가 동시에 수행되면 테스트용 데이터베이스인 H2에 데이터가 그대로 남아 있어 다음 테스트 실행 시 테스트가 실패할 수 있다.
>
>   @save()는 테이블에 insert/update 쿼리를 실행한다. ID값이 있다면 update가, 없다면 insert 쿼리가 실행된다.
>
>   @findAll()은 테이블에 있는 모든 데이터를 조회해오는 메소드이다.

별다른 설정 없이 @SpringBootTest를 사용할 경우 H2 데이터베이스를 자동으로 실행해준다.

해당 테스트를 진행해보면 실제로 진행된 쿼리는 어떤 형태일지 궁금하다.
실행된 쿼리를 로그로 확인할 수 없을까?. 쿼리 로그를 ON/OFF할 수 있는 설정이 있다. Java 클래스로 구현할 수 있으나 스프링 부트에서는 application.properties, application.yml 등의 파일로 한 줄의 코드로 설정할 수있다.
`src/main/resources` 디렉토리 아래에 application.properties 파일을 생성하고 다음의 코드를 작성한다.

```properties
spring.jpa.show-sql=true
```

옵션이 추가된 이후 테스트를 다시 진행해본다.
![image-20210121114553690](/Users/user/Documents/TIL/Spring/freelec/images/image-20210121114553690.png)

위와 같이 로그를 확인해보면 `Hibernate: SQL query`가 나타나는 것을 확인할 수 있다.
여기서 `create table posts`부분을 살펴보면 `id bigint generated by default as identity`와 같은 옵션으로 지정된 것을 알 수 있다. 이는 H2의 쿼리문법이 적용되었기 때문인데, H2는 MySQL의 쿼리를 수행해도 정상적으로 작동하기 때문에 이후 디버깅을 위해 출력되는 쿼리로그를 MySQL 버전으로 변경한다. application.properties 파일에 다음의 코드를 추가하면 된다.

```properties
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL57Dialect
spring.jpa.properties.hibernate.dialect.storage_engine=innodb
spring.datasource.hikari.jdbc-url=jdbc:h2:mem:testdb;MODE=MYSQL
spring.datasource.hikari.username=sa
```

>   책에는 `spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL5InnoDBDialect`만 입력하라고 되어있는데 이렇게만 입력하면 오류가 발생한다. 위의 코드는 저자 블로그에서 버전업으로 수정된 내용을 가져온 것이므로 위의 코드를 사용한다.
>
>   코드 중 `pring.datasource.hikari.jdbc-url`와 `spring.datasource.hikari.username`는 real-db를 사용할 경우 override된다.3

## Create API about CRUD

API를 만들기 위해서은 총 3개의 클래스가 필요하다.

*   Request 데이터를 받을 Dto
*   API 요청을 받을 Controller
*   트랜잭션, 도메인 기능 간의 순서를 보장하는 Service

많은 사람들이 <u>오해하는 것중 하나가 Service에서 비즈니스 로직을 처리해야 한다는 것</u>이다. **Service는 트랜잭션, 도메인 간 순서를 보장하는 역할만 한다**. 그럼 비즈니스 로직은 누가 처리할까? 그것을 알기 위해 **Spring Web 계층**을 살펴본다.

*   **Web Layer**
    흔히 사용하는 컨트롤러(@Controller)와 JSP/Freemarker 등의 뷰 템플릿 영역이다.
    이외에도 필터(@Filter), 인터셉터, 컨트롤러 어드바이스(@ControllerAdvice)등 외부 요청과 응답에 대한 전반적인 영역을 이야기한다.
*   **Service Layer**
    @Service에 사용되는 서비스 영역이다.
    일반적으로 Controller와 Dao의 중간 영역에서 사용된다.
    @Transactional이 사용되어야 하는 영역이다.
*   **Repository Layer**
    Database와 같이 데이터 저장소에 접근하는 영역이다.
    기존에 개발하던 사람들은 Dao(Data Access Object) 영역으로 이해하면 쉽다.
*   **Dtos**
    Dto(Data Transfer Object)는 계층 간에 데이터 교환을 위한 객체를 이야기하며 Dtos는 이들의 영역을 이야기한다.
    예를 들어 뷰 템플릿 엔진에서 사용될 객체나 Repository Layer에서 결과로 넘겨준 객체등을 의미한다.
*   **Domain Model**
    도메인이라 불리는 개발 대상을 모든 사람이 동일한 관점에서 이해할 수 있고 공유할 수 있도록 단순화시킨 것을 도메인 모델이라고 한다.
    이를테면 택시 앱이라고 하면 배차, 탑승, 요금 등이 모두 도메인이 될 수 있다.
    @Entity를 사용해본 사람들은 @Entity가 사용된 영역 역시 도메인 모델이라고 이해하면 된다.
    다만, 무조건 데이터베이스의 테이블과 관계가 있어야만 하는 것은 아니다. VO처럼 값 객체들도 이 영역에 해당하기 때문이다.

이 5개의 Layer에서 **비즈니스 처리를 담당해야 하는 곳은 Domain**이다.
기존에 서비스로 처리하던 방식을 <u>트랜잭션 스크립트</u>라고 한다. 주문 취소 로직을 작성한 코드를 살펴보면 다음과 같다.

```java
@Transactional
public Order cancelOrder(int orderId) {
	// 1) 데이터베이스로부터 주문정보(Orders), 결제정보(Billing), 배송정보(Delivery) 조회
  OrdersDto order = ordersDao.selectOrders(orderId);
  BillingDto billing = billingDao.selectBilling(orderId);
  DeliveryDto delivery = deliveryDao.selectDelivery(orderId);

	// 2) 배송 취소를 해야하는지 확인
  String deliveryStatus = delivery.getStatus();
 
	// 3) if(배송 중이라면) {
	//		배송 취소로 변경
	//	  }
  if("IN_PROGRESS".equals(deliveryStatus)) {
    delivery.setStatus("CANCEL");
    deliveryDao.update(delivery);
  }
  
	// 4) 각 테이블에 취소 상태 Update
  order.setStatus("CANCEL");
  ordersDao.update(order);
  
  billing.setStatus("CANCEL");
	billingDao.update(billing);
  
  return order;
}
```

>   모든 로직이 서비스 클래스 내부에서 처리된다. 그러다 보니 서비스 계층이 무의미하며, 객체란 단순히 데이터 덩어리 역할만 하게 된다.

반면 도메인 모델에서 처리할 경우 다음과 같은 코드가 될 수 있다.

```java
@Transactional
public Order cancelOrder(int orderId) {
  // 1)
  Orders order = ordersRepository.findById(orderId);
  Billing billing = billingRepository.findByOrderId(orderId);
  Delivery delivery = deliveryRepository.findByOrderId(orderId);
  
  // 2~3)
  delivery.cancel();
  
  // 4)
  order.cancel();
  billing.cancel();
  
  return order;
}
```

> order, billing, delivery가 본인의 취소 이벤트 처리를 하며, 서비스 메소드는 트랜잭션과 도메인 간의 순서만 보장해준다.

그럼 이제 등록, 수정, 삭제 기능을 만들어 본다.
PostsAPIController을 web 패키지에, PostsSaveRequestDto를 web.dto 패키지에, PostsService를 service.posts 패키지에 생성한다.

먼저 PostsAPIController의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.web;

import com.tunahg.book.springboot.service.posts.PostsService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class PostsAPIController {
    private final PostsService postsService;
    
    @PostMapping("/api/v1/posts")
    public Long save(@RequestBody PostsSaveRequestDto requestDto) {
        return postsService.save(requestDto);
    }
}
```

다음으로 PostsService의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.service.posts;

import com.tunahg.book.springboot.domain.posts.PostsRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class PostsService {
    private final PostsRepository postsRepository;

    @Transactional
    public Long save(PostsSaveRequestDto requestDto) {
        return postsRepository.save(requestDto.toEntity()).getId();
    }
}
```

스프링을 어느정도 사용해본 사람이라면 Controller와 Service에서 @Autowired가 없는 것이 어색하다.
스프링에서 Bean을 주입받는 방식들은 <u>@Autowired, Setter, 생성자</u> 세가지 방법이 있다. 이중 가장 권장하는 방법이 생성자로 주입받는 방식이다. @Autowired는 권장하지 않는다. 여기서 생성자는 @RequiredArgsConstructor가 final이 선언된 모든 필드를 인자값으로 하는 생성자를 생성해준다. 
생성자로 주입받는다는게...?

이제는 Controller와 Service에서 사용할 Dto 클래스를 생성한다. 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.web.dto;

import com.tunahg.book.springboot.domain.posts.Posts;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PostsSaveRequestDto {
    private String title;
    private String content;
    private String author;

    @Builder
    public PostsSaveRequestDto(String title, String content, String author) {
        this.title = title;
        this.content = content;
        this.author = author;
    }

    public Posts toEntity() {
        return Posts.builder()
                .title(title)
                .content(content)
                .author(author)
                .build();
    }
}
```

Entity 클래스와 유사한 형태임에도 Dto 클래스를 추가로 생성했다. **절대로 Entity 클래스를 Response/Request 클래스로 사용해서는 안된다.**
Entity 클래스는 데이터베이스와 맞닿은 핵심 클래스이다. Entity 클래스를 기준으로 테이블이 생성되고 스키마가 변경된다. 화면변경은 사소한 기능변경인데 이를 위해 테이블과 연결된 Entity 클래스를 변경하는 것은 너무 큰 변경이다. 수많은 서비스 클래스나 비즈니스 로직들이 Entity 클래스를 기준으로 동작한다. Entity 클래스가 변경되면 여러 클래스에 영향을 끼치지만, Request와 Response용 Dto는 View를 위한 클래스라 자주 변경이 필요하다. 
View Layer와 DB Layer의 역할 분리를 철저하게 하는 것이 좋다. 실제로 Controller에서 결과값으로 여러 테이블을 조인해서 줘야 할 경우가 빈번하므로 Entity 클래스만으로 표현하기가 어려운 경우가 많다. 꼭 Entity 클래스와 Controller에서 쓸 Dto는 분리해서 사용해야 한다.

등록 기능의 코드가 완성되었으니 테스트 코드로 검증해본다.
PostsAPIController에서 Command + Shift + T 단축키를 활용해서 Test파일을 생성한다. 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.web;

import com.tunahg.book.springboot.domain.posts.Posts;
import com.tunahg.book.springboot.domain.posts.PostsRepository;
import com.tunahg.book.springboot.web.dto.PostsSaveRequestDto;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class PostsAPIControllerTest {
    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Autowired
    private PostsRepository postsRepository;

    @AfterEach
    public void tearDown() throws Exception {
        postsRepository.deleteAll();
    }

    @Test
    public void Posts_등록된다() throws Exception {
        String title = "title";
        String content = "content";
        PostsSaveRequestDto requestDto = PostsSaveRequestDto.builder()
                .title(title)
                .content(content)
                .author("author")
                .build();

        String url = "http://localhost:" + port + "/api/v1/posts";

        ResponseEntity<Long> responseEntity = restTemplate.postForEntity(url, requestDto, Long.class);

        assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(responseEntity.getBody()).isGreaterThan(0L);

        List<Posts> all = postsRepository.findAll();
        assertThat(all.get(0).getTitle()).isEqualTo(title);
        assertThat(all.get(0).getContent()).isEqualTo(content);
    }
}
```

>   HelloControllerTest 때와 달리 @WebMvcTest를 사용하지 않았다.
>   @WebMvcTest의 경우 JPA기능이 작동하지 않기 때문인데, Controller와 ControllerAdvice 등 외부 연동과 관련된 부분만 활성화되니 지금 같이 JPA 기능까지 한번에 테스트할 때는 @SpringBootTest와 TestRestTemplate을 사용하면 된다.

테스트를 수행해보면 성공하는 것을 확인할 수 있고 로그를 확인해보면 랜덤포트 실행과 insert 쿼리가 실행된 것을 확인할 수 있다.

등록 기능을 완성했으니 수정/조회 기능도 빠르게 만들어 본다.
먼저 PostsController에 수정, 조회 메소드를 추가한다.

```java
@PutMapping("/api/v1/posts/{id}")
public Long update(@PathVariable Long id, @RequestBody PostsUpdateRequestDto requestDto) {
    return postsService.update(id, requestDto);
}

@GetMapping("/api/v1/posts/{id}")
public PostsResponseDto findById(@PathVariable Long id) {
    return postsService.findById(id);
}
```

다음으로 `/web/dto`패키지에 PostsResponseDto를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web.dto;

import com.tunahg.book.springboot.domain.posts.Posts;
import lombok.Getter;

@Getter
public class PostsResponseDto {
    private Long id;
    private String title;
    private String content;
    private String author;

    public PostsResponseDto(Posts entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.content = entity.getContent();
        this.author = entity.getAuthor();
    }
}
```

>   PostsResponseDto는 Entity의 필드 중 일부만 사용하므로 생성자로 Entity를 받아 필드에 값을 넣는다.
>   굳이 모든 필드를 가진 생성자가 필요하진 않으므로 Dto는 Entity를 받아서 처리한다.

다음으로 수정기능을 담당할 PostsUpdateRequestDto를 `/web/dto`패키지에 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PostsUpdateRequestDto {
    private String title;
    private String content;
    
    @Builder
    public PostsUpdateRequestDto(String title, String content) {
        this.title = title;
        this.content = content;
    }
}
```

다음으로 Entity 클래스인 Posts 클래스에 다음의 메소드를 추가한다.

```java
public void update(String title, String content) {
    this.title = title;
    this.content = content;
}
```

마지막으로 PostsService 클래스에 다음의 코드를 추가한다.

```java
@Transactional
public Long update(Long id, PostsUpdateRequestDto requestDto) {
    Posts posts = postsRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. id=" + id));
    
    posts.update(requestDto.getTitle(), requestDto.getContent());

    return id;
}

public PostsResponseDto findById(Long id) {
    Posts entity = postsRepository.findById(id)
            .orElseThrow(() -> new IllegalArgumentException("해당 게시글이 없습니다. id=" + id));

    return new PostsResponseDto(entity);
}
```

코드를 살펴보면, update 기능에서 데이터베이스에 쿼리를 날리는 부분이 없다. 이는 **JPA의 영속성 컨텍스트** 때문이다.
영속성 컨텍스트란, 엔티티를 영구 저장하는 환경이다. 일종의 논리적 개념이며 JPA의 핵심 내용은 엔티티가 영속성 컨텍스트에 포함되어 있냐 아니냐로 갈린다. JPA의 엔티티 매니저가 활성화된 상태(Spring Data JPA를 사용한다면 기본 옵션)로 트랜잭션 안에서 데이터베이스의 데이터를 가져오면 이 데이터는 영속성 컨텍스트가 유지된 상태이다. 이 상태에서 해당 데이터의 값을 변경하면 트랜잭션이 끝나는 시점에 해당 테이블에 변경분을 반영한다.
즉, Entity 객체의 값만 변경하면 별도로 Update 쿼리를 날릴 필요가 없다는 것이다. 이 개념을 **더티 체킹(Dirty Checking)**이라 한다.

실제로 Update 쿼리를 정상적으로 수행하는지 테스트 코드로 확인해본다.
PostsAPIControllerTest 파일에 다음의 메소드를 추가한다.

```java
@Test
public void Posts_수정된다() throws Exception {
    Posts savedPosts = postsRepository.save(Posts.builder()
            .title("title")
            .content("content")
            .author("author")
            .build());

    Long updateId = savedPosts.getId();
    String expectedTitle = "title2";
    String expectedContent = "content2";

    PostsUpdateRequestDto requestDto = PostsUpdateRequestDto.builder()
            .title(expectedTitle)
            .content(expectedContent)
            .build();

    String url = "http://localhost:" + port + "/api/v1/posts/" + updateId;

    HttpEntity<PostsUpdateRequestDto> requestEntity = new HttpEntity<>(requestDto);

    ResponseEntity<Long> responseEntity = restTemplate.exchange(url, HttpMethod.PUT, requestEntity, Long.class);

    assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.OK);
    assertThat(responseEntity.getBody()).isGreaterThan(0L);

    List<Posts> all = postsRepository.findAll();
    assertThat(all.get(0).getTitle()).isEqualTo(expectedTitle);
    assertThat(all.get(0).getContent()).isEqualTo(expectedContent);
}
```

테스트를 진행해보면 아래와 같이 update 쿼리가 수행되는 것을 확인할 수 있다.![image-20210121152026625](/Users/user/Documents/TIL/Spring/freelec/images/image-20210121152026625.png)

MyBatis를 쓰던것과 달리 JPA를 씀으로서 좀 더 객체지향적으로 코딩할 수 있다.

조회 기능은 실제로 톰캣을 실행해서 확인해본다.
앞에서 언급한 것처럼 로컬환경에선 데이터베이스로 H2를 사용한다. 메모리에서 실행하기 때문에 직접 접근하려면 웹 콘솔을 사용해야만 한다.
먼저 웹 콘솔 옵션을 활성화한다. Application.properties에 다음과 같은 옵션을 추가한다.

```properties
spring.h2.console.enabled=true
```

추가한 이후 Application 클래스의 main 메소드를 실행한다.
정상적으로 실행됬다면 톰캣이 8080포츠로 실행된다. 여기서 웹브라우저로 `http://localhost:8080/h2-console`로 접속하면 웹 콘솔 화면이 나타난다. 콘솔화면에서 JDBC URL이 `jdbc:h2:mem:testdb`로 되어있지 않다면 변경한다.
이후 Connect를 클릭하면 현재 프로젝트의 H2를 관리할 수 있는 관리 페이지로 이동한다. 해당 페이지에서 SQL 쿼리를 수행할 수도 있다.

## Automating create/update time with JPA Auditing

보통 엔티티에는 해당 데이터의 생성시간과 수정시간을 포함한다.
언제 만들어졌는지, 언제 수정되었는지 등은 차후 유지보수에 있어서 굉장히 중요한 정보이기 때문이다. 그렇다 보니 매번 DB에 insert/update하기 전에 날짜 데이터를 등록/수정하는 코드가 여기저기 들어가게 된다. 이런 단순하고 반복적인 코드가 모든 테이블과 서비스 메소드에 포함된다고 생각하면 어마어마하게 귀찮고 코드가 지저분해진다.
이를 해결하고자 JPA Auditing을 사용한다.

### LocalDate

Java8부터  LocalDate와 LocalDateTime이 등장한다. 그간 Java의 기본 날짜 타입인 Date의 [**문제점*](#Footnote)을 고친 타입이라 Java8일 경우 무조건 사용한다.

LocalDate와 LocalDateTime이 데이터베이스에 제대로 매핑되지 않는 이슈가 Hibernate 5.2.10 버전에서 해결되었다.
스프링 부트 1.x를 쓴다면 별도로 Hibernate 5.2.10 버전이상을 사용하도록 설정해야 하지만 스프링 부트 2.x 버전을 사용하면 기본적으로 해당 버전을 사용중이라 별다른 설정 없이 바로 적용하면 된다.

domain패키지에 BaseTimeEntity 클래스를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.domain;

import lombok.Getter;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.EntityListeners;
import javax.persistence.MappedSuperclass;
import java.time.LocalDateTime;

@Getter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public class BaseTimeEntity {
    @CreatedDate
    private LocalDateTime createdDate;
    
    @LastModifiedDate
    private LocalDateTime modifiedDate;
}
```

>   @MappedSuperclass는 JPA Entity 클래스들이 BaseTimeEntity를 상속할 경우 필드(createdDate, modifiedDate)들도 칼럼으로 인식하도록 한다.
>
>   @EntityListeners(AuditingEntityListener.class)는 BaseTimeEntity 클래스에 Auditing 기능을 포함시킨다.
>
>   @CreatedDate는 Entity가 생성되어 저장될 때 시간이 자동 저장된다.
>
>   @LastModifiedDate는 조회한 Entity의 값을 변경할 때 시간이 자동 저장된다.

BaseTimeEntity 클래스는 모든 Entity의 상위 클래스가 되어 Entity들의 createdDate, modifiedDate를 자동으로 관리한다.

그리고 Entity 클래스인 Posts 클래스가  BaseTimeEntity를 상속받도록 변경한다.

```java
public class Posts extends BaseTimeEntity {
  ...
}
```

마지막으로 JPA Auditing 어노테이션들을 모두 활성화할 수 있도록 Application 클래스에 활성화 어노테이션을 하나 추가한다.

```java
@EnableJpaAuditing // JPA Auditing 활성화
@SpringBootApplication
public class Application {
  ...
}
```

기능이 잘 동작하는지 테스트코드를 작성해본다.
PostsRepositoryTest에 다음의 테스트 메소드를 추가한다.

```java
@Test
public void BaseTimeEntity_등록() {
    LocalDateTime now = LocalDateTime.of(2019, 6, 4, 0, 0, 0);
    postsRepository.save(Posts.builder()
            .title("title")
            .content("content")
            .author("author")
            .build());

    List<Posts> postsList = postsRepository.findAll();
    
    Posts posts = postsList.get(0);

    System.out.println(">>>>>>>> createDate=" + posts.getCreatedDate() + ", modifiedDate=" + posts.getModifiedDate());

    assertThat(posts.getCreatedDate()).isAfter(now);
    assertThat(posts.getModifiedDate()).isAfter(now);
}
```

테스트를 수행해보면 실제 시간이 잘 저장된 것을 확인할 수 있다.

앞으로 추가될 엔티티들은 더이상 등록일/수정일로 고민할 필요가 없다. BaseTimeEntity만 상속받으면 자동으로 해결되기 때문이다.

# Footnote

*   ***도메인**
    게시글, 댓글, 회원, 정산, 결제 등 소프트웨어에 대한 요구사항 혹은 문제영역
*   ***Entity의 PK는 왜 Long 타입으로 할까?**
    주민등록번호와 같이 비즈니스상 유니크 키나 여러 키를 조합한 복합키로 PK를 잡을 경우 난감한 상황이 발생한다.
    1.  FK를 맺을 때 다른 테이블에서 복합키 전부를 갖고 있거나, 중간 테이블을 하나 더 둬야하는 상황이 발생한다.
    2.  인덱스에 좋은 영향을 끼치지 못한다. [참고 링크](https://mikyung.net/1267), [PK 순서에 대한 처리 참고 링크](https://redkite777.tistory.com/entry/%EC%98%A4%EB%9D%BC%ED%81%B4PK%EC%BB%AC%EB%9F%BC-%EC%88%9C%EC%84%9C%EC%99%80-%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4-%EC%84%B1%EB%8A%A5)
        InnoDB에서는 기본키 순서대로 데이터가 저장되기 때문에 Random PK 저장시 불필요한 I/O가 발생가능
        InnoDB의 PK는 갱신될 시 갱신된 행 이후 데이터를 하나씩 새 위치로 옮겨야 하므로 절대 갱신되지 않도록 유지한다.ㅇ
    3.  유니크한 조건이 변경될 경우 PK 전체를 수정해야 하는 일이 발생한다.
*   ***Java8 이전의 Date와 Calendar 클래스의 문제점**
    [관련 네이버D2 링크](https://d2.naver.com/helloworld/645609)
    *   변경이 불가능한 객체가 아니다.
        멀티스레드 환경에서 언제든 문제가 발생할 수 있다.
    *   Calendar는 월(Month) 값 설계가 잘못되었다.
        10월을 나타내는 Calendar.OCTOBER의 숫자 값은 9이다.