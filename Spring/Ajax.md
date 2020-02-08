# Ajax

## JQuery

* *.jsp => WEB-INF/view/
  * 이외의 파일은 DispatcherServlet - Controller - Model - View를 통하여 요청을 처리함.
  * Controller Mapping이 없다면 404 Error가 발생함.
    * webapp/resources/ 에서 탐색함
    * *.png, *.mp3, *.mp4, jquery.js 등의 파일들을 해당위치에서 탐색한다.

```html
<script src="Context/jquery.js"></script>
```

* JQuery를 사용하려면 위처럼 라이브러리를 먼저 로드해야함.
  * 이후 다음과 같이 사용함.

    ```html
    <script>
    	$("h1").css("color", "blue");
        <!-- $("css selector").함수명(매개변수) -->
    </script>
    ```

  * `${}` : EL언어 / `${""}` : Jquery언어 ==> 둘의 혼동에 조심

## HTTP vs Ajax

* HTTP 통신
  * 요청 1 => 서버 처리중 => 응답 1(View) => 요청 2
  * 요청이 들어온 순서대로 처리하여 응답을 보내는 방식.
  * 동기화 방식
* Ajax
  * 요청 1 => 요청 2 => 요청 3 => 서버 처리중 => 응답 3, 2, 1(View)
  * 요청이 들어온 순서와 상관없이 먼저 처리되는 응답을 보내는 방식.
  * 비동기화 방식 (Asynchronous)
  * JQuery 방식으로 새로 만들어짐 (Javascript And Xml)
  * 비동기화 통신에 JQuery방식이 합쳐져 Ajax(Asynchronous Javascript And Xml)

## Usage Example

> Ajax를 사용하여 `<form>`의 버튼을 클릭하였을 때 해당 정보를 가지고 새로운 웹페이지를 만드는 것이 아닌 현재 웹사이트에서 아래의 부분에 특정 정보를 출력하는 기능을 구현한다.

### Setting

* [Maven Repository](https://mvnrepository.com/)에서 jackson을 검색하여 나오는 첫 번째 항목의 2.10.0버전을 선택한다.
  * 해당 항목에서 나오는 maven코드를 복사하여 spring/pom.xml의 `<dependencies>` 내부에 붙여넣는다.
  * 기능을 구현하기 위해서 JSON형태로 변환해서 객체를 넘겨줘야 하는데 그 때 사용한다.

### Step 1

* 로그인 사이트로 보일 View를 먼저 생성한다. (ajax.jsp)

  ```jsp
  <%@ page language="java" contentType="text/html; charset=UTF-8"
      pageEncoding="UTF-8"%>
  <!DOCTYPE html>
  <html>
  <head>
  <meta charset="UTF-8">
  <title></title>
  </head>
  <body>
  	<form action="/mvc/ajaxlogin">
  		아이디<input type=text name="id" id="id"><br>
  		암호<input type="password" name="pw" id="pw"><br>
  		<input type="submit" value="Login">
  		<input id="ajaxbtn" type="button" value="AjaxLogin">
  	</form>
  	
  	<div>
  	
  	</div>
  	<img src="/mvc/resources/images/google.png"><br>
  </body>
  </html>
  ```

  * `<div>`태그에 입력된 정보를 추가할 예정이다.
  * `<img>`태그는 처음에 말했던 .mp3, .png 등의 파일의 위치를 알려주기위하여 만들어 두었다.

* 로그인 사이트로 이동할 간단한 Controller를 먼저 구성한다. (jqueryController.java)

  ```java
  @RequestMapping("/ajaxtest")
  public String ajaxtest() {
  	return "ajax";
  }
  ```

* 서버를 구동하여 /ajaxtest 사이트로 이동하면 로그인 창이 보인다.

### Step 2

* 이제 로그인을 성공했을 때, 성공했다는 true값과 현재 시간을 추가하려고 한다.

  ```java
  @RequestMapping(value="/ajaxlogin2", produces="application/json;charset=utf-8")
  @ResponseBody
  public String ajaxlogin2(String id, String pw) {
  	boolean status = false;
  	String logintime = "---";
  	if(id.equals("ajax") && pw.equals("ajax")) {
  		status = true;
  		logintime = new java.util.Date().toLocaleString();
  	}
  	return "{\"status\": " + status + ", \"time\":\"" + logintime + "\"}";
  	// {"status":true, "time": "2020년 2월 ..."}
  }
  ```

  * `@RequestMapping`의 `produces=`는 Ajax 요청 처리 응답시 강제 한글 인코딩을 UTF-8로 설정한다.
  * `@ResponseBody`는 새로운 View가 아니라 현재 Body에 추가할 내용이라는 뜻의 Annotation이다.
  * 아이디와 암호가 둘다 "ajax"가 입력되었을 때 로그인에 성공한다.
  * 로그인에 성공했다면 true값과 현재 시간을 입력하며 이를 출력한다.
  * 출력에 해당하는 return에서는 JSON방식으로 값을 전달해줘야 하므로 위와같이 작성하였다.
    * `\"`의 의미는 "를 Java에서 문자열을 뜻하는 ""로 사용하는 것이 아닌 문자열 내부에 "를 입력하겠다는 의미다.
    * 주석 처리된 문자열로 return값을 전달해주기 위함이다.

* JSP파일에도 Jquery를 사용하여 Ajax를 추가해주는 코드를 작성한다.

  ```jsp
  <script src="/mvc/resources/jquery-3.2.1.min.js"></script>
  <script>
  	$("#ajaxbtn").on("click", function(){
  		$.ajax({
  			url:'/mvc/ajaxlogin2',
  			data: {"id": $("#id").val(), "pw" : $("#pw").val()},
  			type: 'get',
  			dataType: 'json',
  			success:function(serverdata){
  				// {"status":true, "time": "2020년 2월 ..."}
  				$("div").html(serverdata.status + " - " + serverdata.time);
  				$("div").css("color", "red");
  				$("div").css("border", "2px solid blue");
  			}
  		}); // ajax end
  	}); // on end
  </script>
  ```

  * jquery에서 사용하는 js파일을 먼저 다운로드받고 resources폴더에 넣어놔야한다.
  * id를 사용하여 form의 button을 클릭했을때 작동할 함수를 만들었다.
    * java파일의 메소드를 추가했던 것과 같이 method를 정해준다.
    * data 또한 JSON형식으로 만들어주며 form에서의 아이디와 암호의 id를 가져온다.
    * type은 get과 post방식중 선택한다.
    * datatype은 JSON형식으로 전달할 것이므로 json을 입력한다.
    * success는 해당 기능이 성공적으로 수행했을 때 함수를 만든다.
      * 공백으로 선언한 div태그에 내용을 출력할 것이므로 .html을 사용하여 내용을 추가한다.
      * .css는 확연하게 구분하기위하여 추가한 css태그이다.

* 이제 로그인창에서 ajax/ajax를 아이디와 암호로 입력하고 버튼을 누르면 해당 웹사이트에서 값이 추가되어 출력되는 것을 확인할 수 있다.

### Codes

* [JQuery Controller](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/mvc/JQueryController.java)
* [Ajax JSP File](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/ajax.jsp)
* [JQuery-3.2.1.min.js](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/resources/jquery-3.2.1.min.js)