# Chapter 5

>   Implementing the login function with Spring Security and OAuth2.0

Spring Security는 막강한 **인증(Authentication)**과 **인가(Authorization)** 기능을 가진 프레임워크다.
사실상 스프링 기반의 애플리케이션에서는 보안을 위한 표준이다. 인터셉터, 필터 기반의 보안 기능을 구현하는 것보다 스프링 시큐리티를 통해 구현하는 것을 적극적으로 권장하고 있다.

## Spring Security & Spring Security OAuth2.0 Client

많은 서비스에서 ID/Passwd 방식보다는 **소셜 로그인 기능**을 사용한다. OAuth 로그인을 활용하지 않고 직접 구현하면 로그인 시 보안, 비밀번호 찾기, 회원정보 변경 등 여러 기능들도 직접 구현해야하기 때문에 이러한 것들을 구글, 페이스북, 네이버 등에 맡기고 서비스 개발에 집중한다.

스프링 부트 1.5와 2.0에서는 OAuth2 연동 방법이 크게 차이가 있으나, 아래 라이브러리 덕분에 큰 차이가 없게 구현할 수 있다.

```
spring-securit-oauth2-autoconfigure
```

하지만 이 책에서는 스프링 부트 2 방식인 **Spring Security Oauth2 Client 라이브러리**를 사용하여 진행한다. 그 이유는 다음과 같다.

*   스프링 팀에서 기존 1.5에서 사용되던 spring-security-oauth 프로젝트는 유지 상태로 결정했으며 더는 신규 기능은 추가하지 않고 버그 수정 정도의 기능만 추가될 예정이다. 신규 기능은 새 oauth2 라이브러리에서만 지원하겠다고 선언하였다.
*   스프링 부트용 라이브러리(starter)가 출시되었다.
*   기존에 사용되던 방식은 확장 포인트가 적절하게 오픈되어 있지 않아 직접 상속하거나 오버라이딩 해야 하고 신규 라이브러리의 경우 확장 포인트를 고려해서 설계된 상태이다.

스프링 부트 2 방식의 자료를 찾고 싶은 경우 spring-security-oauth2-autoconfigure 라이브러리를 사용했는지 확인하고 application.properties 혹은 application.yml 정보에 accessTokenUri를 가지고 있는지 확인한다. 가지고있다면 1.5 방식이다. 스프링 부트 1.5 방식에서는 url 주소를 모두 명시해야하지만 2.0 방식에서는 client 인증 정보만 입력하면 된다. 1.5버전에서 입력했던 값들은 2.0버전으로 오면서 모두 enum으로 대체되었다.
CommonOAuth2Provider라는 enum이 새롭게 추가되어 구글, 깃허브, 페이스북, 옥타의 기본 설정값은 모두 여기서 제공한다. 이외에도 다른 소셜 로그인을 추가한다면 직접 다 추가해주어야 한다.

## Google service registration

먼저 구글 서비스에 **신규 서비스를 생성**해야 한다. 여기서 발급된 <u>인증 정보(clientId, clientSecret)</u>을 통해 로그인 기능과 소셜 서비스 기능을 사용할 수 있으니 무조건 발급받고 시작해야 한다.

