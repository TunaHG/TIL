# Chapter 5

>   Implementing the login function with Spring Security and OAuth2.0

Spring Security는 막강한 인증(Authentication)과 인가(Authorization) 기능을 가진 프레임워크다.
사실상 스프링 기반의 애플리케이션에서는 보안을 위한 표준이다. 인터셉터, 필터 기반의 보안 기능을 구현하는 것보다 스프링 시큐리티를 통해 구현하는 것을 적극적으로 권장하고 있다.

## Spring Security & Spring Security OAuth2.0 Client

많은 서비스에서 ID/Passwd 방식보다는 소셜 로그인 기능을 사용한다. OAuth 로그인을 활용하지 않고 직접 구현하면 로그인 시 보안, 비밀번호 찾기, 회원정보 변경 등 여러 기능들도 직접 구현해야하기 때문에 이러한 것들을 구글, 페이스북, 네이버 등에 맡기고 서비스 개발에 집중한다.

스프링 부트 1.5와 2.0에서는 OAuth2 연동 방법이 크게 차이가 있으나, 아래 라이브러리 덕분에 큰 차이가 없게 구현할 수 있다.

```
spring-securit-oauth2-autoconfigure
```

하지만 이 책에서는 스프링 부트 2 방식인 Spring Security Oauth2 Client 라이브러리를 사용하여 진행한다. 그 이유는 다음과 같다.

*   스프링 팀에서 기존 1.5에서 사용되던 spring-security-oauth 프로젝트는 유지 상태로 결정했으며 더는 신규 기능은 추가하지 않고 버그 수정 정도의 기능만 추가될 예정이다. 신규 기능은 새 oauth2 라이브러리에서만 지원하겠다고 선언하였다.
*   스프링 부트용 라이브러리(starter)가 출시되었다.
*   기존에 사용되던 방식은 확장 포인트가 적절하게 오픈되어 있지 않아 직접 상속하거나 오버라이딩 해야 하고 신규 라이브러리의 경우 확장 포인트를 고려해서 설계된 상태이다.

스프링 부트 2 방식의 자료를 찾고 싶은 경우 spring-security-oauth2-autoconfigure 라이브러리를 사용했는지 확인하고 application.properties 혹은 application.yml 정보에 accessTokenUri를 가지고 있는지 확인한다. 가지고있다면 1.5 방식이다. 스프링 부트 1.5 방식에서는 url 주소를 모두 명시해야하지만 2.0 방식에서는 client 인증 정보만 입력하면 된다. 1.5버전에서 입력했던 값들은 2.0버전으로 오면서 모두 enum으로 대체되었다.
CommonOAuth2Provider라는 enum이 새롭게 추가되어 구글, 깃허브, 페이스북, 옥타의 기본 설정값은 모두 여기서 제공한다. 이외에도 다른 소셜 로그인을 추가한다면 직접 다 추가해주어야 한다.

## Google service registration

먼저 구글 서비스에 신규 서비스를 생성해야 한다. 여기서 발급된 인증 정보(clientId, clientSecret)을 통해 로그인 기능과 소셜 서비스 기능을 사용할 수 있으니 무조건 발급받고 시작해야 한다.

[구글 클라우드 플랫폼](https://console.cloud.google.com)으로 이동하여 프로젝트 선택 탭을 눌러 새 프로젝트를 생성한다.
원하는 프로젝트 이름을 설정하고 만들기를 누른다. 생성된 프로젝트를 선택하고 왼쪽 메뉴 탭의 API 및 서비스 카테고리로 이동한다. 카테고리 중간에 있는 사용자 인증 정보를 클릭하고 만들기 버튼을 클릭한다. 
사용자 인증 정보에는 여러 메뉴가 있는데 이 중 이번에 구현할 소셜 로그인은 OAuth 클라이언트 ID로 구현한다. 해당 항목을 클릭한다. 클라이언트 ID가 생성되기 전에 동의 화면 구성이 필요하므로 안내에 따라 버튼을 클릭한다. 
동의화면에 있는 3개의 탭중에 OAuth 동의화면 탭에서 애플리케이션 이름과 지원 이메일을 작성한다. 애플리케이션 이름은 구글 로그인 시 사용자에게 노출될 애플리케이션 이름을 의미하며 지원 이메일은 사용자 동의 화면에서 노출될 이메일 주소다. 지원 이메일의 경우 보통 서비스의 help 이메일 주소를 사용하지만, 여기서는 본인의 이메일 주소를 사용하면 된다. 저장 후 계속을 누르면 Google API의 지원 범위와 테스트 사용자를 변경하는 항목들이 나오는데 변경없이 계속 저장 후 계속을 클릭하여 완료한다.
동의화면 구성이 끝났으면 다시 사용자 인증 정보에서 OAuth 클라이언트 ID 만들기를 클릭한다. 애플리케이션 유형을 웹 애플리케이션으로 선택하고 이름을 변경한 후 아래의 [**승인된 리디렉션 URI*](#Footnote)에 `http://localhost:8080/login/oauth2/code/google`을 추가한다. 이후 만들기를 눌러 생성을 완료한다. 생성된 애플리케이션을 클릭하면 클라이언트ID, 클라이언트 보안 비밀 코드등이 포함된 인증 정보를 확인할 수 있다.

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



# Footnote

*   ***승인된 리디렉션 URI**
    서비스에서 파라미터로 인증 정보를 주었을 때 인증이 성공하면 구글에서 리다이렉트할 URL이다.
    스프링 부트 2 버전의 시큐리티에서는 기본적으로 `{도메인}/login/oauth2/code/{소셜서비스코드}`로 리다이렉트 URL을 지원한다.
    사용자가 별도로 리다이렉트 URL을 지원하는 Controller를 만들 필요가 없다.
    AWS 서버에 배포하게 되면 localhost 외에 추가로 주소를 추가해야한다.