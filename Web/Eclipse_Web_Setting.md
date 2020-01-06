# Eclipse Web Setting

### Perspective

* Eclipse창의 우측 위의 `Open Perspective`를 사용하거나 `Windows` - `Perspective` - `Open Perspective`를 클릭하여 `Web`을 선택한다. 안보인다면 `Other`에서 탐색하면 된다.

### Dynamic Web Project

* Dynamic Web Project를 생성한다.
* 이 때, Dynamic Web module Version을 3.1로 조정한다. Java 8버전에 맞도록 설정하는 것이다.
* Next를 두번 눌러서 마지막 설정 페이지에서 Generate web.xml Deployment Descript를 체크한다.
  * JSP, Spring등에서는 설정파일로 `.XML`파일을 사용한다.

### Tomcat

* [Tomcat Site](https://tomcat.apache.org)에서 Tomcat 8버전을 다운로드 받는다.
  * 8.5.50버전을 다운로드 받는다.
    원하는 형태로 다운로드 받아도 되나, 압축형 파일이 문제가 생겼을 때 폴더를 삭제하고 새로 압축을 푸는 형태로 쉽게 다시 받을 수 있어서 압축형 파일로 다운로드 받았다.

* 압축파일을 해제하면 나오는 폴더를 살펴본다

  * `\bin\startup.bat`파일이 서버 시작파일이다.

  * `\conf\server.xml`파일이 서버 설정파일이다.

  * `\webapps\ROOT\index.jsp`파일이 `localhost:8080`으로 진입시 나오는 웹페이지이다.

    * 이 때 사용자이름과 비밀번호를 입력하는 창이 뜨거나 Tomcat창이 아닌 다른창이 뜬다면 문제가 있는 것이다. `8080`으로 설정된 `TOMCAT Port`가 이미 사용중이란 소리인데, `Oracle DB`를 사용중이고, `Port`를 건든적이 없다면 해당 `Oracle DB`의 `Port`가 `8080`일 것이다.

      * `Oracle DB`의 `Port`를 확인하고자 하면 관리자 계정으로 로그인하여 다음 쿼리문을 실행한다. 

        ```sql
        SELECT dbms_xdb.gethttpport() from dual;
        ```

      * `Oracle DB`의 `Port`를 `9090`으로 변경해준다.

        ```sql
        EXEC dbms_xdb.sethttpport(9090);
        ```

### Content Type

* `Windows` - `Preferences` - `Content Type`의 다음 항목들의 `Default Encoding`을 `UTF-8`로 변경한 후 `Update`한다.
  * `CSS`, `HTML`, `Java Properties file`, `Java Source file`, `Javascript Source file`, `JSP`

## ServerTest

* 생성한 후 `EUC-KR`을 전부 `UTF-8`로 변경해준다.
* `<%@ page %>`는 JSP시작태그이다.
  * TOMCAT의 lib폴더의 `el-api.jar`, `jsp-api.jar`, `servlet-api.jar`를 JAVA의 jre폴더의 ext폴더로 복사하여 붙여넣는다.

* `HTML`을 실행하여 웹페이지를 살펴보는 것은 `java`코드 실행과 동일하게 `Ctrl + F11`로 진행한다.
  * Tomcat을 Server로 지정하고 구동하면 Eclipse내부에 웹페이지가 표시된다
  * Eclipse 내부 웹페이지를 사용하지 않고 Chrome을 사용하기 위하여 `Windows` - `Web Browser` - `Chrome`을 선택해두고 다시 실행하면 된다.
* `HTML`파일 내부에 `JAVA Code`를 작성하고 싶다면 `<% %>`내부에 작성하면 된다.
  * Tomcat에서 해석되서 내용만 `HTML`파일로 나가기 때문에, 웹페이지에서 소스를 살펴보면 코드가 보이는 것이 아니라 코드의 완성내용만 보인다.