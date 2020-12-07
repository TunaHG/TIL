# Template Literals

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

