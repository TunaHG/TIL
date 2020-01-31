# JavaScript Object

* `with()` : 객체를 로딩하는 함수
  * 로딩된 객체의 메소드를 사용할 수 있다.

## Built-In

> 생성자가 미리 작성되어 있는 객체

* `Date`, `String`, `Array`와 같은 객체가 내장 객체이며 HTML문서를 나타내는 `document`도 내장 객체이다.

### Date

* 생성자

  ```javascript
  new Date() // 현재 날짜와 시간
  new Date(milliseconds) // 1970/01/01 이후의 밀리초
  new Date(dateString) // 다양한 문자열
  new Date(year, month, date[, hour[, minutes[, seconds[, ms]]]])
  ```

* 메소드

  * `getDate()` : 1 ~ 31 반환
  * `getDay()` : 0 ~ 6 반환
  * `getFullYear()` : 4개의 숫자로된 연도 반환
  * `getHours()` : 0 ~ 23 반환
  * `getMilliseconds()` : 0 ~ 999
  * `getminute()` : 0 ~ 59
  * `getMonth()` : 0 ~ 11
  * `getSeconds()` : 0 ~ 59
  * 각 메소드의 `get`을 `set`으로 변경한 메소드들이 존재한다.
  * `toXXXString()` : 날짜를 특정 문자열 형태로 변환하는데 사용
  * `getTime()` : 밀리초로 변환 - 1000밀리초가 1초

### Number

> 수치형 값을 감싸서 객체로 만들어주는 Wrapper 객체

* 생성자

  ```javascript
  var num = new Number(7);
  ```

* 속성

  * `MAX VALUE` : 표현할 수 있는 가장 큰 값
  * `MIN VALUE` : 표현할 수 있는 가장 작은 값
  * `NaN` : Not - a - Number의 약자

* 메소드

  * `toExponential([digits])` : 지수형으로 반환, 인수는 소수점 이하 숫자의 개수
  * `toFixed([digits])` : 고정소수점 방식으로 반환, 인수는 소수점 이하 숫자의 개수
  * `toPrecision([precision])` : 유효숫자 수를 지정
  * `toString([radix])` : 주어진 진법으로 숫자를 반환

### String

* 속성
  * `length` : 문자열의 길이
* 메소드
  * `toUpperCase()`, `toLowerCase()` : 대문자 혹은 소문자로 변환
  * `concat()` : 하나의 문자열을 다른 문자열과 합친다. `+`를 사용해도 동일한 결과
  * `indexOf()` : 주어진 텍스트가 처음 등장하는 위치를 반환
  * `match()` : 일치하는 콘텐츠를 탐색하는데 사용, 정규식을 사용할 수 있다.
  * `replace()` : 주어진 값을 다른 값으로 대체, 정규식을 사용할 수 있다.
  * `split(delimeter[, limit])` : 첫번째 인수를 분리자로 하여 문자열을 분리한 후에 각 항목을 가지고 있는 배열을 반환
  * `HTML Wrapper` : 문자열을 적절한 HTML Tag로 감싼 후에 반환

### Math

* new를 통하여 객체를 생성할 필요없이 바로 이용하면 된다.
* 속성
  * `E` : 오일러의 상수 (약 2.718)
  * `LN2` : 자연 로그(밑수: 2) (약 0.693)
  * `LN10` : 자연로그(밑수: 10) (약 2.302)
  * `PI` : 파이 상수 (약 3.14)
  * `SQRT1_2` : 1/2의 제곱근 (약 0.707)
  * `SQRT2` : 2의 제곱근 (약 1.414)
* 메소드
  * `abs(x)` : 절대값
  * `acos(x)`, `asin(x)`, `atan(x)` : 아크 삼각함수
  * `ceil(x)`, `floor(x)` : 실수를 정수로 올림, 내림 함수
  * `cos(x)`, `sin(x)`, `tan(x)` : 삼각함수
  * `exp(x)` : 지수함수
  * `log(x)` : 로그함수
  * `max(x, y, z, ..., n)` : 최대값
  * `min(x, y, z, ..., n)` : 최소값
  * `pow(x, y)` : 지수함수(x의 y제곱)
  * `random()` : 0과 1사이의 난수값 반환
  * `round(x)` : 반올림
  * `sqrt(x)` : 제곱근

### Array

