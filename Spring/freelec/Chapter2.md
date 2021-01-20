# Chapter 2

> Write test code in Spring boot

## Introduction of Test code

TDD vs Unit Test
TDD는 테스트가 주도하는 개발을 의미하며 Test code를 먼저 작성한다.
레드그린사이클과 같이, 항상 실패하는 테스트를 먼저 작성하고(Red) 테스트가 통과하는 프로덕션 코드를 작성하고(Green) 테스트가 통과하면 프로덕션 코드를 리팩토링하는(Refactor) 과정이다.
반면 단위 테스트는 TDD의 첫 번째 단계인 기능 단위의 테스트 코드를 작성하는 것을 의미한다.
TDD와 달리 테스트 코드를 꼭 먼저 작성해야 하는 것도 아니고, 리팩토링도 포함되지 않는다. 순수하게 테스트 코드만 작성하는 것을 의미한다.
여기서는 TDD가 아닌 단위 테스트 코드를 학습한다.

테스트 코드는 왜 작성해야 할까? 위키피디아에서 단위 테스트 코드를 작성함으로써 얻는 이점으로 다음을 이야기한다.

* 단위 테스트는 개발단계 초기에 문제를 발견하게 도와준다.
* 단위 테스트는 개발자가 나중에 코드를 리팩토링하거나 라이브러리 업그레이드 등에서 기존 기능이 올바르게 작동하는지 확인할 수 있다.
* 단위 테스트는 기능에 대한 불확실성을 감소시킬 수 있다.
* 단위 테스트는 시스템에 대한 실제 문서를 제공한다. 즉, 단위 테스트 자체를 문서로 사용할 수 있다.

저자의 경험담으로서의 이점은 다음과 같다.

* 빠른 피드백
  WAS로 사용하는 톰캣 등을 계속 내렸다가 올렸다가 반복할 필요가 없다.
  코드를 수정할 때마다 눈과 손으로 직접 수정된 기능을 확인해야 하기에 그랬는데, 테스트코드를 작성하면 문제가 해결된다.
* 자동 검증
  System.out.println()등을 활용하여 눈으로 검증할 필요 없이 테스트 코드가 자동으로 검증해준다.
* 개발자가 만든 기능을 안전하게 보호
  B라는 기능이 추가되었을 경우 기존에 잘되던 A 기능에 문제가 생길 수 있다. 하나의 기능을 추가할 때마다 많은 자원이 들기에 서비스의 모든 기능을 테스트 할 수는 없기 때문이다.
  이러한 경우 테스트 코드는 기존 기능이 잘 작동되는 것을 보장해준다. 기능이 추가되어도 테스트코드가 수행된다면 문제를 찾을 수 있기 때문이다.

테스트 코드 작성을 도와주는 프레임워크들이 있다. 가장 대중적인 프레임워크로는 xUnit이 있는데 개발환경에 따라 Unit 테스트를 도와주는 도구이다.
대표적인 xUnit 프레임워크들은 다음과 같다.

* JUnit - Java
* DBUnit - DB
* CppUnit - C++
* NUnit - .net

이 중 자바용인 JUnit을 사용한다.

## Hello Controller test code

`/src/main/java`에 GroupId + 패키지명으로 패키지를 하나 만들었다. (com.tunahg.book.springboot)
이후 해당 패키지에 Application이라는 Java Class를 만들고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

> 이 Application Class는 앞으로 만들 프로젝트의 메인 클래스가 된다.
> @SpringBootApplication으로 인해 스프링 부트의 자동 설정, 스프링 Bean 읽기와 생성을 모두 자동으로 설정된다. 특히 @SpringBootApplication이 있는 위치부터 설정을 읽어가기 때문에 이 클래스는 항상 프로젝트의 최상단에 위치해야 한다.
>
> main 메소드에서 실행하는 SpringApplication.run()으로 인해 *내장 WAS를 실행한다. 내장 WAS를 실행하기 때문에 서버에 톰캣을 설치할 필요가 없게 되고, 스프링 부트로 만들어진 Jar 파일로 실행하면 된다. 스프링 부트에서는 내장 WAS를 사용하는 것을 권장한다. 그 이유는 언제 어디서나 같은 환경에서 스프링 부트를 배포할 수 있기 때문이다.

테스트를 위한 Controller를 만들어 본다.
현재 패키지 하위에 `web`이란 패키지를 만든다. 해당 패키지내에 HelloController라는 Java Class를 만들고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    @GetMapping("/hello")
    public String hello() {
        return "hello";
    }
}
```

> @RestController는 컨트롤러를 JSON을 반환하는 Controller로 만들어 준다. 예전에는 @ResponseBody가 각 메소드마다 선언했던것을 한번에 사용할 수 있게 해준다.
>
> @GetMapping은 HTTP Method인 GET의 요청을 받을 수 있는 API를 만든다. 예전에는 @RequestMapping(method = RequestMethod.GET)을 사용했지만 이제는 더욱 간단해졌다.

WAS를 실행하지 않고 테스트 코드를 사용하여 작성한 코드가 제대로 작동하는지 검증한다.
`src/test/java`디렉토리에 아페서 생성했던 패키지를 그대로 생성한다. 그리고 테스트 코드를 작성할 클래스를 생성한다. 일반적으로 테스트 클래스는 대상 클래스 이름에 Test를 붙인다. 지금은 HelloControllerTest가 된다. 일일이 작성해줄 필요없이 HelloController의 Class에서 Command + Shift + T를 누르면 자동으로 Test Class를 만들어주는 과정이 진행된다.
생성된 클래스에 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(SpringExtension.class)
@WebMvcTest(controllers = HelloController.class)
class HelloControllerTest {
    @Autowired
    private MockMvc mvc;

    @Test
    public void hello가_리턴된다() throws Exception {
        String hello = "hello";

        mvc.perform(get("/hello"))
                .andExpect(status().isOk())
                .andExpect(content().string(hello));
    }
}
```

