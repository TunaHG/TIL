# Chapter 1

> Start spring boot with intelliJ

## IntelliJ

### Eclipse vs IntelliJ

많은 자바 웹 개발자들이 이클립스를 사용하는데, 이클립스에 비해 인텔리제이가 가지는 강점은 다음과 같다.

* 강력한 추천 기능 (Smart Completion)
* 다양한 리팩토링과 디버깅 기능
* 높은 자유도의 깃(Git)
* 프로젝트 시작할 때 인덱싱하여 파일을 비롯한 자원들에 대한 빠른 검색 속도
* HTML과 CSS, JS, XML에 대한 강력한 기능 지원
* 자바, 스프링 부트 버전업에 맞춘 빠른 업데이트

### Install IntelliJ

IntelliJ를 바로 설치할 수도 있지만, 추천하는 방법은 JetBrains사의 Toolbox를 이용하는 방법이 있다.
새로운 버전이 나올경우 Toolbox에서 업데이트를 바로 확인하고 진행할 수 있으며 Settings에서 다양한 기능을 설정할 수 있다.
IntelliJ JVM 옵션 설정 화면을 보면, Maximum Heap Size가 750MB로 되어있는데, 이는 개발 PC의 메모리가 4G 이하일 때를 가정하고 설정된 값이다. 개발 PC의 메모리가 8G라면 1024~2048을, 16G라면 2048~4096을 선택해서 사용하면 된다.

### Create Project in IntelliJ

인텔리제이에는 이클립스의 워크스페이스와 같은 개념이 없다. 프로젝트와 모듈의 개념만 있다.
그래서 모든 프로젝트를 한 번에 불러올 수 없으며, 한 화면에서는 하나의 프로젝트만 열린다.

IntelliJ IDEA에 대한 기본적인 설정들을 진행한 이후 프로젝트 생성화면이 나타나면 Create New Project를 클릭한다.
프로젝트 유형은 Gradle을 선택한다. 
다음으로 프로젝트이름과 저장위치를 선택한다. 아래의 Artifact Coordinates를 열어보면 GroupId와 ArtifactId를 등록하는데 ArtifactId는 위에서 입력한 프로젝트 이름과 동일하게 입력되어 있다. 과정을 끝내면 Gradle 기반의 Java 프로젝트가 생성된다.

### Change gradle project to spring boot project

초기 프로젝트 생성시 Spring Intializer를 사용하면 간단하지만, 그렇게 하면 bundle.gradle의 코드가 무슨역할을 하는지와 의존성 추가가 필요하면 어떻게 해야 할지 등을 모르는 상태로 개발할 수 있기에 Gradle로 시작하였다.

Bundle.gradle의 가장 위에 위치할 코드는 다음과 같다.

```
buildscript {
    ext {
        springBootVersion = '2.1.7.RELEASE'
    }
    repositories {
        mavenCentral()
        jcenter()
    }
}
```

이 코드는 이 프로젝트의 플러그인 의존성 관리를 위한 설정이다. 인텔리제이의 플러그인 관리가 아니다.
`ext`라는 키워드는 build.gradle에서 사용하는 전역변수를 설정하겠다는 의미이며, springBootVersion 전역변수를 생성하고 그 값을 2.1.7.RELEASE로 하겠다는 의미다. 즉, spring-boot-gradle-plugin이라는 스프링 부트 그레이들 플러그인의 2.1.7.RELEASE를 의존성으로 받겠다는 의미다.

다음 코드들은 앞서 선언한 플러그인 의존성들을 적용할 것인지 결정하는 코드다.

```
apply plugin: 'java'
apply plugin: 'eclipse'
apply plugin: 'org.springframework.boot'
apply plugin: 'io.spring.dependency-management'
```

io.spring.dependency-management 플러그인은 스프링 부트의 의존성들을 관리해 주는 플러그인이라 꼭 추가해야 한다.
위 4개의 플러그인은 자바와 스프링 부트를 사용하기 위해서는 필수 플러그인들이니 항상 추가하면 된다.

이후에 들어갈 코드들은 다음과 같다.

```
group 'com.tunahg.book'
version '1.0-SNAPSHOT'

repositories {
    mavenCentral()
    jcenter()
}

dependencies {
    compile('org.springframework.boot:spring-boot-starter-web')
    testCompile('org.springframework.boot:spring-boot-starter-test')
}
```

repositories는 각종 의존성 라이브러리들을 어떤 원격 저장소에서 받을지를 정한다.
mavenCentral과 **jcenter* 두 개의 원격 저장소에서 의존성 라이브러리를 받아온다.

dependencies는 프로젝트 개발에 필요한 의존성들을 선언하는 곳이다.
여기서는 선언한 두 가지를 받도록 되어있다. 커뮤니티버전에서도 **자동완성*이 된다.
compile 메소드 안에 라이브러리 이름의 앞부분만 추가한 뒤 자동완성 단축키(Control + Space)를 사용하면 목록을 볼 수 있다.