1.  [구글 클라우드 플랫폼](https://console.cloud.google.com)으로 이동하여 프로젝트 선택 탭을 눌러 새 프로젝트를 생성한다.
2.  원하는 프로젝트 이름을 설정하고 만들기를 누른다. 
3.  생성된 프로젝트를 선택하고 왼쪽 메뉴 탭의 API 및 서비스 카테고리로 이동한다. 카테고리 중간에 있는 사용자 인증 정보를 클릭하고 만들기 버튼을 클릭한다. 
4.  사용자 인증 정보에는 여러 메뉴가 있는데 이 중 이번에 구현할 소셜 로그인은 OAuth 클라이언트 ID로 구현한다. 해당 항목을 클릭한다. 클라이언트 ID가 생성되기 전에 동의 화면 구성이 필요하므로 안내에 따라 버튼을 클릭한다. 
5.  동의화면에 있는 3개의 탭중에 OAuth 동의화면 탭에서 애플리케이션 이름과 지원 이메일을 작성한다. 애플리케이션 이름은 구글 로그인 시 사용자에게 노출될 애플리케이션 이름을 의미하며 지원 이메일은 사용자 동의 화면에서 노출될 이메일 주소다. 지원 이메일의 경우 보통 서비스의 help 이메일 주소를 사용하지만, 여기서는 본인의 이메일 주소를 사용하면 된다. 저장 후 계속을 누르면 Google API의 지원 범위와 테스트 사용자를 변경하는 항목들이 나오는데 변경없이 계속 저장 후 계속을 클릭하여 완료한다.
6.  동의화면 구성이 끝났으면 다시 사용자 인증 정보에서 OAuth 클라이언트 ID 만들기를 클릭한다. 애플리케이션 유형을 웹 애플리케이션으로 선택하고 이름을 변경한 후 아래의 [**승인된 리디렉션 URI*](#Footnote)에 `http://localhost:8080/login/oauth2/code/google`을 추가한다. 이후 만들기를 눌러 생성을 완료한다. 생성된 애플리케이션을 클릭하면 클라이언트ID, 클라이언트 보안 비밀 코드등이 포함된 인증 정보를 확인할 수 있다.

이제 클라이언트 ID와 보안 비밀코드를 프로젝트에서 설정한다.
application.properties 파일이 있는 `src/main/resources` 디렉토리에 application-oauth.properties 파일을 생성하고 다음의 값을 입력한다.

```properties
spring.security.oauth2.client.registration.google.client-id={Client ID}
spring.security.oauth2.client.registration.google.client-secret={Client Secret}
spring.security.oauth2.client.registration.google.scope=profile,email
```

>   많은 예제에서 scope=profile,email을 별도로 등록하지 않는다. 기본값이 openid, proefile, email이기 때문이다. 강제로 openid를 제외한 이유는 openid라는 scope가 있으면 Open Id Provider로 인식하기 때문이다. 그렇게 되면 OpenId Provider인 서비스(구글)와 그렇지 않은 서비스(네이버/카카오)로 나눠서 각각 OAuth2Service를 만들어야 한다. 하나의 OAuth2Service로 사용하기 위해 일부러 openid scope를 제외하고 등록한다.

스프링 부트에서는 properties의 이름을 application-xxx.properties로 만들면 xxx라는 이름의 profile이 생성되어 이를 통해 관리할 수 있다. 즉, profile=xxx라는 식으로 호출하면 해당 properties의 설정들을 가져올 수 있다는 것이다. 호출하는 방식은 여러 방식이 있지만 여기서는 스프링 부트 기본 설정 파일인 appliation.propertis에서 application-oath.properties를 포함하도록 구성한다. application.properties에 다음의 코드를 추가한다.

```properties
spring.profiles.include=oauth
```

이제 oauth 설정값을 사용할 수 있다.

구글 로그인을 위한 ClientId와 ClientSecret은 보안이 중요한 정보들이다. 이들이 외부에 노출될 경우 언제든 개인정보를 가져갈 수 있는 취약점이 될 수 있다. 보안을 위해 appliation-oauth.properties 파일이 깃허브에 올라가는 것을 방지해야 한다. 그를 위해 .gitignore 파일에 다음의 코드를 추가한다.

```
application-oauth.properties
```

추가한 뒤 커밋했을 때 커밋파일 목록에 application-oauth.properties가 나오지 않으면 성공이다.

## Integrating Google Login

구글의 로그인 인증 정보를 발급 받았으니 프로젝트 구현을 진행한다. 사용자 정보를 담당할 도메인인 User 클래스를 생성한다. 패키지는 domain 아래에 user 패키지를 생성하고 User 클래스에 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.domain.user;

import com.tunahg.book.springboot.domain.BaseTimeEntity;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Getter
@NoArgsConstructor
@Entity
public class User extends BaseTimeEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String email;

    @Column
    private String picture;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Role role;

    @Builder
    public User(String name, String email, String picture, Role role) {
        this.name = name;
        this.email = email;
        this.picture = picture;
        this.role = role;
    }

    public User update(String name, String picture) {
        this.name = name;
        this.picture = picture;

        return this;
    }
    
    public String getRoleKey() {
        return this.role.getKey();
    }
}
```

>   @Enumerated(EnumType.STRING)은 JPA로 데이터베이스를 저장할 때 Enum 값을 어떤 형태로 저장할지를 결정한다.
>   기본적으로 int로 된 숫자가 저장된다. 숫자로 저장되면 데이터베이스를 확인할 때 그 값이 무슨 코드를 의미하는지 알 수가 없다. 그래서 문자열로 저장될 수 있도록 선언한다.

각 사용자의 권한을 관리할 Enum Class인 Role을 생성한다. Role Class에는 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.domain.user;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role {
    GUEST("ROLE_GUEST", "손님"),
    USER("ROLE_USER", "일반 사용자");

    private final String key;
    private final String title;
}
```

Spring Security에서는 권한 코드에 항상 **ROLE_**이 앞에 붙어 있어야만 한다. 그래서 코드별 키 값을 ROLE_GUEST, ROLE_USER 등으로 지정한다.

마지막으로 User의 CRUD를 책임질 UserRepository도 생성한다. UserRepository에는 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}
```

>   findByEmail은 소셜로그인으로 반환되는 값 중 email을 통해 이미 생성된 사용자인지 처음 가입하는 사용자인지 판단하기 위한 메소드이다.

User Entity 관련 코드를 모두 작성했으니 본격적으로 시큐리티 설정을 진행한다.

### Setting Spring Security

먼저 build.gradle에 스프링 시큐리티 관련 의존성 하나를 추가한다.

```
implementation('org.springframework.boot:spring-boot-starter-oauth2-client')
```

>   소셜 로그인 등 클라이언트 입장에서 소셜 기능 구현 시 필요한 의존성이다. spring-security-oauth2-client와 spring-security-oauth2-jose를 기본으로 관리해준다.

설정이 끝났으면 OAuth 라이브러리를 이용한 소셜 로그인 설정 코드를 작성한다.
**config.auth** 패키지를 생성한다. 앞으로 시큐리티 관련 클래스는 모두 이곳에 담는다.
SecurityConfig 클래스를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.config.auth;

import com.tunahg.book.springboot.domain.user.Role;
import lombok.RequiredArgsConstructor;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@RequiredArgsConstructor
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    private final CustomOAuth2UserService customOAuth2UserService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .headers().frameOptions().disable()
                .and()
                    .authorizeRequests()
                    .antMatchers("/", "/css/**", "/images/**", "/js/**", "/h2-console/**").permitAll()
                    .antMatchers("/api/v1/**").hasRole(Role.USER.name())
                    .anyRequest().authenticated()
                .and()
                    .logout()
                        .logoutSuccessUrl("/")
                .and()
                    .oauth2Login()
                        .userInfoEndpoint()
                            .userService(customOAuth2UserService);
    }
}
```

