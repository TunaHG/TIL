# JSP

* `<% %>` : Script

* `<%! %>` : 선언문
* `<%= %>` : 표현문

## Request

```jsp
<%
	String name = request.getParameter("name");
%>
```

* `name`이라는 이름으로 넘어온 데이터를 받는 Script를 구성한다.