# NPM

> Nodejs Package Manager

* npm을 통한 Package 생성

  ```bash
  $ npm init
  ```

  * 이후에 Package에 대한 내용 작성이 나온다.

    * `( )`로 표시된 내용은 default 설정 내용
    * 비워두고 Enter를 치며 넘어갈 수 있음

  * 내용작성을 전부 default로 바로 생성

    ```bash
    $ npm init -y
    ```

* npm을 통한 Module 가져오기

  ```bash
  $ npm install express
  $ npm install uuid4
  ```

  * No repository나 No description은 init에서 생성한 Package의 해당 부분이 비어있다는 의미

  * 이러한 방식으로 받으면 Module을 가져올 때 경로를 사용하지 않음

    ```js
    const uuid4 = require('uuid4')
    console.log(uuid4)
    ```

* package-lock.js

  * 각 Module별 충돌을 방지하는 역할
  * 예시
    * express는 body-parser v1.2가 필요
    * nunjucks는 body-parser v2.0이 필요
    * 이런 경우, body-parser v2.0을 import하면 express에서 Error가 발생
    * body-parser v1.2를 import하여 모든 module에서 문제가 발생하지 않도록 함

* package의 scripts 작성

  ```js
  "scripts" : {
      "start" : "node index.js",
      "dev" : "node index.js"
  }
  ```

  * 위와 같이 정의해두면 `npm start`, `npm dev`와 같은 명령어를 사용할 수 있음

## Nodemon

* node로 구동하는 서버는 소스가 수정되면 서버를 종료 후 재시작해야 함
* nodemon을 이용하여 서버를 구동하면 소스가 수정되었을 때 nodemon이 알아서 서버를 재시작해줌
* `npx`
  * https://geonlee.tistory.com/32
  * npm으로 설치하는 것이 아닌, 알아서 설치하고 실행한 후 삭제까지 진행해주는 Command
* `-e js,html`
  * nodemon이 변경을 감지할 때, js파일과 html파일의 변동을 감지하는 설정