>   @EnableWebSecurity는 Spring Security 설정들을 활성화시켜준다.
>
>   csrf().disable().header().frameOptions().disable()은 h2-console 화면을 사용하기 위해 해당 옵션들을 Disable한다.
>
>   authorizeRequests는 URL별 권한 관리를 설정하는 옵션의 시작점이다. 이게 선언되어야만 antMatchers 옵션을 사용할 수 있다.
>
>   antMatchers()는 권한 관리 대상을 지정하는 옵션이다. URL, HTTP 메소드별로 관리가 가능하다. "/" 등 지정된 URL들은 permitAll()옵션을 통해 전체 열람권한을 주었으며 "/api/v1/**"주소를 가진 API는 USER권한을 가진 사람만 가능하도록 했다.
>
>   anyRequest는 설정된 값들 이외 나머지 URL들을 나타낸다. 여기서는 authenticated()를 추가하여 나머지 URL들은 모두 인증된 사용자들에게만 허용하도록 했다. 인증된 사용나는 로그인한 사용자를 의미한다.
>
>   logout().logoutSuccessUrl("/")은 로그아웃 기능에 대한 여러 설정의 진입점으로 성공시 / 주소로 이동한다.
>
>   oauth2Login은 OAuth 2 로그인 기능에 대한 여러 설정의 진입점이다. userInfoEndpoint()는 로그인 성공 이후 사용자 정보를 가져올 때의 설정들을 담당하며 userService()는 소셜 로그인 성공 시 후속 조치를 진행할 UserService 인터페이스의 구현체를 등록한다. 리소스 서버(소셜 서비스들)에서 사용자 정보를 가져온 상태에서 추가로 진해하고자 하는 기능을 명시할 수 있다.

