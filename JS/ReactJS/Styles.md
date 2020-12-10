# Styles

## CSS

### 기존의 CSS 스타일

styles.css라는 파일을 만들고 해당 파일에 필요한 CSS를 입력하는 방식

```css
.nav ul {
	display: flex;
}

/* @import "page.css" */

/* 
문제점
1. 파일을 생성해야 함
2. 사용할 때마다 import 해야함
3. className이 반복되지 않게 기억해야 함
*/

```

> styles.css 파일

index.js파일에 해당 styles.css파일을 import해준다.
만약 프로젝트가 커지게 된다면, `@import "page.css"`와 같이 새로운 css를 추가해야 한다.

이 방법의 문제점은 Component(.js)와 CSS(.css)가 분리되어 있다는 점이다.
Components를 이용하는 것의 요점은 어플리케이션의 부분을 캡슐화 하는 것인데, 우린 JS, Logic, HTML, Styles 모두 같은 곳에 가지고 싶다.
이를 가능하게 하는 옵션 중 하나가 Header라는 폴더를 Components 내에 생성하여 활용하는 것이다.

Header 폴더 내에 index.js를 새로 생성한다.

```js
import Header from "../Header";

export default Header;
```

index.js를 생성하는 이유는 App.js에서 Header를 호출할 때 폴더를 호출하기 위함이다. 이렇듯 폴더를 호출하면 폴더 내의 index.js를 호출한다.
만약 index.js가 없다면 Header.js를 또 지정해줘야 하는데 이는 비효율적인 일이다.
이렇게 진행한다면, 기존의 styles.css를 Header.css로 변경하고, index.js에 import 해줘야한다.
이러한 방식으로 파일들을 폴더에 넣어서 Component를 만들고 그 폴더에 CSS 파일도 만들어서 import 하는 방법이다.

이 방법 역시 문제점이 존재한다.
우선, 파일을 생성해야 한다는 점이다. 파일을 생성해야 하기 때문에 우리가 사용할 때마다 import를 해줘야 한다.
또한 className을 기억해야 한다는 점이다. className이 반복되지 않도록 기억해야 한다.
Header에서 nav라는 className을 사용했다면, 다른 Components에서 nav를 사용하지 않아야 하는데 이를 기억하긴 힘들다.
(현재 CSS를 App.js에서 호출하여 Global하게 동작하도록 정해두었기 때문)



## Global Styles and Header

## Location Aware Header

