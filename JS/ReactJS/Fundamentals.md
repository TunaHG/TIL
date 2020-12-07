# Fundamentals

## Arrow function

Arrow function을 사용하지 않는 코딩은 다음과 같다.

```javascript
function sayHello(name = "Tuna") {
    return "Hello " + name;
}

const tuna = sayHello();

console.log(tuna);
```

> return을 추가해주지 않는다면, tuna에 값이 들어가지 않기 때문에 console.log()로 undefined가 표시된다.
> sayHello() 메소드의 name에는 위와같이 default값을 설정할 수 있다.

Arrow function을 사용하는 코딩은 다음과 같다.

```js
const sayHello = (name = "Tuna") => "Hello" + name;

const tuna = sayHello("Tuna");
console.log(tuna);
```

> Function을 Anonymous Function으로 만들기 좋다.
> Function 내부 코드를 여러 줄 작성하고 싶다면 `{ }`를 활용하여 묶어주면 된다.

이러한 방식으로, Callback함수도 Arrow function을 사용하지 않는 과거에서 사용하는 형태로 변경한다.

```html
const button = document.querySelector("button");

button.addEventListener("click", (event) => console.log(event));
```

보기에도 간편하고 좋아보인다.

## Template Literals

Template, Variables, Strings를 다루기에 좋은 방법

```js
const sayHello = (name = "Tuna") => "Hello " + name;

const tuna = sayHello();
console.log(tuna);
```

> 이전 Arrow Function에서 진행했던 코드

위의 코드에서 name을 `+`를 사용해서 추가하지 않고 String 내부에 넣어줄 수있다.

```js
const sayHello = (name = "Tuna") => `Hello ${name}`
```

> 여기서 중요한건, `' '` (Single Quote)를 사용하는 것이 아니라 `` `(Backtick)을 사용한다는 점이다.  (키보드 좌측 위 물결표시의 그 키)

## Object Destructuring

적은 코드를 사용해서 좀 더 깔끔하게 보이게 하는 것이다.

```js
const human = {
    name: "Tuna",
    lastName: "Kim",
    nationality: "Wish i was korean"
}

const name = human.name;
const lastname = human.lastname;

console.log(name, lastname);
```

> 이와 같은 방법은 동일한 변수를 두 번 선언하기 때문에 효율적이지 않다. 이를 해결할 방법이 Structuring

```js
const human = {
    name: "Tuna",
    lastName: "Kim",
    nationality: "Wish i was korean"
}

// const name = human.name;
// const lastname = human.lastname;

const { name, lastname } = human;

console.log(name, lastname);
```

> `{ }`로 묶어주면 human 변수 안의 값들을 변수명을 활용하여 가져온다.

하지만 human 내부의 값을 동일한 변수명을 사용하지 않고 다른 변수명으로 가져오고 싶다면 다음과 같이 변수명을 변경한다.

```js
const { name, lastname, nationality: difName } = human;
```

또한 human 내부에서 `{ }`의 값들을 각각 가져올수도 있다.

```js
const human = {
    name: "Tuna",
    lastName: "Kim",
    nationality: "Wish i was korean",
    favFood: {
    	breakfast: "Bread",
        lunch: "Doncas",
        dinner: "Sang + Doncas"
	}
}

const { name, lastName, nationality: difName, favFood: { breakfast, lunch, dinner } } = human;
console.log(name, lastName, difName, breakfast, lunch, dinner);
```

> breakfast, lunch, dinner가 각각 변수로 사용된다.

## Spread Operator

```js
const days = ["Mon", "Tues", "Wed"];
const otherDays = ["Thu", "Fri", "Sat"];

// const allDays = days + otherDays;
const allDays = [days, otherDays];
console.log(allDays);
```

> allDays는 각 배열들을 출력한다. 우리가 원하는 것은 배열 내에 있는 아이템들을 가지고 싶지 배열을 가지고 싶진 않다.

이러한 경우 `...`을 사용한다.

```js
const allDays = [...days, ...otherDays, "Sun"];
```

이러한 Spread Operator는 Array가 아니라 Object에서도 동작한다.

```js
const ob = {
    first: "hi",
    second: "hello"
}

const ab = {
    third: "bye bye"
}

const two = { ...ob, ...ab };
console.log(two);
```

다음과 같은 형태로 함수 내에서도 매개변수의 형태로 사용할 수 있다.

```js
const shi = (something, ...args) => console.log(...args);
```

## Classes

React의 Component는 대부분 Class이다. 그래서 Class가 어떻게 동작하는지 알아야 할 필요가 있다.

```js
class Human {
    constructor(name, lastName) {
        this.name = name;
        this.lastName = lastName;
    }
}

const tuna = new Human("Tuna", "Kim");
console.log(tuna);
```

> this는 Human Class를 의미하는 것이다. 그러므로 this.name은 Human Class내의 name 변수를 의미하는 것이다.

constructor는 class를 생성할 때 필요한 것들을 가지고 있다다. 이러한 Class를 확장할 수 있다.

```js
class Baby extends Human {
    cry() {
        console.log("Waaaaaa");
    }
    sayName() {
        console.log(`My name is ${this.name}`);
    }
}

const myBaby = new Baby("mini", "me");
console.log(myBaby);
console.log(myBaby.cry());
```

> 위의 코드를 실행하면 Baby Class의 name과 lastName이 나오고 Waaaaa가 출력된다.
> Human Class를 상속받기 때문에 Human Class에 존재하는 constructor를 사용하여 name과 lastName이 선언되는 것이다.

이러한 상속 작업을 React에서 많이 진행한다. React Component들은 State 등의 많은 것들을 가지고 있으며 그들은 모두 Class들이다.