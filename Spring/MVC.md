# MVC

Dynamic Web Project 생성

Ver 2.5 선택 >> Spring MVC에서는 Servlet 2.5버전으로 진행되기 때문

Servlet 파일 test 패키지내에 FrontControllerServlet 생성, doget()을 제외한 나머지 삭제

web.xml에서 url pattern을 `/front`로 변경

FrontControllerServlet에서 Tomcat 서버로 실행시키면 웹페이지가 나옴.



url-pattern을 *.mvc 혹은 / 와 같은 것들로 변경하며 확인 (web.xml이 변경되면 웹서버를 Restart해야함)

