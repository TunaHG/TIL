# Github Pages

> `Github`에서 호스팅해주는 Page를 만들 수 있다.

* [Github Pages](https://pages.github.com/)

> `Web`에 대해서 잘 모르니 일반적인 Template을 사용하여 만들어 본다.

* Template Site [Start Bootstrap](https://startbootstrap.com/) 
  * Template ["Resume"](https://startbootstrap.com/themes/resume/) Free Download

## Github Pages Hosting Example

1. Resume.zip을 압축해제하여 해당 폴더에서`git init`을 진행한다.
2. 전부 `add`, `commit`한다. LF_CRLF Error가 발생할 수 있다. [참고](./LF_CRLF_Error.md)
3. `index.html`을 수정한다.
   1. VS Code를 이용하여 index.html파일을 연다.
   2. **Change Title** `(Line 11)`
   3. **Change Name** `(Line 30)`
   4. **Change Name** `(Line 66, 67)`
      위치를 찾고 싶으면 index.html을 크롬창으로 연 다음 해당 부분에서 마우스 우클릭, 검사 클릭
4. 변경사항이 있으므로 다시 `add`, `commit`을 진행한다.
5. Repository가 지정이 안되있으므로 **nickname.github.io**로 name을 지정하고 new repository를 생성한다.
6. 생성한 Repository에 index.html파일이 들어간 것을 확인하고 도메인 **nickname.github.io**로 진입하면 호스팅받는 웹사이트가 나타난다.
7. **Profile 사진 변경**, `Resume/img` 폴더의 `profile.jpg`파일을 원하는 사진으로 변경한다.
8. `index.html`에서 `Line 77`부분의 <a href>태그의 `#`을 도메인으로 변경한다.
9. git push 이후 사진이 변경이 안된다면 F12의 검사창을 켜둔 후 새로고침에 오른쪽 마우스 클릭을 하면 나오는 **캐시비우기 및 강력 새로고침**을 진행하면 변경된다. (크롬에서 지원하는 기능으로 같은 이미지 파일을 로딩하면 이전에 로딩한 파일로 보여주는 기능이 있다.)
10. `index.html`에서 `Line 200`부분의 <i>태그의 `class`를 수정해서 로고를 변경할 수 있다.
    [Font Awesome](https://fontawesome.com/) - [Icon](https://fontawesome.com/icons)에서 지원하는 이름으로 가능하다.
11. `Resume/css`에서 `resume.css`의 맨 마지막 부분의 `primary` 태그 둘에서 색을 변경해준다.
    이후 `index.html`의 `Line 22`에서 `link`태그의 `href`가 `resume.min.css`인 것을 `resume.css`로 변경

## Markdown 기반 Blog

> 정적 템플릿 생성기 : md -> html/css로 변경해준다.

### Jekyll

* 오래되서 레퍼런스가 많다.
* 카카오 기술블로그 기반

### Gatsby

* 최신 프레임워크
* github octoverse 기준으로 2019년 가장 많이 성장한 오픈소스 프로젝트 TOP10
* 최근 웹 트렌드 기술(react, graphql)이 반영되어 있음.