의존성 코드는 직접 작성해도 되고, 자동완성으로 만들어도 되지만 특정 버전을 명시하면 안된다.
버전을 명시하지 않아야만 맨 위에 작성한 `org.springframework.boot:spring-boot-gradle-plugin:${springBootVersion}`의 버전을 따라간다. 이렇게 관리할 경우 각 라이브러리들의 버전 관리가 한 곳에 집중되고 버전 충돌 문제도 해결되어 편하게 개발할 수 있다.

책에서 명시된 코드중 작성하지 않은 코드로 `sourceCompatibility`가 있다.
이는 컴파일 옵션에 해당하는 코드로 Java언어의 레벨을 지정한다.
이는 Java 플러그인을 적용한 다음 선언해야 한다. 아니면 Java 플러그인이 값을 초기화해버릴 수 있다.
[Gradle:java 요소들](https://kwonnam.pe.kr/wiki/gradle/java)

코드 작성이 완료되었다면 내 기준에서는 Editor 우측상단에 알림창이 뜨며 변경을 반영하도록 하였다.
책 기준에서는 인텔리제이 우측 아래 Event Log 근처에 변경을 적용할 것인지 묻는 알림이 뜬다.
변경이 완료되면 인텔리제이 우측상단의 Gradle 탭을 클릭해서 의존성들이 잘 받아졌는지 확인한다.

버전업으로 인해 변경된 부분이 존재한다. [책 작성자 블로그 링크](https://jojoldu.tistory.com/539)
책에서 안내한 dependencies로 진행하면 Gradle 7.0에 incompatible한 feature가 존재한다는 warning이 표시된다.
compile()과 testCompile()이 soft deprecated되었기 때문에 발생하는 warning이며 버전이 올라가면서 작성방식에 대한 차이도 생겼다.
변경된 코드는 다음과 같이 작성하면 된다.

```
plugins {
    id 'org.springframework.boot' version '2.4.1'
    id 'io.spring.dependency-management' version '1.0.10.RELEASE'
    id 'java'
}

group 'com.tunahg.book'
version '1.0-SNAPSHOT'

repositories {
    mavenCentral()
    jcenter()
}

test {
    useJUnitPlatform()
}

dependencies {
    implementation('org.springframework.boot:spring-boot-starter-web')
    testImplementation('org.springframework.boot:spring-boot-starter-test')
}
```

[Gradle plugin 사이트](https://plugins.gradle.org/plugin/org.springframework.boot)에서 plugin의 선언방법을 명시하고 있으니 참고한다.
test부분은 JUnit테스트를 위해 넣어주는 부분이다. 
deprecated된 compile()과 testCompile()이 implementation()과 testImplementation()으로 변경되었다.

### Git

인텔리제이에서 Git을 활용한다.

Command + Shift + A 단축키를 사용하여 Action 검색창을 열고 share project on github을 검색한다.
해당 Action을 선택하면 Github로그인 화면이 나온다.
로그인을 완료하면 바로 Initial Commit을 진행하는 메시지가 출력되는데, .idea 폴더를 제외하기 위해 여기서는 커밋을 진행하지 않는다.
이후 .gitignore에 .idea폴더를 입력하여 커밋대상에서 제외한 이후에 커밋을 진행한다.

인텔리제이에서 .gitignore 파일에 대한 기본적인 지원은 없지만 플러그인에서 지원한다.
.ignore 플러그인에서 파일 위치 자동완성, 이그노어 처리 여부 확인, 다양한 이그노어 파일 지원 등의 기능을 가지고 있다.
Command + Shift + A 단축키를 다시 사용하여 Action 창을 열고 plugins로 검색하여 플러그인 설치 팝업창을 연다.
플러그인 설치 팝업창의 Marketplace에서 ignore를 검색하고 설치한다. 인텔리제이를 재시작해야 적용된다.

.gitignore 파일이없다면 생성하고, 있다면 수정한 이후 Command + K를 눌러 Commit할 파일을 선택후 메시지를 작성하고 push한다.

## Footnote

* ***jcenter repository**
  기본적으로 mavenCentral을 많이 사용하지만, 최근에는 라이브러리 업로드 난이도 때문에 jcenter도 많이 사용한다.
  mavenCentral은 이전부터 많이 사용하는 저장소지만, 본인이 만든 라이브러리를 업로드하기 위해서는 많은 과정과 설정이 필요하다. 그러다보니 개발자들이 직접 만든 라이브러리를 업로드하는 것이 힘들어 점점 공유가 안되는 상황이 발생했다.
  최근에 나온 jcenter는 이런 문제점을 개선하여 라이브러리 업로드를 간단하게 하였고, jcenter에 라이브러리를 업로드하면 mavenCentral에도 업로드될 수 있도록 자동화를 할 수 있다.
* ***Dependencies 자동완성**
  인텔리제이는 메이븐 저장소의 데이터를 인덱싱해서 관리하기 때문에 커뮤니티 버전을 사용해도 의존성 자동완성이 가능하다.

* ***Github 로그인 404 에러**
  올바른 아이디와 비밀번호를 입력했는데 404에러가 발생하며 로그인이 안된다.
  그래서 다음 [링크](https://devmg.tistory.com/166)를 참고하여 Token을 발급받고 Use Token을 활용하여 로그인하였다.