# HTML5

## Configuration

```HTML
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
```

* `Dynamic Web Project`에서 `WebContent`안에 `HTML`폴더를 생성하여 `HTML File`을 생성한다.
* 위의 `HTML Code`는 파일을 생성할 때 기본으로 만들어지는 코드다.
* `charset`은 보통 `UTF-8`로 입력한다.
  * 매번 변경해주기 불편하므로 `Windows` - `Preferences` - `Web` - `HTML` - `Editor` - `Template`으로 이동하여 `New`를 선택한 후 원하는 제목과 `HTML`패턴을 입력한 후 `Context`를 `New HTML`로 변경한 후 `OK`를 누른다.
  * 이후 새로운 `HTML File`을 만들 때, `Finish`를 바로 누르지 말고 `Next`를 눌러서 나오는 `Template`선택 부분에서 내가 만든 `Template`을 선택하면 다음부터 새로만들 땐 변경해주지 않는 이상 해당 `Template`으로 만들어진다.
* `<title>`안에 웹페이지의 제목표시줄에 나타날 제목을 입력한다.
* `<body>`안에 웹 페이지내에서 보일 내용을 입력한다.

## HTML TAG

> 태그의 시작과 종료를 통합하는 것은 `<br/>`와 같은 방식을 사용한다.

* `<br>` : 줄 바꿈을 의미하는 태그

* `<p>` : 단락을 바꾸는 태그 (줄 바꿈을 진행해주나 여러번을 한번에 넣으면 한번만 줄을 바꿔준다.)

* `<img>` : 이미지를 넣는 태그
  * `alt` : 대상을 나타내는 설명 (오류가 떠서 X박스가 나타났을때 나타남)
  * `src` : 대상의 위치 (절대경로 or 상대경로 or url 등)
  * `width`, `height` : 크기를 담당하는 파라미터
  * `align` : HTML에서 위치를 정렬하는 파라미터
  
* `<!-- -->` : 주석처리 내부에 주석으로 처리하고 싶은 글을 입력하면 됨.

* `<table>` : 표를 넣는 태그
  * `<th>` : 표의 첫 열, 헤더를 의미하는 태그
  * `<tr>` : 표의 행을 의미하는 태그
  * `<td>` : 표의 한 칸을 의미하는 태그
    * `colspan` : 열 병합을 의미하는 태그, 숫자만큼 열의 공간을 차지한다.
    * `rowspan` : 행 병합을 의미하는 태그, 숫자만큼 행의 공간을 차지한다.

* `<style>` : HTML의 스타일을 지정해주는 태그, CSS로 파일을 따로 만들수 있다.

  ```html
  <style type="text/css">
  	table{
  		border: 2pt dotted red;
  		width: 650px;
  		height: 200px;
  	}
  </style>
  ```

  * `table`처럼 특정 태그 혹은 클래스, id를 이용하여 어떤 태그의 스타일을 지정할지 선언한다.
  * `{ }`내부에 스타일을 선언해주면 된다.

* `<a>` : 하이퍼링크를 걸어주는 태그

  * `href` : url을 입력하는 파라미터, 경로를 입력하여 해당하는 파일을 호출할 수도 있다.

    * 페이지 내부에서 위치를 지정하여 해당 위치로 이동할 수 있다.

      `<a name="">`을 이용하여 name을 지정해 준 후 `<a href="#name">`처럼 #name을 이용하여 name이 선언된 위치로 이동한다. name을 선언하지 않고 `#`만 선언하면 현재 페이지로 이동하는 의미다.
      
    * `<a href="mailto:{Email}">`을 이용하여 메일주소를 작성하면 클릭했을때 메일을 보낸다

  * `target` : 링크를 어떻게 열지를 정하는 파라미터

* `&nbsp;` : 태그는 아니나, HTML내부에서 공백을 추가하고 싶은 경우 입력한다.

* `<pre>` : HTML파일에 입력한 모양 그대로 출력하고 싶은경우 사용하는 태그
  
  * 내부에 `<a>`등 HTML태그를 입력하면 태그가 적용된다.
  
* `<xmp>` : `<pre>`와 동일하게 입력한 모양 그대로 출력한다.
  
* `<pre>`와 다르게 HTML태그가 적용되지 않고 그대로 보여진다.
  
* `<i>` : 글자 서식의 *이탤릭체*를 적용하는 태그 (`<em>`과 같은 역할, em을 권장함)

