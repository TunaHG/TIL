# Basic JavaScript

> 웹의 표준 프로그래밍 언어

* Java와의 차이점

  | 특징      | Java                                        | JavaScript                                                   |
  | --------- | ------------------------------------------- | ------------------------------------------------------------ |
  | 언어 종류 | 소스 파일을 컴파일하여 실행하는 컴파일 언어 | 브라우저가 소스 코드를 직접 해석하여 실행하는 인터프리트 언어 |
  | 실행 방식 | 자바 가상 기계(JVM)위에서 실행              | 브라우저 위에서 실행                                         |
  | 작성 위치 | 별도의 소스 파일에 작성                     | HTML 파일 안에 삽입 가능                                     |
  | 변수 선언 | 변수의 타입을 반드시 선언해야 함            | 변수의 타입을 선언하지 않아도 사용 가능                      |

* 특징

  * 인터프리트 언어
    * 컴파일 과정을 거치지 않고 바로 실행시킬 수 있는 언어이다.
  * 동적 타이핑
    * 변수의 자료형을 선언하지 않고도 변수를 사용할 수 있다 (`var x;`)
  * 구조적 프로그래밍 지원
    * C언어의 구조적 프로그래밍을 지원한다. (`if-else`, `while`, `for`등의 제어구조 지원)
  * 객체 기반
    * 객체 지향 언어이다. JS에서 객체는 연관 배열이다.
  * 함수형 프로그래밍 지원
    * JS에서 함수는 일급 객체이다. 함수는 그 자체로 객체란 의미며, `.call()`과 같은 메소드를 가진다.
  * 프로토타입 기반
    * 상속을 위해 클래스 개념 대신에 프로토타입을 사용한다.

## Position In HTML

> HTML5가 되면서 `type="text/javascript"`는 선언해주지 않아도 된다.

### 내부 자바스크립트

```html
<script type="text/javascript">
	
</script>
```

* `<head>`와 `<body>` 둘 모두에서 사용가능하지만 보통 `<head>`에 선언하는 편이다. 
  * 그 이유는 `<body>`에 선언되면 선언되기 이후의 `<body>`에서는 사용할 수 없으나 `<head>`에 선언되면 모든 `<body>`에서 사용이 가능하기 때문이다.

### 외부 자바스크립트

```html
<script type="text/javascript" src="{JS Directory}"></script>
```

### In Line

```html
<button type="button" onclick="alert('반갑습니다')">
    버튼
</button>
```

* 동작에 직접 JavaScript를 사용할 수 있다.

## Usage

* 기본 사용방법과 코드 구성 등은 Java와 흡사하다. (자료형, 조건문 등)

* HTML 요소와 값을 주고받는 방법

  ```html
  var v = document.getElementById("{ID}").value;
  document.getElementById("{ID2}").value = v;
  ```

  * HTML 태그를 식별하기 위해 ID속성을 사용한다.
  * `.value`를 이용해 값을 가져온다.
  * 가져온 값을 반대로 대입하여 ID2에 입력할 수도 있다.

* HTML 요소 자체에 접근하는 방법

  ```html
  e = document.getElementById("{ID}");
  e.style.color = "red";
  ```

  * `.value`를 사용하지 않으면 해당 요소 자체에 접근한다.
  * `.style.color`를 이용하여 id가 `{ID}`인 요소의 `style`속성을 변경한다.

### Function

```html
function showDialog(){
	// 실행 코드
	alert("뿅");
}

// Anonymous Function
var bbyong = function(){
	alert("뿅");
}
bbyong();

function back(parameter){

}
back(argument)
```

* `return`을 사용하여 반환값을 정해줄 수 있다.
* 함수로 사용하므로 `parameter`를 선언해서 `argument`를 받도록 할 수 있다.

## Input/Output

* `alert()` : 경고 윈도우를 출력하는 함수
* `confirm()` : 확인이나 취소를 요구하는 윈도우를 출력하는 함수
* `prompt()` : 어떤 사항을 알려주고 답변을 입력할 수 있는 윈도우를 출력하는 함수
* `document.write()` : HTML문서 내에 직접 작성하여 출력하는 함수
  * 페이지가 적재된 후 호출하면 HTML페이지가 다시 씌여진다.
  * `<body>`요소 안에서 다른 요소들과 같이 실행되는 경우에 사용하는 것이 좋다.
* 