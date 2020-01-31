# Spring Start

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

* src/main/java에 원하는 Package와 Class파일을 만들며 코딩을 진행한다.