# R Start

> R 이란, 통계계산을 위해서 만들어진 프로그래밍 언어이면서 소프트웨어
>
> AT&T의 BELL연구소에서 만들어진 S라는 언어에서 발전됨
>
> 1993년 로스이하카, 로버트 젠틀맨에 의해서 개발되었고 현재는 R 코어팀에 의해서 유지보수 개발 중

### R로 할 수 있는 기능

* 통계분석
  * 기초 통계
  * 가설 검정
* 머신러닝
* 텍스트 마이닝

### R 이외에도 데이터 분석이 가능한 Tool

* SAS, SPSS
  * 유료로 이용가능, 통계전문
* Excel
  * 기본적인 통계기능을 포함하고 있다.

### R의 특징

* 무료로 사용가능
  * 유료 Tool에 버금가는 기능을 가지고 있다.
* 코드 베이스(재연성)

### Python VS R

* R은 순수한 데이터분석에 사용된다. 데이터를 분석하여 결과를 브리핑할 때.
* Python은 분석된 데이터를 Python과 연결된 Web등의 시스템에 연관시키기 좋다.

## R Download

* [Download Site](https://cran.r-project.org/)로 진입한다.
  * Download R for Windows로 진입한 후 base를 클릭한다.
  * [Download R 3.6.3 for Windows](https://cran.r-project.org/bin/windows/base/R-3.6.3-win.exe)을 클릭한다.
  * 해당 파일을 실행하면 된다.
* 만약 이전에 R을 설치해본 경험이 있다면 Update를 진행하면 된다.
  * 위의 방법처럼 진행하는 것과 크게 다르지 않다.
  * R GUI에서 installr패키지를 install한 후 `installr::updateR()`을 진행하면된다.
  * 이 방법을 사용하면 이전에 사용하던 Rprofile이나 package들을 그대로 가져오는 과정을 진행할 수 있다.

## RStudio Download

> R을 편하게 사용할 수 있는 IDE인 RStudio를 다운로드 받아야 한다.

* [Download Site](https://rstudio.com/products/rstudio/)에서 RStudio Desktop에 대한 Download를 클릭하고 무료버전을 다운로드 받는다.
* 다운로드 받은 EXE파일을 실행해서 다른 변경없이 설치하면된다.

## Start

### Create New Project

* File - New Project - New Directory - New Project로 진입하여 새로운 프로젝트를 생성한다.

  * 프로젝트 이름은 간단하게 R_Lecture로 지정했으며, 프로젝트의 경로는 내가 공부하고 있는 폴더인 TIL의 R폴더 내부에 R_Workspace폴더를 생성하여 지정하였다.

    ![image-20200309102803656](image/image-20200309102803656.png)

### Setting

* Tools - Global Option로 진입하여 환경설정을 진행한다.

  * Tools의 Project Option은 각 프로젝트 마다 설정을 다르게 할 때 사용한다.

* Global Option - Code - Editing에서 Soft-wrap R source File을 체크한다.

  * 이는 R Script에서 화면을 넘어가는 R Code를 줄바꿈을 진행한 것처럼 보여줘서 보기 편하게 해준다.

    ![image-20200309103236348](image/image-20200309103236348.png)

* Tools - Global Option - Code - Saving에서 가장 아래 Default text encoding을 UTF-8로 변경한다.

  ![image-20200309103334952](image/image-20200309103334952.png)

### Feature

> 다음의 [파일](R_Workkspace/R_Lecture/Lecture1.R)에 해당 내용을 주석으로도 작성해 두었다.

* `#` : 주석처리
  * 단축키 Ctrl + Shift + C를 사용하면 현재 커서의 Line을 주석처리한다.
  * 범위를 지정한 후 단축키를 사용하면 지정된 범위 전부 주석처리된다.
* `;`
  * 한 줄에 하나의 Statement만 작성하면 `;`을 생략할 수 있다.
* Script 실행
  * Ctrl + Enter를 입력하면 현재 Script에 커서의 위치에 해당하는 Line이 콘솔창에 실행된다.
  * 주석처리와 마찬가지로 여러줄을 실행하고 싶다면 범위를 지정하고 진행하면 된다.

* Data Type
  * R은 Weak타입이기 때문에 Strong타입인 Java와 다르게 Data Type을 선언하지 않는다.
  * 이후에 R에서 사용하는 Data Type에 대해 공부한다.
* `=`, `<-`, `->`
  * R에서 값을 할당하는 방법이다.
  * 변수 선언시에는 보통 화살표를 사용한다.
    * 화살표의 단축키는 Alt + -이다.
  * `=`는 보통 Function이나 Argument에서 값을 할당할 때 사용한다.
* 변수를 출력하는 방법
  * 해당 변수를 그대로 실행
  * `print()`를 이용해서 출력
    * 여러 개의 변수를 출력할 수 없다.
  * `cat()`을 이용하여 출력
    * 여러 개의 값을 한번에 출력할 수 있다.
    * file argument를 추가하여 경로와 파일을 지정하면 해당 파일을 수정한다. 없다면 생성한다.
    * append argument를 추가하여 TRUE값을 지정하면 해당 파일을 수정할 때 기존의 내용을 두고 뒤에 내용을 추가한다.
* `options(digits = )`
  * 숫자가 표현될 때 몇개의 숫자가 표현될 지 지정한다.
  * default값은 7이다.
* `sprintf("%.8f", result)`
  * C와 Java처럼 format을 이용한 출력이 가능하다.
* 산술연산
  * `+`, `-`, `/`, `*` 사칙연산이 가능하다.
  * 몫을 계산하는 연산자는 `%/%`를 사용한다.
  * 나머지를 계산하는 연산자는 `%%`를 사용한다.
* 비교연산
  * 다른 언어에서 사용한 것과 동일하다.

### Data Type

#### Vector

* 1차원 데이터이다.
* 같은 데이터 타입만 사용할 수 있다.
* Index가 0이 아닌 1부터 시작한다.
* 원소가 1개만 있는 Vector는 Scalar라고 한다.
* 컴바인 함수 `c()`를 사용하여 원소가 여러개인 Vector를 생성할 수 있다.

### Operator

#### 산술연산자

* `+`, `-`, `/`, `*` 사칙연산이 가능하다.
* 몫을 계산하는 연산자는 `%/%`를 사용한다.
* 나머지를 계산하는 연산자는 `%%`를 사용한다.

#### 비교연산자

* 다른 언어에서 사용한 것과 동일하다.
* `==`, `!=`등을 사용하며 TRUE, FALSE값을 출력한다.

#### 논리연산자

* `&`, `&&` : AND연산자로 의미는 동일하다.
* `|`, `||` : OR연산자로 의미는 동일하다.
* 다만 하나를 사용할 때와 두개를 사용할 때 Vector와 Scalar에 따라 동작이 다르다.

## 참고

* MultiCampus에서 배우는 R수업보단 FastCampus에서 수강한 R수업이 좀 더 체계적이였다.
  * 그 때 배웠던 Code를 첨부하니, 이를 활용하는 것도 좋겠다.
  * [FastCampus RDS](FastCampus)