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

  * `${}` : EL언어, `${""}` : Jquery언어 ==> 둘의 혼동에 조심



HTTP 통신

> 요청 1 => 서버 처리중 => 응답 1(View) => 요청 2

* 동기화



비동기화

> 요청 1 => 요청 2 => 요청 3 => 서버 처리중 => 응답 3, 2, 1(View)

* 비동기화 통신 JQuery 방식 새로 만듬 => Asynchronous Javascript And Xml (Ajax)



XML

```xml
<user>
    <name>홍길동</name>
    <age>21</age>
</user>
```



JSON (Javascript Object notation)



@ResponseBody => 새로운 View가 아니라 현재 Body에 추가할 내용이라는 뜻의 Annotation