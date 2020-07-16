# Express

* 왜 Express를 사용해야 하는가?

  * 다른 사람이 만들어 둔 Web Framework를 사용
    * 필요한 구조가 이미 만들어진 framework를 사용하므로 편리함
  * Node.js에서 많이 사용되고 있기 때문에 커뮤니티 활성화

* Express를 사용하지 않고 웹 서버를 띄워보기

  * 사용자가 보낸 Request(URL 접속, Form 전송)를 서버가 수신하여 Response(텍스트, 이미지)를 사용자에게 송신

  * `index.js`파일 생성

    ```js
    const http = require('http');
    
    http.createServer( (request, response) => {  
        response.writeHead(200, {'Content-Type' : 'text/plain'});
        response.write('Hello Server');
        response.end();
    }).listen(3000);
    ```

    * HTTP요청을 진행
    * `listen(3000)`은 3000번 Port로 연결한다는 것

  * `node index.js`로 실행

    * 크롬을 켜서 `localhost:3000`으로 접속하면 'Hello Server'가 출력되는 것을 확인

  * [참고 : HTTP 상태코드](#HTTP 상태코드)

## Start

* Express를 학습할 새로운 폴더 생성
  * `npm init -y`를 통해 `package.json`파일 생성

* express를 진행하기 위해 `npm install express`를 진행하여 express를 설치

* `app.js`파일 생성

  ```js
  const express = require('express');
  
  const app = express();
  const port = 3000;
  
  app.get('/', (req, res) => {
      res.send('hello express');
  });
  
  app.get('/fastcampus', (req, res) => {
      res.send('fastcampus get');
  });
  
  app.listen(port, () => {
      console.log('Express listening on port', port);
  });
  ```

  * express를 사용하여 app을 구성
  * `app.get()`을 통해 GET방식으로 웹과 통신
  * `app.listen`을 통해 서버 시작시 Console에 메시지 표시

## Routing

* 특정 URL 이후에 오는 URL들을 관리

  * 예를들어, `/admin`이라는 URL 이후에 `/products`라는 URL이 오는 경우를 관리

* 폴더 내에 `routes`폴더 생성

  * 해당 폴더에 `admin.js` 파일생성

    ```js
    const express = require('express');
    const router = express.Router();
    
    router.get('/', (req, res) => {
        res.send('URL after admin')
    });
    
    router.get('/products', (req, res) => {
        res.send('admin products')
    });
    
    module.exports = router;
    ```

    * express를 가져오고, express의 `Router()`를 사용
    * `app.js`에서 `app.get()`을 사용할 때와 마찬가지로 `router.get()`을 사용하여 각 URL의 역할 지정
    * 해당 Module을 내보내서 `app.js`에서 받아야 하기 떄문에 `module.exports` 사용

* `app.js` 파일 수정

  ```js
  const admin = require('./routes/admin')
  ```

  * admin module을 가져옴

  ```js
  app.use('/admin', admin);
  ```

  * `/admin` URL로 접근하면 해당 module을 사용하도록 지정

## Nunjucks

> View Engine

* nunjucks Setting

  * `npm install nunjucks`
  * `app.js` 파일 수정

  ```js
  const nunjucks = require('nunjucks');
  ```

* `app.js` 파일 수정

  ```js
  nunjucks.configure('template', {
      autoescape : true,
      express : app
  });
  ```

  * `autoescape`는 입력한 그대로 출력하도록 하는 기능
    * 그렇지 않다면 입력에 `<h1>`과 같은 HTML태그가 포함되었을 때 문제가 발생할 수 있음
    * [참고 : Nunjucks git](https://mozilla.github.io/nunjucks/api.html#configure)
  * express에는 위에서 선언한 `express()`객체를 지정

* `products.html` 생성

  * `template/admin` 폴더에 생성

  ```html
  products
  {{message}}
  ```

  * 간단하게 출력, `{{message}}`는 서버에서 받아오는 값
  * `autoescape`에서 벗어나게 설정하고 싶다면 `{{ message | safe }}`로 선언
    * message에 들어오는 HTML 태그가 정상 작동

* `admin.js` 파일 수정

  * `get('/products')`부분의 `res.send()`를 수정

  ```js
  res.render('admin/products.html', {
      message : 'hello!!'
  });
  ```

  * `products.html`의 경로를 지정
  * `'hello'`를 message로 지정하여 html에게 전송

## Template 상속

* HTML파일들을 상속하도록 구성

* `base.html` 파일 생성

  * template폴더에 layout폴더를 생성후 해당 폴더에 파일을 생성

  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <meta http-equiv="X-UA-Compatible" content="ie=edge">
      <title>{{ title }}</title>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  </head>
  <body>
      <div class="container" style="padding-top:100px;">
  
          {% block content %}{% endblock %}
  
      </div>    
  </body>
  </html> 
  ```

  * `{{ title }}`도 상속받는 html파일에서 지정
  * `{% block content %}{% endblock %}` 이 부분에 상속받는 html의 구성이 들어감

* `products.html` 파일 수정

  * 기존에 간단한 출력만을 진행했던 html파일을 `base.html`을 상속하도록 수정

  ```html
  {% set title = "관리자 리스트" %}
  {% extends "layout/base.html" %}
  
  {% block content -%}
      <table class="table table-bordered table-hover">
          <tr>
              <th>제목</th>
              <th>작성일</th>
              <th>삭제</th>
          </tr>
          <tr>
              <td>제품 이름</td>
              <td>
                  2020-03-07
              </td>
              <td>
                  <a href="#" class="btn btn-danger">삭제</a>
              </td>
          </tr>
      </table>
  
      <a href="/admin/products/write" class="btn btn-default">작성하기</a>
  
  {% endblock %} 
  ```

  * `{% set title = "관리자 리스트" %}`를 통해 Title을 설정
  * `{% extends "layout/base.html" %}`를 통해 상속받는 html파일을 설정
  * `{% block content -%}`와 `{% endblock %} `을 통해 시작점과 끝점을 표시
    * 내부에 원하는 내용을 작성

## Middleware

* `npm install morgan`

  * 사용자가 어떤 URL을 호출했는지 Console에서 확인할 수 있도록 도와주는 Module

* `app.js` 파일 수정

  ```js
  const logger = require('morgan');
  app.use(logger('dev'));
  ```

  * 이후 `localhost:3000/admin/products`로 접속하거나 새로고침해보면 `GET /admin/products ~ ~`와 흡사한 형태가 Console에 출력

* Middleware 사용

  * `admin.js` 파일 수정

  ```js
  function testMiddleware(req, res, next){
      console.log('First Middleware');
      next();
  }
  ```

  * 위와 같은 function을 선언하고 `router.get()`에 parameter로 추가

  ```js
  router.get('/', testMiddleware, (req, res) => {
      res.send('URL after admin')
  });
  ```

  * `/admin`으로 진입시 `testMiddleware`가 먼저 실행되고, 이후 `get()`의 내부 코드가 실행

  * `admin.js`가 아닌 `app.js`에서 사용할 수 있음

    ```js
    function vipMiddleware(req, res, next){
        console.log('Prior Middleware');
        next();
    }
    
    app.use('/admin', vipMiddleware, admin);
    ```

  * `/admin`으로 접근할 때 실행, First보다 Prior가 먼저 실행됨

* 보통 Middleware는 로그인이 되어있는 상태여야 접속할 수 있는 페이지를 구성하는 경우 많이 사용됨

## Form

> body-parser

* Form을 사용하여 데이터를 전송

  * `write.html` 파일 생성 (template/admin 폴더에)

    ```html
    {% set title = "제품 등록" %}
    {% extends "layout/base.html" %}
    
    {% block content -%}
        <form action="" method="post">
            <table class="table table-bordered">
                <tr>
                    <th>제품명</th>
                    <td><input type="text" name="name" class="form-control"/></td>
                </tr>
                <tr>
                    <th>가격</th>
                    <td><input type="text" name="price" class="form-control"/></td>
                </tr>
                <tr>
                    <th>설명</th>
                    <td><input type="text" name="description" class="form-control"/></td>
                </tr>
            </table>
            <button class="btn btn-primary">작성하기</button>
        </form>
    
    {% endblock %} 
    ```

    * `base.html`을 상속하도록 구성
    * form의 method가 post방식으로 구성
    * form의 action을 비워두면 현재 본인의 URL로 구성

* `write.html`파일로 연결되기 위한 `admin.js` 파일 수정

  ```js
  router.get('/products/write', (req, res) => {
      res.render('admin/write.html');
  });
  
  router.post('/products/write', (req, res) => {
      res.send(req.body);
  });
  ```

  * `get()`은 `products.html`에서 작성하기 버튼을 클릭하였을 때 `wrtie.html`로 이동하도록 설정
  * `post()`는 `write.html`에서 작성 버튼을 클릭하였을 때 해당 값을 받아와서 확인하도록 설정

* 이대로 동작하면 `req.body`가 보이지 않음

  * `body-parser`를 이용하도록 `app.js` 파일 수정

    ```js
    const bodyParser = require('body-parser');
    
    app.use(bodyParser.json());
    app.use(bodyParser.urlencoded({ extended : false }))
    ```

    * `body-parser`는 node에 기본적으로 딸려오는 Module이므로 `npm install`을 진행하지 않음
    * `app.use`와 같이 설정함으로써 Request의 Body를 사용할 수 있게됨

## 정적파일

* Image등 정적파일들을 uploads폴더에 넣어두고 그를 Web에서 보여줄 수 있음

* uploads폴더 생성

* `app.js` 파일 수정

  ```js
  app.use('/uploads', express.static('uploads'));
  ```

* uploads 폴더에 sample image 삽입

  * `localhost:3000/uploads/sample.jpg`로 접속하여 image 확인

## Global View Variable

## 404, 500 Error Handling

## nunjucks Macro

## Express 권장 구조

# 참고

## HTTP 상태코드

| 상태코드 | 설명                        |
| -------- | --------------------------- |
| 1XX      | 조건부응답                  |
| 2XX      | 응답성공                    |
| 3XX      | 리다이렉션                  |
| 4XX      | 요청오류(ex, 404 Not Found) |
| 5XX      | 서버오류                    |