설정 코드 작성이 끝났으니 CustomOAuth2UserService 클래스를 생성한다. 이 클래스에서는 구글 로그인 이후 가져온 사용자의 정보들을 기반으로 가입 및 정보수정, 세션 저장 등의 기능을 지원한다. 클래스에 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.config.auth;

import com.tunahg.book.springboot.domain.user.User;
import com.tunahg.book.springboot.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.Collections;

@RequiredArgsConstructor
@Service
public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
    private final UserRepository userRepository;
    private final HttpSession httpSession;
    
    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2UserService<OAuth2UserRequest, OAuth2User> delegate = new DefaultOAuth2UserService();
        OAuth2User oAuth2User = delegate.loadUser(userRequest);
        
        String registrationId = userRequest.getClientRegistration().getRegistrationId();
        String userNameAttributeName = userRequest.getClientRegistration().getProviderDetails()
                .getUserInfoEndpoint().getUserNameAttributeName();
        
        OAuthAttributes attributes = OAuthAttributes.of(registrationId, userNameAttributeName, oAuth2User.getAttributes());

        User user = saveOrUpdate(attributes);
        httpSession.setAttribute("user", new SessionUser(user));
        
        return new DefaultOAuth2User(Collections.singleton(new SimpleGrantedAuthority(user.getRoleKey())), 
                attributes.getAttributes(), attributes.getNameAttributesKey());
    }
    
    private User saveOrUpdate(OAuthAttributes attributes) {
        User user = userRepository.findByEmail(attributes.getEmail())
                .map(entity -> entity.update(attributes.getName(), attributes.getPicture()))
                .orElse(attributes.toEntity());
        
        return userRepository.save(user);
    }
}
```

>   registrationId는 현재 로그인 진행 중인 서비스를 구분하는 코드이다. 지금은 구글만 사용하는 불필요한 값이지만, 이후 네이버 로그인 연동시에 네이버 로그인인지 구글 로그인인지 구분하기 위해 사용한다.
>
>   userNameAttributeName은 OAuth2 로그인 진행 시 키가 되는 필드값을 의미한다. PK와 같은 의미이다. 구글의 경우 기본적으로 코드를 지원하지만(sub), 네이버 카카오 등은 기본 지원하지 않는다. 이후 네이버 로그인과 구글 로그인을 동시 지원할 때 사용된다.
>
>   OAuthAttributes는 OAuth2UserService를 통해 가져온 OAuth2User의 attribute를 담을 클래스이다. 이후 네이버 등 다른 소셜 로그인도 이 클래스를 사용한다.
>
>   SessionUser는 세션에 사용자 정보를 저장하기 위한 Dto 클래스이다.

구글 사용자 정보가 업데이트 되었을 때를 대비하여 update 기능도 같이 구현하였다. 사용자의 이름이나 프로필 사진이 변경되면 User 엔티티에도 반영된다.

CustomOAuth2UserService 클래스까지 생성되었다면 OAuthAttributes 클래스를 생성한다. 이는 Dto로 볼 수 있으므로 config.auth.dto 패키지를 만들어서 해당 패키지에 클래스를 생성한다. 클래스의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.config.auth.dto;

import com.tunahg.book.springboot.domain.user.Role;
import com.tunahg.book.springboot.domain.user.User;
import lombok.Builder;
import lombok.Getter;

import java.util.Map;

@Getter
public class OAuthAttributes {
    private Map<String, Object> attributes;
    private String nameAttributeKey;
    private String name;
    private String email;
    private String picture;
    
    @Builder
    public OAuthAttributes(Map<String, Object> attributes, String nameAttributeKey, String name, String email, String picture) {
        this.attributes = attributes;
        this.nameAttributeKey = nameAttributeKey;
        this.name = name;
        this.email = email;
        this.picture = picture;
    }
    
    public static OAuthAttributes of(String registrationId, String userNameAttributeName, Map<String, Object> attributes) {
        return ofGoogle(userNameAttributeName, attributes);
    }
    
    public static OAuthAttributes ofGoogle(String userNameAttributeName, Map<String, Object> attributes) {
        return OAuthAttributes.builder()
                .name((String) attributes.get("name"))
                .email((String) attributes.get("email"))
                .picture((String) attributes.get("picture"))
                .attributes(attributes)
                .nameAttributeKey(userNameAttributeName)
                .build();
    }
    
    public User toEntity() {
        return User.builder()
                .name(name)
                .email(email)
                .picture(picture)
                .role(Role.GUEST)
                .build();
    }
}
```

