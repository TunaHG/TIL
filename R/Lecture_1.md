# Lecture 1

> > R에 대한 체계적인 공부는 Fastcampus에서 공부할 때 진행했었다.
> >
> > 해당 부분은 예전 진행하던 블로그에 포스팅 되어있는 상태이므로 [블로그](https://blog.naver.com/asdf0185/221423751190)를 참고하는게 더 좋다.
> > 또한 포스팅된 코드들을 [다음](FastCampus)에 올려두었다.
>
> 아래의 내용은 다음의 [파일](R_Workkspace/R_Lecture/Lecture1.R)에 해당 내용을 주석으로도 작성해 두었다.

## Feature

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
* `abs()`
  * 절대값
* `sqrt()`
  * 제곱근
* `factorial()`
  * 팩토리얼
* `mode()`
  * 해당 Data의 Type을 알 수 있는 함수
* `is.xxx()`
  * 해당 Data가 xxx에 해당하는 Type인지 아닌지를 확인하는 함수
* `as.xxx()`
  * 해당 Data를 xxx에 해당하는 Type으로 Casting하는 함수
* `help()`
  * 특정 함수, 객체 등에 대하여 manual을 출력한다.

## Data Type

### 기본

* Numeric
  * 수치형, 정수와 실수를 구분하지 않는다.
* Character
  * 문자형, 문자와 문자열을 의미하며 '', ""를 혼용하여 사용할 수 있다.
* Logical
  * 논리형, TRUE(T)와 FALSE(F)로 이루어진 Type
* Complex
  * 복소수형, 4-3i와 같이 허수를 표현할 수 있는 Type

### 특수

* NULL
  * 존재하지 않는 객체를 지정할 때 사용
* NA
  * Not Available, 일반적으로 결측치(Missing Value)를 나타낼 때 사용
* NAN
  * Not A Number, 수치값이지만 숫자로 표현이 안되는 값
* Inf
  * Infinite, 0의 무한대

### 우선순위

* Character > Complex > Numeric > Logical

## Operator

### 산술연산자

* `+`, `-`, `/`, `*` 사칙연산이 가능하다.
* 몫을 계산하는 연산자는 `%/%`를 사용한다.
* 나머지를 계산하는 연산자는 `%%`를 사용한다.

### 비교연산자

* 다른 언어에서 사용한 것과 동일하다.
* `==`, `!=`등을 사용하며 TRUE, FALSE값을 출력한다.

### 논리연산자

* `&`, `&&` : AND연산자로 의미는 동일하다.
* `|`, `||` : OR연산자로 의미는 동일하다.
* 다만 하나를 사용할 때와 두개를 사용할 때 Vector와 Scalar에 따라 동작이 다르다.

## Package

* R의 package는 처리할 Data + 기능(함수, 알고리즘)

> R의 package 시스템
> 1. base System
>    - base package
>    - recommended package
> 2. other package

* install
  * `install.packages("")`
* remove
  * `remove.packages("")`
* 설치한 패키지를 사용할 때는 메모리에 loading한 후 사용한다.
  * `library()`
* 패키지가 어디에 설치되는지 확인할 수 있다.
  * `.libPaths()`
  * `()`안에 경로를 입력하는 패키지가 설치되는 경로를 지정할 수 있다.

## Data Structure

### Vector

> 기본적으로 사용되는 자료구조

*  Vector  1차원, 같은 데이터 타입만 사용할 수 있다.
*  Vector 중에 원소가 1개만 있는 Vector는 Scalar이다.
*  R은 Index가 0이 아니라 1부터 시작한다.
*  Vector를 생성하는 방법
   *  컴바인함수인 `c()`를 사용한다.
   *  `:`를 사용한다.
      *  수치형 데이터만 만들 수 있으며 단조증가, 단조감소 형태의 Vector를 생성한다.
   *  `seq()`를 사용한다.
      *  `()`안에는 start, end, by로 어디부터 어디까지 얼마만큼씩의 차이를 두고 반복할것인지로 사용한다.
   *  `rep()`를 사용한다.
      *  반복적인 값을 이용하여 생성한다.

* `length()`
  * Vector의 길이를 반환하는 함수
* Vector의 연산
  * 각 Vector의 index끼리 연산을 진행한다.
  * Recycle Rule
    * 크기가 작은 Vector의 값들을 반복해서 크기를 맞춘다음 연산한다.

* Vector의 집합연산
  * `union()` : 합집합
  * `intersect()` : 교집합
  * `setdiff()` : 차집합