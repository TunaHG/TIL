# Hyperlink in Markdown

> 링크를 클릭하여해당 링크로 이동할 수 있는 기능이다.

* 하이퍼링크는 `[Link name](Link)`로 설정한다.

## URL을 이용한 Link

* `[Link Name](URL)`로 입력한다.
* 해당 Link Name을 클릭하면 기본 브라우저가 켜지며 해당 URL로 이동한다

## 폴더 경로를 이용한 Link

* `[Link Name](Directory)`로 입력한다
* `.`은 현재 폴더를 가르킨다. (`./Java`는 현재 폴더내의 Java라는 폴더를 의미한다.)
* `..`은 상위 폴더를 의미한다. (`../Java`는 상위 폴더내의 Java라는 폴더를 의미한다.)
* **폴더로 이동할 수도 있고, 파일로 바로 이동할 수도 있다.**

## Markdown 내부의 글을 이용한 Link

* `[Link Name](#text)`로 입력한다.
* `text`라는 글이 있는 현재 Markdown파일 내부의 위치로 이동한다.
* 이 때, `text`를 작성할 때 영어는 소문자로만 작성하며 띄어쓰기는 `-`로 작성한다.