>   of()는 OAuth2User에서 반환하는 사용자 정보는 Map이기 때문에 값 하나하나를 변환해야 해서 사용한다.
>
>   toEntity()는 User 엔티티를 생성한다. OAuthAttributes에서 엔티티를 생성하는 시점은 처음 가입할 때이다. 가입할 대의 기본 권한을 GUEST로 주기 위해서 role 빌더값에는 Role.GUEST를 사용한다.

같은 패키지에 SessionUser 클래스를 생성하고 다음의 코드를 입력한다.

```java
package com.tunahg.book.springboot.config.auth.dto;

import com.tunahg.book.springboot.domain.user.User;
import lombok.Getter;

@Getter
public class SessionUser {
    private String name;
    private String email;
    private String picture;

    public SessionUser(User user) {
        this.name = user.getName();
        this.email = user.getEmail();
        this.picture = user.getPicture();
    }
}
```

SessionUser에는 인증된 사용자 정보만 필요하다. 그 외에 필요한 정보들은 없으니 name, email, picture만 필드로 선언한다.

**왜 User 클래스를 사용하지 않고 SessionUser 클래스를 사용했는가?**
User 클래스를 그대로 사용하면 직렬화를 구현하지 않았다는 의미의 에러가 발생한다. 오류를 해결하기 위해 User 클래스에 직렬화 코드를 넣으면 다른 문제가 발생한다. User 클래스가 엔티티이기 때문에 발생하는 문제다. 엔티티 클래스는 언제 다른 엔티티와 관계가 형성될지 모른다. 다른 자식 클래스를 가지고 있다면 직렬화 대상에 자식들까지 포함되니 성능이슈, 부수효과가 발생할 확률이 높다. 그래서 직렬화 기능을 가진 세션 Dto를 하나 추가로 만드는 것이 이후 운영 및 유지보수 때 많은 도움이 된다.

### Test login

모든 Security 설정이 끝났다. 화면에 로그인 버튼을 추가하여 로그인 기능을 테스트해본다.
index.mustache에 로그인 버튼과 성공시 사용자 이름을 보여주는 코드를 추가로 작성한다.

```html
<a href="/posts/save" role="button" class="btn btn-primary">글 등록</a>
{{#userName}}
    Logged in as: <span id="user">{{userName}}</span>
    <a href="/logout" class="btn btn-info active" role="button">Logout</a>
{{/userName}}
{{^userName}}
    <a href="/oauth2/authorization/google" class="btn btn-success active" role="button">Google Login</a>
{{/userName}}
```

