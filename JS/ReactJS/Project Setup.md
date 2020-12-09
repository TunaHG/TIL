# Project Setup

## Set

`create-react-app`을 사용할 예정이므로 해당 모듈을 다운로드 받는다. `yarn`을 사용하거나 `npx`를 사욯한다.
`npx`를 사용하면 해당 모듈을 사용한 이후 내 파일시스템에는 남지않게 삭제한다.

만약 `yarn`이나 `npx`가 존재하지 않는다면 `npm i yarn -g` 혹은 `npm i npx -g`를 사용하여 설치한다.

`npx`가 설치되었다면 `create-react-app`을 진행하여 해당 폴더를 생성한다.

```shell
npx create-react-app nomflix
```

> 뒤에 들어올 프로젝트명은 대문자가 포함되면 에러가 발생한다.

nomflix 폴더가 생성되었다면, App.js와 index.js를 제외한 나머지를 삭제하고 해당 파일들에서도 필요없는 부분들을 삭제한다.

```js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './Components/App';

ReactDOM.render(<App />, document.getElementById('root'));
```

> index.js는 다음과 같은 코드들만 남기면 된다.

`.env` 파일을 생성한다.

```
NODE_PATH=src
```

> src 폴더의 경로를 알려주는 환경설정이다. 나는 왠지 모르게 안먹히던데...? 안먹히면 위에서 import 할 때 상대경로로 지정하면 된다.

`prop_types`를 설치한다.

> 해당 모듈은 컴포넌트의 props 타입을 확인할 수 있다. 아직 사용하진 않는다.

제대로 설치되었는지 확인해보기 위하여 `yarn start`를 진행해본다.

## React Router

프로젝트 진행계획들을 README에 작성

### Router

Router

* Home
  첫 화면이 나오는 Router
* TV Shows
  TV 프로그램들이 나오는 Router
* Search
  검색결과들이 나오는 Router
* Detail
  각 프로그램들의 세부사항들이 나오는 Router

`src` 폴더의 하위 폴더로 `Component`와 `Routes` 를 생성한다.
`Component` 폴더에는 `app.js` 폴더를 넣어주고, `Routes` 폴더에는 위에서 명시한 Router들을 폴더로 만들어서 넣어준다.
Router들을 app.js와 엮어주기 위해서 **React Router**를 활용한다.

Component 폴더에 Router.js 파일을 생성하여 react-router-dom을 import 한다.

```shell
yarn add react-router-dom
```

Router를 생성하며, `<Route>` 태그에는 속성으로 path, exact, component가 포함된다.
path는 해당 Route의 경로를 의미하고, exact는 정확히 해당 경로를 입력해야 함을 의미한다. component는 어떤 component를 가져올지를 의미한다.
Router는 오직 하나의 엘리먼트만 가질 수 있다.

```js
import React from "react";
import { HashRouter as Router, Route } from "react-router-dom";
import Home from "../Routes/Home";
import TV from "../Routes/TV";
import Search from "../Routes/Search";

export default () => {
    <Router>
        <>
            <Route path="/" exact component={Home} />
            <Route path="/tv" exact component={TV} />
            <Route path="/search" component={Search} />
        </>
    </Router>
}
```

Home, TV, Search의 파일들은 간단하게 다음과 같이 구성한다.

```js
export default () => "Home";
```

> TV와 Search의 경우 `" "` 내의 문자열만 TV와 Search로 변경해준다.

App.js에서 Router를 가져와본다.

```js
class App extends Component {
  render() {
    return (
      <>
        <Router />
      </>
    );
  }
}
```

### Header

다음은 Header를 추가해본다.

Components 폴더에 Header.js 파일을 추가한다.
Header.js 파일에는 `<header>` 태그의 내부내용을 export한다.

```js
import React from "react";

export default () => (
    <header>
        <ul>
            <li>
                <a href="/">Movies</a>
            </li>
            <li>
                <a href="/tv">TV</a>
            </li>
            <li>
                <a href="/search">Search</a>
            </li>
        </ul>
    </header>
);
```

> Movies, TV, Search와 같이 3개의 아이템을 가진다.

Header는 App.js의 `<Router />`의 위에 똑같이 넣는다.

```js
class App extends Component {
  render() {
    return (
      <>
        <Header />
        <Router />
      </>
    );
  }
}
```

### Redirect

Redirect는 어떤 경로를 받았을 경우 다른 페이지로 연결해주는 기능이다.
Router.js에 추가하며 다음과 같이 추가한다.

```js
export default () => {
    <Router>
        <>
            <Route path="/" exact component={Home} />
            <Route path="/tv" exact component={TV} />
            <Route path="/search" component={Search} />
            <Redirect from="*" to="/" />
        </>
    </Router>
}
```

하지만 이렇게 진행하면 `/`, `/tv`, `/search` 어디로 이동하든 전부 `/`로 이동하게 된다.
우리의 목적은 `<Route>`가 실행되지 않으면 마지막으로 `<Redirect>`가 실행되게 하는 것이 목적이다.
그럴때 사용하는 것이 **Switch**이다.

### Switch

Switch는 내부에 들어있는 `<Route>`와 `<Redirect>`중 하나가 실행되면 나머지는 실행시키지 않는 태그이다.

```js
export default () => {
    <Router>
        <Switch>
            <Route path="/" exact component={Home} />
            <Route path="/tv" exact component={TV} />
            <Route path="/search" component={Search} />
            <Redirect from="*" to="/" />
        </Switch>
    </Router>
}
```

위와같이 `<> </>`로 묶여있던 `<Route>`들을 `<Switch>`로 묶어준다.
이제 모든 `<Route>`가 실행되지 않았을 경우 `<Redirect>`가 실행될 것이다.

### Link

위의 Header를 작성하며 우리는 `<a>`태그를 사용하여 이동하였다.
하지만 `<a>`를 사용하지 않고 **react-router-dom**의 `<Link>`를 이용하여 동일한 동작을 하도록 만들 수 있다.