* 생성자

  ```javascript
  var myArray = new Array();
  ```

* 배열의 크기가 자동으로 조절된다. 현재 배열의 크기보다 큰 인덱스를 사용하면 자동으로 증가한다.

* 여러가지 자료형을 혼합해서 저장할 수 있다.

* 배열의 크기보다 큰 인덱스 값으로 배열 요소에 접근하면 `undefined` 값이 반환된다.

* 속성

  * `length` : 배열의 크기

* 메소드

  * `concat()` : 전달된 인수를 배열의 끝에 추가한다.
  * `indexOf()` : 요소의 값을 가지고 요소의 인덱스를 찾을 때 사용
  * `push()` : 스택에 데이터를 삽입하는 메소드
  * `pop()` : 스택에서 데이터를 꺼내는 메소드
  * `shift()` : 배열의 첫번째 요소를 반환하고 이를 배열에서 제거한다.
    * `unshift()`와 함께 사용하면 자료구조 큐를 구현할 수 있다.
  * `sort()` : 알파벳순으로 정렬
    * 수치값으로 정렬하려면 `function(a, b) {return a-b}`를 인수로 제공하면 된다.
  * `slice([begin[, end]])` : 배열의 일부를 복사하여 새로운 배열로 반환
  * `join(delimeter)` : 배열의 요소들을 하나의 문자열로 출력
  * `filter()` : 어떤 조건에 부합하는 요소만을 선택하여 새로운 배열로 만들어서 반환

## Custom

> 사용자가 생성자를 정의한 객체

### Create

#### 상수로부터 객체 생성

```javascript
var myCar = {
	model: "520d",
	speed: 60,
	color: "red",
	brake: function() { this.speed -= 10; },
	accel: function() { this.speed += 10; }
};
```

* 간단하지만 객체를 하나만 생성할 수 있다. (싱글톤 객체)
* 개체가 가지는 속성은 var를 사용하지 않고 선언해도 된다.

#### 생성자 함수 사용

```javascript
function Car(model, speed, color){
	this.model = model;
	this.speed = speed;
	this.color = color;
	this.brake = function(){
		this.speed -= 10;
	}
	this.accel = function(){
		this.speed += 10;
	}
}
```

* 생성자도 함수이므로 `function`을 사용한다.

### Use

```javascript
var myCar = new Car("520d", 60, "white");
myCar.color = "yellow";
myCar.brake();
```
## Prototype

> 객체에서 중복사용되는 메소드를 한번만 사용하도록 변경하여 메모리 낭비를 줄이는 것

* `JavaScript`의 모든 객체는 `prototype`이라는 숨겨진 객체를 가지고 있다.

```javascript
function Point(x, y){
    this.x = x;
    this.y = y;
}
Point.prototype.getDistance = function(){
    return Math.sqrt(this.x * this.x + this.y * this.y);
}
```

* `Point`객체 모두가 `getDistance()`메소드를 공유한다.

  * 객체를 아무리 많이 생성하더라도 `getDistance()`메소드는 오직 하나만 존재한다.

* `prototype`안에 정의 하였지만 객체를 통하여 메소드를 호출하는 방법은 동일하다.

  ```javascript
  var p1 = new Point(10, 20);
  p1.getDistance();
  ```

* 작동방식

  1. 객체 안에 속성이나 메소드가 정의되어 있는지 체크
  2. 객체 안에 정의되어 있지 않으면 객체의 `Prototype`이 속성이나 메소드를 가지고 있는지 체크
  3. 원하는 속성이나 메소드를 찾을때까지 `Prototype` 체인을 따라서 올라감
     * `Prototype`객체는 개별 객체에서 시작해서 생성자의 프로토타입을 통하여 `Object`의 프로토타입까지 연결되어 있다.
     * 프로토타입 체인은 `__proto__`속성을 이용해 연결된다.

## Object

> JavaScript 객체의 부모가 되는 객체

* 속성
  * `constructor` : 생성자 함수
* 메소드
  * `valueOf()` : 객체를 숫자로 변환
  * `toString()` : 객체의 값을 문자열로 변환
  * `hasOwnProperty()` : 전달 인수로 주어진 속성을 가지고 있으면 `true`를 반환
  * `isPrototypeOf()` : 현재 객체가 전달 인수로 주어진 객체의 프로토타입이면 `true` 반환