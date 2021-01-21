# Chapter 4

>   Configuring the screen in Mustache

## Introduction of Server Template Engine & Mustache

일반적으로 웹 개발에 있어서 템플릿 엔진이란, **지정된 템플릿 양식과 데이터가 합쳐져 HTML 문서를 출력하는 소프트웨어**를 의미한다.
예전에 스프링이나 서블릿을 사용해 본 사람들은 JSP, Freemarker를 생각할 수 있고, 최근에는 React, Vue의 View 파일을 떠올릴 것이다.
둘 모두 결과적으로 템플릿 엔진이다. 다만 조금의 차이가 있는데, 전자는 서버 템플릿 엔진이라고 불리며 후자는 클라이언트 템플릿 엔진이라 불린다.

**서버 템플릿 엔진**은 <u>서버에서 구동</u>되며, 화면 생성은 서버에서 Java 코드로 문자열을 만든 뒤 이 문자열을 HTML로 변환하여 브라우저로 전달한다.
반면에 **클라이언트 템플릿 엔진**은 <u>브라우저 위에서 작동</u>한다. 브라우저에서 작동될 때는 서버 템플릿 엔진의 손을 벗어나 제어할 수 없다. React.js나 Vue.js를 이용한 SPA(Single Page Application)는 브라우저에서 화면을 생성한다. 서버에서 이미 코드가 벗어난 경우다. 그래서 서버에서는 JSON 혹은 XML 형식의 데이터만 전달하고 클라이언트에서 조립한다. 

### Mustache?

