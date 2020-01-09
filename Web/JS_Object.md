# JavaScript Object

### Built-In

> 생성자가 미리 작성되어 있는 객체

* `Date`, `String`, `Array`와 같은 객체가 내장 객체이며 HTML문서를 나타내는 `document`도 내장 객체이다.

### Custom

> 사용자가 생성자를 정의한 객체

## Create

### 상수로부터 객체 생성

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

### 생성자 함수 사용

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



* `with()` : 객체를 로딩하는 함수
  * 로딩된 객체의 메소드를 사용할 수 있다.