# Arrow function

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