[머스테치](http://mustache.github.io)는 **수많은 언어를 지원하는 가장 심플한 템플릿 엔진**이다.
현존하는 대부분의 언어를 지원하다보니 자바에서 사용될 때는 서버 템플릿 엔진으로, 자바스크립트에서 사용될 때는 클라이언트 템플릿 엔진으로 모두 사용할 수 있다. 자바에서는 JSP, Velocity, Freemarker, Thymeleaf 등의 서버 템플릿 엔진이 존재하지만 책의 저자가 생각한 **단점**은 다음과 같다.

*   **JSP, Velocity**
    스프링 부트에서는 권장하지 않는다. (?)
*   **Freemarker**
    너무 과하게 많은 기능을 지원한다.
    높은 자유도로 인해 숙련도가 낮을 수록 Freemarker안에 비즈니스 로직이 추가될 확률이 높다.
*   **Thymeleaf**
    스프링 진영에서 적극적으로 밀고있지만 문법이 어렵다.
    HTML 태그에 속성으로 템플릿 기능을 사용하는 방식이 높은 허들로 느껴지는 경우가 많다.

반면 **머스테치의 장점**은 다음과 같다.

*   문법이 다른 템플릿 엔진보다 심플하다.
*   로직 코드를 사용할 수 없어 View의 역할과 서버의 역할이 명확하게 분리된다.
*   Mustache.jsdㅘ Mustache.java 2가지가 다 있어서 하나의 문법으로 클라이언트/서버 템플릿을 모두 사용 가능하다.

템플릿 엔진은 화면 역할에만 충실해야 한다. 너무 많은 기능을 제공하면 API와 템플릿 엔진, JS가 서로 로직을 나눠 갖게 되어 유지보수하기가 굉장히 어렵다.

### Install Mustache plugin

인텔리제이 커뮤니티 버전을 사용해도 머스테치 플러그인을 사용할 수 있다.
Thymeleaf나 JSP 등은 커뮤니티 버전에서 지원하지 않고 얼티메이트 버전에서만 공식 지원한다.
이 플러그인을 이용하면 문법체크, HTML 문법지원, 자동완성등이 지원된다.

Command + Shift + A의 Action창을 열어 Plugins를 연 다음 Marketplace에서 mustache를 검색하여 Handlebars/Mustache를 설치한다.

## Create a basic page

스프링 부트 프로젝트에서 편하게 사용할 수 있도록 머스테치 스타터 의존성을 build.gradle에 등록한다.

```
implementation('org.springframework.boot:spring-boot-starter-mustache')
```

머스테치는 스프링 부트에서 공식 지원하는 템플릿 엔진이다. 의존성 하나만 추가하면 다른 스타터 패키지와 마찬가지로 추가 설정없이 설치가 끝이다.

머스테치의 파일 위치는 기본적으로 `src/main/resources/templates`이다.
이 위치에 머스테치 파일을 두면 스프링 부트에서 자동으로 로딩한다.
첫 페이지를 담당할 index.mustache를 `src/main/resources/templates`에 생성하고 다음의 코드를 입력한다.

```html
<!DOCTYPE HTML>
<html>
<head>
    <title>스프링 부트 웹서비스</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>
<body>
    <h1>스프링 부트로 시작하는 웹 서비스</h1>
</body>
</html>
```

이 머스테치에 URL을 매핑한다. URL 매핑은 Controller에서 진행한다.
web 패키지 안에 IndexController를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {
    @GetMapping("/")
    public String index() {
        return "index";
    }
}
```

머스테치 스타터 덕분에 Controller에서 문자열을 반환할 때 앞의 경로와 뒤의 파일 확장자는 자동으로 지정된다.
앞의 경로는 `src/main/resources/templates`으로, 뒤의 파일 확장자는 `.mustache`가 붙는 것이다.
즉, 여기선 "index"를 반환하므로 `src/main/resources/templates/index.mustachge`로 전환되어 View Resolver가 처리하게 된다.

이번에도 테스트 코드로 검증해본다.
IndexController에서 Command + Shift + T를 활용하여 Test 클래스를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.springframework.boot.test.context.SpringBootTest.WebEnvironment.RANDOM_PORT;

@ExtendWith(SpringExtension.class)
@SpringBootTest(webEnvironment = RANDOM_PORT)
class IndexControllerTest {
    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    public void 메인페이지_로딩() {
        String body = this.restTemplate.getForObject("/", String.class);

        assertThat(body).contains("스프링 부트로 시작하는 웹 서비스");
    }
}
```

이 테스트는 실제로 URL 호출 시 페이지의 내용이 제대로 호출되는지에 대한 테스트이다.
**HTML도 결국은 규칙이 있는 문자열**이다. TestRestTemplate을 통해 "/"를 호출했을 때 index.mustache에 포함된 코드들이 있는지 확인하면 된다. 전체 코드를 다 검증할 필요는 없으니 "스프링 부트로 시작하는 웹 서비스" 문자열이 포함되어 있는지만 비교한다.

테스트 코드로 검증하면 성공한다.
추가로 실제 화면이 잘 나오는지 확인해보기 위해 Application.java의 main 메소드를 실행하고 브라우저에서 `http://localhost:8080`으로 접속해보면 정상적으로 문자열의 페이지에 노출되는 것을 확인할 수 있다.

## Create post registration screen

HTML만 사용하기보다 오픈소스인 **부트스트랩**을 이용하여 화면을 만들어 본다.
부트스트랩, 제이쿼리 등 FE 라이브러리를 사용할 수 있는 방법은 크게 2가지가 있다. **외부 CDN을 사용**하거나 **직접 라이브러리를 받아서 사용하는 방법**이다. 이번에는 외부 CDN을 사용한다. 본인의 프로젝트에서 직접 내려받아 사용할 필요도 없고, 사용방법도 HTML/JSP/Mustache에 코드만 한 줄 추가하면 되니 간단하다. <u>다만, 실제 서비스에서는 이 방법을 잘 사용하지 않는다. 결국은 외부 서비스에 우리 서비스가 의존하게 되니 CDN을 서비스하는 곳에 문제가 생기면 덩달아 같이 문제가 생기기 때문이다.</u>

2개의 라이브러리 부트스트랩과 제이쿼리를 index.mustache에 레이아웃 방식으로 추가한다.
**레이아웃 방식**이란 <u>공통 영역을 별도의 팡리로 분리하여 필요한 곳에서 가져다 쓰는 방식</u>이다.
이번에 추가할 라이브러리들인 부트스트랩과 제이쿼리는 머스테치 화면 어디서나 필요하다. 매번 해당 라이브러리를 머스테치 파일에 추가하는 것은 귀찮은 일이니 레이아웃 파일들을 만들어 추가한다.
`src/main/resources/templates` 디렉토리에 layout 디렉토리를 추가로 생성한다. 그리고 footer.mustache, header.mustache 파일을 생성하고 다음의 코드를 입력한다.

```html
<!-- header.mustache -->
<!DOCTYPE HTML>
<html>
<head>
    <title>스프링부트 웹서비스</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
```

```html
<!-- footer.mustache -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>
```

코드를 보면 css와 js의 위치가 서로 다르다. **페이지 로딩속도를 높이기 위해** css는 header에, js는 footer에 두었다. HTML은 위에서부터 코드가 실행되기 때문에 head가 다 실행되고서야 body가 실행된다. 즉, head가 다 불러지지 않으면 사용자 쪽에선 백지 화면만 노출된다. 특히 js 용량이 크면클수록 body 부분의 실행이 늦어지기 때문에 js는 body 하단에 두어 화면이 다 그려진 뒤에 호출하는 것이 좋다. 반면, css는 화면을 그리는 역할이므로 head에서 불러오는 것이 좋다. 그렇지 않으면 css가 적용되지 않은 깨진 화면을 사용자가 볼 수 있기 때문이다.
추가로, bootstrap.js의 경우 제이쿼리가 꼭 있어야만 하기 때문에 부트스트랩보다 제이쿼리가 먼저 호출되도록 코드를 작성한다.

라이브러리를 비롯해 기타 HTML 태그들이 모두 레이아웃에 추가되니 이제 index.mustache에는 필요한 코드만 남게 된다. 해당 코드를 다음과 같이 변경한다.

```html
{{>layout/header}}

<h1>스프링 부트로 시작하는 웹 서비스</h1>

{{>layout/footer}}
```

>   {{> }}는 현재 머스테치 파일을 기준으로 다른 파일을 가져온다.

레이아웃으로 파일을 분리했으니 index.mustache에 글 등록 버튼을 하나 추가한다.

```html
{{>layout/header}}

    <h1>스프링 부트로 시작하는 웹 서비스</h1>
    <div class="col-md-12">
        <div class="row">
            <div class="col-md-6">
                <a href="/posts/save" role="button" class="btn btn-primary">글 등록</a>
            </div>
        </div>
    </div>

{{>layout/footer}}
```

여기서는 `<a>`태그를 이용해 글 등록 페이지로 이동하는 글 등록 버튼을 생성했다. 이동할 페이지의 주소는 `/posts/save`이다.

이 주소에 해당하는 Controller를 생성해야 한다. 페이지에 관련된 컨트롤러는 모두 IndexController를 사용한다.
IndexController에 다음의 메소드를 추가한다.

```java
@GetMapping("/posts/save")
public String postsSave() {
    return "posts-save";
}
```

index.mustache와 마찬가지로 `/posts/save`를 호출하면 posts-save.mustache를 호출하는 메소드를 생성했다.

컨트롤러 코드가 생성되었으니 posts-save.mustache 파일을 생성한다. 파일의 위치는 index.mustache와 동일하다.

```html
{{>layout/header}}

<h1>게시글 등록</h1>

<div class="col-md-12">
    <div class="col-md-4">
        <form>
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요">
            </div>
            <div class="form-group">
                <label for="author"> 작성자 </label>
                <input type="text" class="form-control" id="author" placeholder="작성자를 입력하세요">
            </div>
            <div class="form-group">
                <label for="content"> 내용 </label>
                <textarea class="form-control" id="content" placeholder="내용을 입력하세요"></textarea>
            </div>
        </form>
        <a href="/" role="button" class="btn btn-secondary">취소</a>
        <button type="button" class="btn btn-primary" id="btn-save">등록</button>
    </div>
</div>

{{>layout/footer}}
```

UI가 완성되었으니 프로젝트를 실행하고 브라우저에서 `http://localhost:8080/`으로 접근한다.
이후 '글 등록' 이라고 되어있는 버튼을 클릭하면 해당 화면으로 이동한다. 아직 게시글 등록화면의 등록 버튼은 기능이 없다. API를 호출하는 JS가 전혀 없기 때문이다. 그래서 `src/main/resources`에 `statc/js/app`디렉토리를 생성한다. 여기에 index.js 파일을 생성하고 다음의 코드를 입력한다.

```js
var main = {
    init : function () {
        var _this = this;
        $('#btn-save').on('click', function () {
            _this.save();
        });

        $('#btn-update').on('click', function () {
            _this.update();
        });

        $('#btn-delete').on('click', function () {
            _this.delete();
        });
    },
    save : function () {
        var data = {
            title: $('#title').val(),
            author: $('#author').val(),
            content: $('#content').val()
        };

        $.ajax({
            type: 'POST',
            url: '/api/v1/posts',
            dataType: 'json',
            contentType:'application/json; charset=utf-8',
            data: JSON.stringify(data)
        }).done(function() {
            alert('글이 등록되었습니다.');
            window.location.href = '/';
        }).fail(function (error) {
            alert(JSON.stringify(error));
        });
    }
};

main.init();
```

>   Line 31. window.location.href = '/' 는 글 등록이 성공하면 메인페이지로 이동하게 만드는 코드이다.

index.js에서 index라는 변수의 속성으로 function을 추가했다. 만약 index.js에서 function을 작성했다면 index.mustache에서 a.js가 추가되어 a.js도 a.js만의 init과 save function이 있을 경우 나중에 로딩된 js의 init, save가 먼저 로딩된 js의 function을 덮어쓰게 된다. 브라우저의 스코프는 공용공간으로 쓰이기 때문이다.
여러 사람이 참여하는 프로젝트에서는 중복된 함수 이름은 자주 발생한다. 모든 function 이름을 확인하면서 만들 수는 없기 때문이다. 그러므로 이런 문제를 피하기 위해 index.js만의 유효범위를 만들어 사용해야 한다. 방법은 var index라는 객체를 만들어 해당 객체에서 필요한 모든 function을 선언하는 것이다. 이렇게 하면 index 객체 안에서만 function이 유효하기 때문에 다른 JS와 겹칠 위험이 사라진다. (ES6를 비롯한 최신 자바스크립트 버전이나 Angular, React, Vue 등은 이미 이런 기능을 프레임워크 레벨에서 지원하고 있다.)

생성된 index.js를 머스테치 파일이 쓸 수 있게 footer.mustache에 추가한다.

```html
<script src="/js/app/index.js"></script>
```

index.js 호출 코드를 보면 절대 경로(/)로 바로 시작한다. 스프링 부트는 기본적으로 `src/main/resources/static`에 위치한 JS, CSS, Image 등 정적 파일들은 URL에서 /로 설정된다.

모든 코드가 완성되었으니 등록기능을 브라우저에서 직접 테스트해본다.
등록 버튼을 클릭하면 "글이 등록되었습니다."라는 Alert가 노출되고 이후 `localhost:8080/h2-console`로 접속하여 SQL 쿼리로 실제 데이터가 등록되었는지도 확인한다.

## Create a full lookup screen

전체 조회를 위해 index.mustache의 UI를 변경한다.

```html
<br>
<!-- 목록 출력 영역 -->
<table class="table table-horizontal table-bordered">
    <thead class="thead-strong">
    <tr>
        <th>게시글번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>최종수정일</th>
    </tr>
    </thead>
    <tbody id="tbody">
    {{#posts}}
        <tr>
            <td>{{id}}</td>
            <td><a href="/posts/update/{{id}}">{{title}}</a></td>
            <td>{{author}}</td>
            <td>{{modifiedDate}}</td>
        </tr>
    {{/posts}}
    </tbody>
</table>
```

>   {{#posts}}는 posts라는 List를 순호합니다. Java의 for문과 동일하다.
>
>   {{id}}등의 변수명은 List에서 뽑아낸 객체의 필드를 사용한다.

그럼 Controller, Service, Repository 코드를 작성한다. 기존에 있던 PostsRepository 인터페이스에 쿼리를 추가한다.

```java
@Query("SELECT p FROM Posts p ORDER BY p.id DESC")
List<Posts> findAllDesc();
```

>   @Query는 SpringDataJpa에서 제공하지 않는 메소드를 쿼리로 작성할 수 있게 한다.
>
>   규모가 있는 프로젝트에서의 데이터 조회는 FK의 조인, 복잡한 조건 등으로 인해 이런 Entity 클래스만으로 처리하기 어려워 [**조회용 프레임워크*](#Footnote)를 추가로 사용한다.

다음으로 PostsService에 다음의 코드를 추가한다.

```java
@Transactional(readOnly = true)
public List<PostsListResponseDto> findAllDesc() {
    return postsRepository.findAllDesc().stream()
            .map(PostsListResponseDto::new)
            .collect(Collectors.toList());
}
```

>   @Transactional 어노테이션에 추가된 readOnly 값이 true가 되면 트랜잭션 범위는 유지하되, 조회 기능만 남겨두어 조회 속도가 개선되기 때문에 등록, 수정, 삭제 기능이 전혀 없는 서비스 메소드에서 사용하는 것을 추천한다.
>
>   .map(PostsListResponseDto::new)는 람다식으로 .map(posts -> new PostsListResponseDto(posts))와 동일하다.
>   postsRepository 결과로 넘어온 Posts의 Stream을 map을 통해 PostsListResponseDto로 변환하여 List로 반환하는 메소드이다.

PostsListResponseDto를 `web.dto`패키지에 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.web.dto;

import com.tunahg.book.springboot.domain.posts.Posts;
import lombok.Getter;

import java.time.LocalDateTime;

@Getter
public class PostsListResponseDto {
    private Long id;
    private String title;
    private String author;
    private LocalDateTime modifiedDate;
    
    public PostsListResponseDto(Posts entity) {
        this.id = entity.getId();
        this.title = entity.getTitle();
        this.author = entity.getAuthor();
        this.modifiedDate = entity.getModifiedDate();
    }
}
```

마지막으로 IndexController를 변경한다.

```java
package com.tunahg.book.springboot.web;

import com.tunahg.book.springboot.service.posts.PostsService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@RequiredArgsConstructor
@Controller
public class IndexController {
    private final PostsService postsService;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("posts",postsService.findAllDesc());
        return "index";
    }

    @GetMapping("/posts/save")
    public String postsSave() {
        return "posts-save";
    }
}
```

>   Model은 서버 템플릿 엔진에서 사용할 수 있는 객체를 저장할 수 있다. 여기서는 postsService.findAllDesc()로 가져온 결과를 posts로 index.mustache에 전달한다.

Controller까지 모두 완성 되었으니 `http://localhost:8080/`으로 접속한 뒤 등록 화면을 이용해 하나의 데이터를 등록해본다.
그럼 목록 기능이 정상적으로 작동하는 것을 확인할 수 있다.

# Footnote

*   ***조회용 프레임워크**
    대표적으로 querydsl, jooq, MyBatis등이 있다. 조회는 3가지 프레임워크 중 하나를 통해 조회하고 등록/수정/삭제 등은 SpringDataJpa를 통해 진행한다. 책의 저자는 querydsl을 추천한다. querydsl을 추천하는 이유는 다음과 같다.
    *   타입 안정성이 보장된다.
        단순한 문자열로 쿼리를 생성하는 것이 아니라, 메소드를 기반으로 쿼리를 생성하기 때문에 오타나 존재하지 않는 칼럼명을 명시할 경우 IDE에서 자동으로 검출된다. 이 장점은 Jooq에서도 지원하는 장점이지만, MyBatis에서는 지원하지 않는다.
    *   국내 많은 회사에서 사용중이다.
        쿠팡, 배민 등 JPA를 적극적으로 사용하는 회사에서는 Querydsl을 적극적으로 사용중이다.
    *   레퍼런스가 많다.
        2번의 장점으로 이어지는데, 많은 유저가 사용하다보니 그만큼 국내 자료가 많다. 어떤 문제가 발생했을 때 커뮤니티에 질문하고 그에 대한 답변을 들을 수 있다는 점이 큰 장점이다.