>   {{#userName}} 머스테치는 다른언어와 같은 if문을 제공하지 않는다. true/false 여부만 판별하므로 머스테치에는 항상 최종값을 넘겨줘야 한다. 여기서도 역시 userName이 있다면 userName을 노출시키도록 구성한 것이다.
>
>   a href="/logout"은 스프링 시큐리티에서 기본적으로 제공하는 로그아웃 URL이다. 개발자가 별도로 URL에 해당하는 컨트롤러를 만들 필요가 없다. SecurityConfig 클래스에서 URL을 변경할 순 있지만 기본 URL을 사용해도 충분하니 그대로 진행한다.
>
>   {{^userName}} 머스테치에서 해당 값이 존재하지 않는 경우에 ^를 사용한다. userName이 없다면 로그인 버튼을 노출시키도록 구성했다.
>
>   a href="/oauth2/authorization/google"은 스프링 시큐리티에서 기본적으로 제공하는 로그인 URL이다. 로그아웃 URL과 마찬가지로 개발자가 별도의 컨트롤러를 생성할 필요가 없다.

index.mustache에서 userName을 사용할 수 있게 IndexController에서 userName을 model에 저장하는 코드를 추가한다.

```java
public class IndexController {
    private final PostsService postsService;
    private final HttpSession httpSession;

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("posts",postsService.findAllDesc());
        SessionUser user = (SessionUser) httpSession.getAttribute("user");
        
        if(user != null) {
            model.addAttribute("userName", user.getName());
        }
        
        return "index";
    }
```

>   (SessionUser) httpSession.getAttribute("user")은 앞서 작성된 CustomOAuth2UserService에서 로그인 성공 시 세션에 SessionUser를 저장하도록 구성했다. 즉, 로그인 성공시 httpSession.getAttribute("user")로 값을 가져올 수 있다.
>
>   if(user != null)은 세션에 저장된 값이 있을 때만 model에 userName으로 등록한다. 저장된 값이 없으면 model엔 아무런 값이 없는 상태이니 로그인 버튼이 보이게 된다.

Application을 실행하고 테스트를 진행한다.
메인 화면에서 구글로그인 버튼을 클릭하여 구글 로그인 동의화면으로 넘어가고, 로그인을 진행하면 구글 계정에 등록된 이름과 로그아웃 버튼이 화면에 노출되는 것을 확인할 수 있다.
이후 h2-console로 접속하여 User테이블을 확인해보면 구글 계정이 정상적으로 데이터베이스에 들어간 것까지 확인할 수 있다.
이후 권한 관리에 대해서도 확인해 본다.
현재 로그인된 사용자의 권한은 GUEST인데, 이 상태에서는 posts 기능을 전혀 사용할 수 없다. 글 등록 버튼을 눌러보면 403 권한 거부 에러가 발생한다.
H2-console로 이동하여 사용자의 role을 USER로 변경하고 다시 진행하면 정상적으로 동작하는 것을 확인할 수 있다.

## Annotation-based improvement

지금까지 작성한 코드에서 IndexController 부분의 세션값을 가져오는 부분을 개선한다.
index 메소드외에 다른 컨트롤러와 메소드에서 세션값이 필요하면 그때마다 직접 세션에서 값을 가져와야 하기 때문이다. 같은 코드가 계속해서 반복되는 것은 불필요하므로 이 부분을 **메소드 인자로 세션값을 바로 받을 수 있도록 변경**한다.

Config.auth 패키지에 다음과 같이 @LoginUser 어노테이션을 생성한다. 해당 어노테이션의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.config.auth;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.PARAMETER)
@Retention(RetentionPolicy.RUNTIME)
public @interface LoginUser {
}
```

>   @Target(ElementType.PARAMETER)은 어노테이션이 생성될 수 있는 위치를 지정한다. PARAMETER로 지정했으니 메소드의 파라미터로 선언된 객체에서만 사용할 수 있다. 이 외에도 클래스 선언문에 쓸 수 있는 TYPE 등이 있다.
>
>   @interface는 파일을 어노테이션 클래스로 지정한다. LoginUser라는 이름을 가진 어노테이션이 생성되었다고 생각하면 된다.

같은 위치에 LoginUserArgumentResolver를 생성한다. Login-UserArgumentResolver라는 HandlerMethodArgumentResolver 인터페이스를 구현한 클래스다. HandlerMethodArgumentResolver는 한 가지 기능을 지원한다. 바로 조건에 맞는 경우 메소드가 있다면 구현체가 지정한 값으로 해당 메소드의 파라미터를 넘길 수 있다는 것이다. 해당 클래스의 코드는 다음과 같다.

```java
package com.tunahg.book.springboot.config.auth;

import com.tunahg.book.springboot.config.auth.dto.SessionUser;
import lombok.RequiredArgsConstructor;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Component
public class LoginUserArgumentResolver implements HandlerMethodArgumentResolver {
    private final HttpSession httpSession;

    @Override
    public boolean supportsParameter(MethodParameter parameter) {
        boolean isLoginUserAnnotation = parameter.getParameterAnnotation(LoginUser.class) != null;
        boolean isUserClass = SessionUser.class.equals(parameter.getParameterType());
        return isLoginUserAnnotation && isUserClass;
    }

    @Override
    public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer, NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {
        return httpSession.getAttribute("user");
    }
}
```

>   supportsParameter()은 컨트롤러 메소드의 특정 파라미터를 지원하는지 판단하는 메소드이다. 여기서는 파라미터에 @LoginUser 어노테이션이 붙어있고, 파라미터 클래스타입이 SessionUser.class인 경우 true를 반환한다.
>
>   resolveArgument()는 파라미터에 전달할 객체를 생성하는 메소드이다. 여기서는 세션에서 객체를 가져온다.

이제 @LoginUser를 사용하기 위한 환경은 구성되었다. 이렇게 생성된 LoginUserArgumentResolver가 스프링에서 인식될 수 있도록 WebMvcConfigurer에 추가한다. config 패키지에 WebConfig 클래스를 생성하여 다음과 같은 코드를 입력한다.

```java
package com.tunahg.book.springboot.config;

import com.tunahg.book.springboot.config.auth.LoginUserArgumentResolver;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@RequiredArgsConstructor
@Configuration
public class WebConfig implements WebMvcConfigurer {
    private final LoginUserArgumentResolver loginUserArgumentResolver;

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> resolvers) {
        resolvers.add(loginUserArgumentResolver);
    }
}
```

HandlerMethodArgumentResolver는 항상 WebMvcConfigurer의 addArgumentResolvers()를 통해 추가해야 한다.

모든 설정이 끝났으니 IndexController의 코드에서 반복되는 부분들을 모두 @LoginUser로 개선한다.

```java
@RequiredArgsConstructor
@Controller
public class IndexController {
    private final PostsService postsService;

