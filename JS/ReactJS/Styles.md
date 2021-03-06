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

### 발전된 CSS 스타일

이전보다 발전된 방법인 CSS 모듈을 활용해본다.
CSS가 Global이 아닌 Local에서 동작하도록 설정하는 방법이다.
CSS 모듈로 설정하고자 한다면, 파일이름을 `Header.module.css`와 같이 변경한다.

```css
.navList {
	display: flex;
}
```

사용할 때에는 JS를 import하는 것처럼 CSS Module도 import한다. 또한 className을 JS Object처럼 사용한다.

```js
import styles from "./Header.module.css"

...
	<ul className={styles.navList}>
...
```

이렇게 모듈을 사용하면 웹페이지에서 나타나는 className에는 `__1bmZ3`과 같은 이상한 문자열이 추가된다. (인스타그램도 흡사하게 사용한다)
이렇게 진행하면 다른 파일에서도 `navList`라는 className을 반복해서 사용할 수 있게 된다.

이렇게 사용할 때에는 CSS Module에 `nav-list`와 같은 `-`은 사용하지 않는다. 왜냐하면 사용할 때 다음과 같이 사용해야 되기 때문이다.

```js
...
	<ul className={styles["nav-list"]}>
...
```

하지만 여기서도 생기는 문제는 JS와 CSS는 역시 다른 파일로 존재하며, navList라는 이름 또한 기억해줘야 한다는 점이다.

### JS에 포함된 스타일

`styled-components`라는 모듈을 다운로드 받아서 사용한다.

```shell
yarn add styled-components
```

이는 JS에서 import해서 사용하며, 다음과 같이 사용한다.

```js
import React from "react";
import { Link } from "react-router-dom";
import styled from "styled-components";

const Header = styled.header``;
const List = styled.ul`
    display:flex;
    &:hover {
        background-color: blue;
    }
`;

const Item = styled.li``;
const SLink = styled(Link)``;

export default () => (
    <Header>
        <List>
            <Item>
                <SLink to="/">Movies</SLink>
            </Item>
            <Item>
                <SLink to="/tv">TV</SLink>
            </Item>
            <Item>
                <SLink to="/search">Search</SLink>
            </Item>
        </List>
    </Header>
);
```

> Link는 이전 Project Setting에서 배웠던 react-router-dom의 Link이다.

이 방법을 사용하면, Javascript 안에 CSS가 있고 Components를 바꾸면된다.
이런 방식은 코드가 HTML 태그들이 많은 것보다 더 나아보이고 내가 원하는 이름을 사용한다.
그리고 모든 Component들의 스타일을 쉽게 바꿀 수 있다.

## Global Styles and Header

현재 local한 SC(Styled-Components)를 Global하게 설정할 수 있다.
Global하게 설정하는 이유는 해당 사이트의 폰트를 설정하거나, SC를 설치하는 등의 작업을 하고 싶기 때문이다.

Global하게 설정하기 이전에, 기존에 존재하는 CSS 설정들을 없애고 0부터 다시 시작할 수 있게 해주는 `styled-reset`을 설치한다

```shell
yarn add styled-reset
```

이제 다음과 같이 코딩하여 Global하게 CSS를 설정해본다.

```js
import { createGlobalStyle } from "styled-components";
import reset from "styled-reset";

const globalStyles = createGlobalStyle`
    ${reset};
    a {
        text-decoration: none;
        color: inherit;
    }
    * {
        box-sizing: border-box;
    }
    body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Canta
        font-size: 12px;
        background-color:rgba(20, 20, 20, 1);
        color: white;
        padding-top: 50px;
    }
`;

export default globalStyles;
```

해당 Global Style을 App.js에서 import해야한다.

```js
import React, { Component } from "react";
import Router from "../Components/Router";
import GlobalStyles from "./GlobalStyles";

class App extends Component {
  render() {
    return (
      <>
        <Router />
        <GlobalStyles />
      </>
    );
  }
}
```

이후 기존에 하던것처럼 CSS 세팅을 진행하면 Global한 CSS 설정 이후 각 Component의 CSS 설정을 진행한다.

## Location Aware Header

현재 사이트의 위치가 Header중에서 어느 사이트인지 알 수 있게 설정한다.
기존 Header.js에서 `<Item>`태그에 사용한다.

```js
...
const Item = styled.li`
    width: 50px;
    height: 50px;
    text-align: center;
    border-bottom: 5px solid ${props => props.current? "#3498db" : "transparent"};
`;
const SLink = styled(Link)`
    height:50px;
    display: flex;
    align-items: center;
    justify-content: center;
`;

// navList라는 것을 다른곳에서도 사용할 수 있기 때문에 뒤에 값이 추가됨
export default () => (
    <Header>
        <List>
            <Item current={false}>
                <SLink to="/">Movies</SLink>
            </Item>
            <Item current={true}>
                <SLink to="/tv">TV</SLink>
            </Item>
            <Item current={false}>
                <SLink to="/search">Search</SLink>
            </Item>
        </List>
    </Header>
);
```

> 현재는 임의로 current값을 지정해준 상태이다. 이후에 변경할 예정이다.

Item의 SC를 살펴보면, border-bottom값의 색을 지정할 때, `${}`를 사용하여 조건식을 주었다.
props를 살펴보고, 해당 props가 true인지 false인지에 대하여 값을 변경한다

withRouter를 사용한다.