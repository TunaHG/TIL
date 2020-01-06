# Web Start

* [최초의 웹](info.cern.ch)
  * 문서를 링크만 걸어서 이동하는 형태

## Basic

* Client
  * 서비스를 요청하는 입장
  * `HTML`, `CSS`, `JS`, etc
  * Client가 보는 UI를 담당하는 분야가 Front-End

* Server
  * 서비스를 제공해주는 입장
  * `Database`, `Framework`, `JSP`, `php`, `aspx`, etc
  * Server의 구성을 담당하는 분야가 Back-End
* Client가 Server에 `request`를 보내면 Server가 `response`로 `HTML`을 전송해주는 방식.
* 해석자체가 Browser에 있으면 **Client Side Script**인데, 이는 `HTML`태그를 쉽게 얻을 수 있기 때문에 보안에 취약하다.
* 해석자체가 Server에 있으면 **Server Side Script**이며, 작동방식을 숨기고 작동결과만을 `HTML`태그로 반환하는 방식이기에 **Client Side Script**보다 보안이 강하다.
* Web의 구성
  * 문서구조 : `HTML`
  * 디자인 : `CSS`
  * 기능, 동작 : `JavaScript`
  * 각 담당 기술은 하나씩 따로 구동될 순 없음. 각 파일은 따로 구성될 수도 있으나 `.html`파일 내부에 `CSS`와 `JS`구개가 포함될 수 있다. 이 때 `CSS`는 `<STYLE>`태그에, `JS`는 `<SCRIPT>`태그에 만들면 된다.
* 새로 접속할 때마다 페이지 일부가 변경되는 페이지를 **동적 페이지**라 한다. 그와 반대로 어떤 변화도 없는 페이지를 **정적 페이지**라 한다.

# Reference Site

* [W3 Schools](https://w3schools.com)