> @ExtendWith(SpringExtension.class)는 테스트를 진행할 때 JUnit에 내장된 실행자 외에 다른 실행자를 실행시킨다. 여기서는 SpringExtension이라는 스프링 실행자를 사용한다. 즉, 스프링 부트 테스트와 JUnit 사이에 연결자 역할을 한다. 이전에는 @RunWith(SpringRunner.class)로 사용하였으나 버전이 높아지면서 변경되었다.
>
> @WebMvcTest는 여러 스프링 테스트 어노테이션 중, Web(Spring MVC)에 집중할 수 있는 어노테이션이다. 선언할 경우 @Controller와 @ControllerAdvice등을 사용할 수 있다. 단 @Service, @Component, @Repository 등은 사용할 수 없다. 여기서는 Controller만 사용하기 때문에 선언했다.
>
> @Autowired는 스프링이 관리하는 빈(Bean)을 주입받는다.
>
> MockMvc 객체는 웹 API를 테스트할 때 사용하며 Spring MVC 테스트의 시작점이다. 이 클래스를 통해 HTTP GET, POST 등에 대한 API 테스트를 진행할 수 있다.
>
> mvc.perform(get("/hello"))는 MockMvc를 통해 /hello주소로 HTTP GET 요청을 한다. 체이닝이 지원되어 아래와 같이 여러 검증기능을 이어서 선언할 수 있다.
>
> .andExpect(status.isOk())는 mvc.perform()의 결과를 검증한다. HTTP Header의 Status를 검증한다. 여기선 OK, 200인지 아닌지를 검증한다.
>
> .andExpect(content().string(hello))는 mvc.perform()의 결과를 검증한다. 응답 본문의 내용을 검증한다. Controller에서 "hello"를 리턴하기 때문에 이 값이 맞는지 검증한다.

테스트 코드를 모두 작성했다면 메소드 좌측에 화살표를 클릭하여 Run 한다. 테스트가 통과하는 것을 확인할 수 있다.
우리가 검증용으로 선언했던 status().isOk()와 content().string(hello)가 모두 테스트를 통과했음을 의미한다.

수동으로도 실해해서 정상적으로 값이 출력되는지 확인해본다.
Application.java로 이동하여 메인 메소드 좌측의 화살표를 클릭한다.
실행해보면 스프링 부트 로그가 보이며 톰캣 서버가 8080포트로 실행되었다는 것이 로그에 출력된다.
그럼 웹 브라우저를 열어 localhost:8080/hello로 접속해본다. hello 문자열이 출력되는 것을 확인할 수 있다.

이후에도 테스트 코드는 계속해서 작성한다.
브라우저로 한 번씩 검증하되 테스트 코드는 꼭 따라해야 한다. 그래야만 견고한 소프트웨어를 만드는 역량이 성장할 수 있다.
추가로, 절대 수동으로 검증하고 테스트 코드를 작성하진 않는다. 테스트 코드로 먼저 검증 후 정말 못 믿겠다는 생각이 들 때 프로젝트를 실행해 확인해 본다.

## Lombok

자바 개발자들의 필수 라이브러리
자주 사용하는 코드인 Getter, Setter, 기본생성자, toString등을 Annotation으로 자동생성해준다.

이클립스의 경우 설치가 번거롭지만, 인텔리제이에선 플러그인덕분에 쉽게 설정이 가능하다. 먼저 프로젝트에 롬복을 추가해본다.
bundle.gradle에 다음의 코드를 추가한다.

```
implementation('org.projectlombok:lombok')
```

이후 gradle을 적용하여 라이브러리를 내려받는다.
라이브러리를 받은 이후엔 플러그인을 설치한다. Command + Shift + A로 Action검색창을 열고 Plugins로 진입하여 Marketplace에서 lombok을 검색한 후 설치한다. 설치 이후엔 IntelliJ IDE를 재시작한다.
이후에 lombok에 대한 설정으로 Command + ,로 Preferences로 접근하여 Annotation을 검색하고 Annotation Processors를 enable로 변경한다. Annotation Processors는 Settings > Build > Compiler에 존재한다.
Lombok은 프로젝트마다 설정해야 한다. 플러그인 설치는 한번만 하면 되지만 bundle.gradle에 라이브러리를 추가하는 것과 annotation processors를 enable체크하는 것은 프로젝트마다 진행해야 한다.