* `<b>` : 글자 서식의 **굵게**를 적용하는 태그 (`<strong>`과 같은 역할, strong을 권장함)

* `<ul>` : Unordered List, 순서가 없는 항목을 의미하는 태그
  
  * `type` : circle, square를 사용하여 항목 이름의 타입을 정해주는 파라미터
  
* `<ol>` : ordered List, 순서가 있는 항목을 의미하는 태그
  * `type` : 'a', 'A', '1', 'i', 'I' 중 하나로 선언하여 해당 항목 이름의 타입을 정해주는 파라미터
  * `start` : 첫 시작 순서를 정해주는 파라미터
  
* `<li>` : `ol`, `ul`에 사용되어 List내의 항목을 만드는 태그

* `<hn>` : n의 자리에 1 ~ 6까지의 숫자가 들어가 글자 크기를 키워줌, 숫자가 작을수로 큼

* `<font>` : 글자크기, 색상, 글자체를 지정 가능한 태그
  * `size` : 글자 크기 지정가능 1~7까지의 숫자가 들어가며 숫자가 클수록 크기도 큼
  * `color` : 글자 색 지정가능, `##ff0000`, `blue`, `rgb(255, 0, 100)`등의 형식 가능
  * `face` : 글자체 지정가능

* `<div>` : 구역을 나눠주는 태그

* `<span>` : div와 같은 방식으로 특정 id와 class를 가져서 해당되는 스타일을 가질 수 있도록 하는 태그

* `<hr>` : 수평선을 그어주는 태그

## Form

```html
<form action="result.jsp" method="{method}">
    <input type="{type}" name="{name}">
</form>
```

* `action=` : `form`의 결과로 어떤 페이지가 호출될 것인지를 정한다.
* `method=` : `get` 또는 `post`방식이 올 수 있다.
  * `get` : 받은 값이 도메인에 전부 표시되는 방식
    * 글자수에 제한이 있다. (255자)
    * 도메인에 전부 표시되기 때문에 보안에 취약하다.
  * `post` : 값이 도메인에 보이지 않게 하는 방식

    * 글자수에 제한이 없다.
    * GET방식보다 약간 보안이 강하다.
    * `JSP`가 아닌 `HTML`로 데이터를 전송하면, 크롬 개발자 도구에서 `Network`의 파일을 살펴보면 전송한 데이터가 뭔지 확인할 수 있다.

* `<Input>`
  * `{type}`은 여러가지가 올 수 있다.
    * `text` : 텍스트를 입력받는 칸이다.
    * `password` : 비밀번호를 입력받는 칸이다.
    * `checkbox` : 체크박스를 만드는 type이다. `value`를 입력받아서 체크박스의 값을 정해줘야한다.
      * `checked`를 추가하여 미리 체크된 상태로 보여줄 수 있다.
    * `radio` : 라디오박스를 만드는 type이다. `checkbox`처럼 `value`를 받아야한다.
    * `submit` : 작성된 데이터를 `action`에 선언된 페이지로 보내주는 전송버튼이다.
    * `reset` : 작성된 데이터를 전부 초기화하여 다시작성하게 하는 버튼이다.
    * `date` : 날짜를 입력받는 칸이다.
      * `datetime-local` : 날짜를 더 쉽게 입력받는 칸이다.
    * `email` : email형식을 입력받는 칸이다. `@`가 없다면 `submit`이 안된다.
    * `file` : 파일첨부를 진행할 때 사용하는 버튼이다.
  * `{name}`은 `JSP`등에서 값을 받을 때 사용하며 데이터 값의 이름이다.
  * 이외에 여러가지 인자가 올수 있다.
    * `maxlength` : 최대 길이를 정해주는 인자
    * `size` : 칸의 크기를 정해주는 인자
* `<select>` : 여러 선택지 중 하나를 선택하는 태그다.
  * `size`를 사용하여 항목지들의 목록을 한번에 몇개를 볼건지 크기를 정해줄 수 있다. 
    `default`값은 1이다.
  * `multiple`을 추가하면 다중 선택이 가능하다.
  * `<option>`을 사용하여 선택지 항목을 만든다.
    * `value=`를 추가하여 선택지별로 구분할 수 있는 값을 정해준다.
* `<textarea>` : 텍스트를 입력할 수 있는 큰 공간을 만든다.
  * `row="" col=""`을 이용하여 공간의 크기를 정해준다.
