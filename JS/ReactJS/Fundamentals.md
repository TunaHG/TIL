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

## Array Map

API에서 데이터를 받게되면 그 배열의 데이터를 이용해서 어떠한 Component의 배열을 만들게 될 것이다.
우리가 사용할 것은 배열에 `.`을 찍어서 사용할 수 있는 메소드 중에 map이다.
`map()`에서 메소드를 입력하여 원하는 배열의 각각의 값을 해당 메소드에 적용하여 실행한다.
`map()`의 return값은 배열이며, `()`안의 메소드를 실행시킨 결과값을 배열로 가진다.
매개변수의 첫번째 값은 주어지는 배열의 값들을 각각 받을 것이며, 두번째 값은 배열의 인덱스를 받을것이다.

```js
const days = ["Mon", "Tue", "Wed", "Thu", "Fri"];

const today = (day, index) => `Today is ${day} #${index + 1}`;

const smilingDays = days.map(today);

console.log(smilingDays);
```

## Array Filter

주어진 Function을 통과한 모든 원소들로 이루어진 배열을 생성한다.
filter의 역할은 map과 비슷하다. 배열의 각각의 아이템에 Function을 실핸한다. 하지만 단지 그들을 포함하는게 아니라 아이템들을 살펴보고 우리가 넣을 Function의 return이 true이면 해당 아이템을 배열에 넣는 형태이다.

```js
const numbers = [2, 45, 6454, 22, 456, 23, 67, 11, 443, 66, 223, 2, 4, 6, 89, 4, 2, 1];

const testCondition = (number) => number > 15;
const biggerThan15 = numbers.filter(testCondition);

console.log(biggerThan15);
```

> method의 return값이 true혹은 false여야 한다.

## forEach, includes, push

`forEach`는 각각에 대해서~ 라는 뜻이다.
새로운 배열을 생서하지 않고 그저 현재 있는 배열 각각의 값에 대해 어떤 메소드를 실행하고 싶다.

```js
let posts = ["Hi", "Hello", "Bye"];

posts.forEach(post => console.log(post));
```

> forEach() 내부의 Function을 posts의 배열 각각의 값에 대해 실행했다.

`push`는 배열에 새로운 값을 넣을 때 사용한다.

```js
posts.push("new");

console.log(posts);
```

> new라는 새로운 값이 포함된 배열을 확인할 수 있다.

`includes`는 배열에 해당 값이 존재하는 지 확인할 때 사용한다.

```js
let greetings = ["Hi", "Howdy", "Suup"];

if (!greetings.includes("Hello")) {
    greetings.push("Hello");
}

console.log(greetings);
```

> includes() 내부에 입력한 값이 배열에 존재한다면 true값을 반환한다.

이외에도 MDN을 살펴보면 배열과 관련된 함수들이 정말 많은 것을 확인할 수 있다.