## Converting Hello Controller code to Lombok

기존에 진행한 Hello Controller 코드를 Lombok으로 변경한다.
큰 규모의 프로젝트였다면 롬복으로 쉽게 전환하지 못했겠지만, 테스트 코드를 잘 구현했다면 쉽게 변경할 수 있다.

먼저 web 패키지에 dto 패키지를 추가한다. 앞으로 모든 응답 Dto는 이 dto 패키지에 추가한다.
dto 패키지에 HelloResponseDto를 생성하고 다음의 코드를 작성한다.

```java
package com.tunahg.book.springboot.web.dto;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class HelloResponseDto {
    private final String name;
    private final int amount;
}
```

>   @Getter는 선언된 모든 필드의 get 메소드를 생성해 준다.
>
>   @RequiredArgsConstructor는 선언된 모든 final필드가 포함된 생성자를 생성해 준다. final이 없는 필드는 생성자에 포함되지 않는다.

이 Dto에 적용된 Lombok이 잘 작동하는지 간단한 테스트 코드를 작성해본다.
HelloResponseDtoTest 파일을 Command + Shift + T를 활용해 생성하고 다음의 코드를 작성한다.

```java
package com.tunahg.book.springboot.web.dto;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class HelloResponseDtoTest {
    @Test
    public void 롬복_기능_테스트() {
        String name = "test";
        int amount = 1000;

        HelloResponseDto dto = new HelloResponseDto(name, amount);

        assertThat(dto.getName()).isEqualTo(name);
        assertThat(dto.getAmount()).isEqualTo(amount);
    }
}
```

>   assertThat은 assertj라는 테스트 검증 라이브러리의 검증 메소드이다. 검증하고 싶은 대상을 메소드 인자로 받는다. 메소드 체이닝이 지원되어 isEqualTo와 같이 메소드를 이어서 사용할 수 있다.
>
>   isEqualTo는 assertj의 동등 비교 메소드이다. assertThat에 있는 값과 isEqualTo의 값을 비교하여 같을 때만 성공이다.

이 코드에서는 JUnit의 기본 assertThat이 아닌 assertj의 assertThat을 사용했다. assertj 역시 JUnit에서 자동으로 라이브러리를 등록해준다.
JUnit과 비교하여 assertj의 장점은 다음과 같다. [참고 유튜브(백기선님)](http://bit.ly/30vm9Lg)

* CoreMatchers와 달리 추가적으로 라이브러리가 필요하지 않다.
    JUnit의 assertThat을 쓰게되면 is()와 같이 CoreMatchers 라이브러리가 필요하다.
* 자동완성이 좀 더 확실하게 지원된다.
    IDE에서는 CoreMatchers와 같은 Matcher 라이브러리의 자동완성 지원이 약하다.

해당 코드에서 error: variable name not initialized in the default constructor와 같은 에러가 발생할 수 있다.
이러할 경우 [저자 깃헙 이슈](https://github.com/jojoldu/freelec-springboot2-webservice/issues/2)를 참고하여 다운그레이드하거나 Setting의 gradle projects의 build and run, run test using을 IntelliJ IDEA로 변경하여 해결해본다.

정상적으로 기능이 수행되는 것을 확인했다. Lombok의 @Getter로 get메소드가, @RequiredArgsConstructor로 생성자가 자동으로 생성되는 것이 증명되었다.

그럼 HelloController에도 새로 만든 ResponseDto를 사용하도록 코드를 추가한다.

```java
@GetMapping("/hello/dto")
public HelloResponseDto helloDto(@RequestParam("name") String name, @RequestParam("amount") int amount) {
		return new HelloResponseDto(name, amount);
}
```

>   @RequestParam은 외부에서 API로 넘긴 파라미터를 가져오는 어노테이션이다. 여기서는 외부에서 name (@RequestParam("name"))이란 이름으로 넘긴 파라미터를 메소드 파라미터 name (String name)에 저장하게 된다.

추가된 API를 테스트하는 코드를 HelloControllerTest에 추가한다.

```java
@Test
public void helloDto가_리턴된다() throws Exception {
    String name = "hello";
    int amount = 1000;
    
    mvc.perform(
            get("/hello/dto")
                    .param("name", name)
                    .param("amount", String.valueOf(amount)))
            .andExpect(status().isOk())
            .andExpect(jsonPath("$.name", is(name)))
            .andExpect(jsonPath("$.amount", is(amount)));
}
```

>   param()은 API 테스트할 때 사용될 요청 파라미터를 설정한다. 단, 값은 String만 허용된다.
>   그래서 숫자, 날짜 등의 데이터도 등록할 때는 문자열로 변경해야만 한다.
>
>   jsonPath()는 JSON응답값을 필드별로 검증할 수 있는 메소드이다. `$`를 기준으로 필드명을 명시한다.
>   여기서는 name과 amount를 검증하니 ​`$.name`, `$.amount`로 검증한다.
>   jsonPath는 org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath를 import해야한다.

# Footnote

* ***내장 WAS**
  별도로 외부에 WAS를 두지 않고 애플리케이션을 실행할 때 내부에서 WAS를 실행하는 것