    @GetMapping("/")
    public String index(Model model, @LoginUser SessionUser user) {
        model.addAttribute("posts",postsService.findAllDesc());

        if(user != null) {
            model.addAttribute("userName", user.getName());
        }

        return "index";
    }
```

>   @LoginUser SessionUser user은 기존에 (User) httpSession.getAttribute("user")로 가져오던 세션 정보 값을 개선한 것이다. 이제는 어느 컨트롤러에서도 @LoginUser를 사용하면 세션 정보를 가져올 수 있게 되었다.

## Using a database as a session store

지금 만든 서비스는 애플리케이션을 재실행하면 로그인이 풀린다. 세션이 내장 톰캣의 메모리에 저장되기 때문이다. 기본적으로 세션은 실행되는 WAS의 메모리에서 저장되고 호출된다. 메모리에 저장되다 보니 내장 톰캣처럼 애플리케이션 실행 시 실행되는 구조에선 항상 초기화된다. 즉, 배포할 때마다 톰캣이 재시작되는 것이다. 이외에도 문제가 하나 더있다. 2대 이상의 서버에서 서비스하고 있다면 톰캣마다 세션 동기화 설정을 해야만 한다. 그래서 실제 현업에서는 세션 저장소에 대해 다음의 3가지 중 하나를 선택한다.

*   **톰캣 세션을 사용한다.**
    일반적으로 별다른 설정을 하지 않을 때 기본적으로 선택되는 방식이다.
    이렇게 될 경우 톰캣(WAS)에 세션이 저장되기 때문에 2대 이상의 WAS가 구동되는 환경에서는 톰캣들 간의 세션 공유를 위한 추가 설정이 필요하다.
*   **MySQL과 같은 데이터베이스를 세션 저장소로 사용한다.**
    여러 WAS간의 공용 세션을 사용할 수 있는 가장 쉬운 방법이다.
    많은 설정이 필요 없지만, 결국 로그인 요청마다 DB I/O가 발생하여 성능상 이슈가 발생할 수 있다.
    보통 로그인 요청이 많이 없는 백오피스, 사내 시스템 용도에서 사용한다.
*   **Redis, Memcached와 같은 메모리DB를 세션저장소로 사용한다.**
    B2C 서비스에서 가장 많이 사용하는 방식이다.
    실제 서비스로 사용하기 위해서는 Embedded Redis와 같은 방식이 아닌 외부 메모리 서버가 필요하다.

여기서는 두 번째 방식인 데이터베이스를 세션 저장소로 사용하는 방식을 선택하여 진행한다. 설정이 간단하고 사용자가 많은 서비스가 아니며 비용을 절감하기 위해서 두 번째 방식을 선택했다.
이후 AWS에 서비스를 배포하고 운영할 때를 생각하면 레디스와 같은 메모리 DB를 사용하기는 부담스럽다. 별도로 사용료를 지불해야 하기 때문이다. 사용자가 없는 현재 단계에서는 데이터베이스로 모든 기능을 처리하는게 부담이 적다.

먼저 build.gradle에 의존성을 등록한다. Spring-session-jdbc는 현재 상태에선 바로 사용할 수 없다. spring web, spring jpa와 마찬가지로 의존성이 추가되어 있어야 사용할 수 있다.

```
implementation('org.springframework.session:spring-session-jdbc')
```

그리고 application.properties에 세션 저장소를 jdbc로 선택하도록 코드를 추가한다.

```properties
spring.session.store-type=jdbc
```

모두 변경하였으니 다시 Application을 실행하여 로그인을 테스트한 뒤 h2-console로 접속한다. console을 보면 세션을 위한 테이블 2개(SPRING_SESSION, SPRING_SESSION_ATTRIBUTES)가 생성된 것을 확인할 수 있다. JPA로 인해 세션 테이블이 자동 생성되었기 때문에 별도로 해야하는 일은 없다.

세션 저장소를 데이터베이스로 교체했다. 물론 지금은 동일하게 스프링을 재시작하면 세션이 풀린다. H2 기반으로 스프링이 재실행될 때 H2도 재시작되기 때문이다. 이후 AWS로 배포하게 되면 AWS의 데이터베이스인 RDS를 사용하게 되니 이때부터는 세션이 풀리지 않는다.

# Footnote

*   ***승인된 리디렉션 URI**
    서비스에서 파라미터로 인증 정보를 주었을 때 인증이 성공하면 구글에서 리다이렉트할 URL이다.
    스프링 부트 2 버전의 시큐리티에서는 기본적으로 `{도메인}/login/oauth2/code/{소셜서비스코드}`로 리다이렉트 URL을 지원한다.
    사용자가 별도로 리다이렉트 URL을 지원하는 Controller를 만들 필요가 없다.
    AWS 서버에 배포하게 되면 localhost 외에 추가로 주소를 추가해야한다.