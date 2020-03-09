# R의 주석은 #을 이용한다. 
# 주석의 단축키는 Ctrl + Shift + C이며 범위를 지정하여 한번에 주석처리할 수 있다.

# ";"는 한 라인에 하나의 statement만 존재할 경우 생략이 가능하다.
a = 100

# 작성된 코드를 실행하려면 Ctrl + Enter
b = 200

# R은 대소문자를 구분한다. Case-Sensitive
B = 300

# R은 Weak Type이기 때문에 변수 선언시 Type을 명시하지 않는다.
# 또한 '='를 사용해도 되지만 변수 선언시에는 보통 '<-'를 사용하여 선언한다.
# '<-'의 단축키는 Alt + -로 사용한다.
# <-는 물론 ->도 사용이 가능하다.
B <- 200
300 -> B

# Camel-Case notation
# 두 단어가 합칠 때 앞의 단어는 첫글자가 소문자, 뒤의 단어는 첫글자가 대문자.
myName = "김하균"

# 두 단어가 합칠 때 앞, 뒤 단어 전부 첫글자를 대문자로 하는 방법은 Paskal이라 한다.
# Java, R에서는 보통 Camel-Case notation을 사용한다.


# Data Type(자료형), Data Structure(자료구조)
# Vector  1차원, 같은 데이터 타입만 사용할 수 있다.
# Vector 중에 원소가 1개만 있는 Vector는 Scalar이다.
# R은 Index가 0이 아니라 1부터 시작한다.
myVar <- 100
result <- myVar + 200

# 값이 여러개인 Vector를 생성하기 위해 컴바인함수인 c()를 사용한다.
c(TRUE, FALSE)

# 변수의 값을 출력하려면
# - 해당 변수를 그대로 실행
# - print()를 이용해서 출력, print()는 여러 개의 변수를 출력할 수 없음.
result
print(result)

# 여러 개의 값을 한번에 출력하려면 cat()을 사용
# file argument를 추가하여 경로를 경로와 파일을 지정하면 해당 파일을 작성한다.
cat("결과값은: ", myVar, result, file = "C:/TIL/R/R_Workspace/R_Lecture/test.txt")

# 작성된 파일에 내용을 추가하고 싶은 경우 append=TRUE를 추가한다.
# R에서는 TRUE, FALSE처럼 대문자로 사용하거나 T, F와 같이 사용한다.
cat("결과값은: ", myVar, result, file = "C:/TIL/R/R_Workspace/R_Lecture/test.txt", append=TRUE)

##################################################################################################

# 기본적인 연산자는 다른 언어와 상당히 유사
var1 <- 100
var2 <- 3

result <- var1 / var2

result # 33.33333 (총 7개의 digit으로 표현 - default)
# 표현되는 digit의 수를 지정한다.
options(digits = 5)
result # 33.333
# C와 Java처럼 format을 이용한 출력도 가능
sprintf("%.8f", result)

# 몫을 구하고 나머지를 구한다.
result <- var1 %/% var2
result
result <- var1 %% var2
result

##################################################################################################

# 비교연산 => 다른언어와 동일하다.
var1 <- 100
var2 <- 200
var1 == var2
var1 != var2

# 논리연산 => 약간 주의한다.

# &, && => 의미는 동일하다. (AND 연산)
# |, || => 의미는 동일하다. (OR 연산)
# 하나를 사용할 때와 두개를 사용할때는 Vector인지 Scalar인지에 따라 동작이 다르다.
# &를 이용하면 각 Vector의 같은 Index끼리 연산하여 결과를 Vector로 반환한다. (벡터화 연산)
c(TRUE, FALSE) & c(TRUE, TRUE)

# &&를 이용하면 맨 처음에 있는 요소를 가지고 연산
c(TRUE, FALSE) && c(TRUE, TRUE)

# 기본적으로 사용하는 함수들이 있다.
abs(-3) # 절대값
sqrt(4) # 제곱근
factorial(4) # 팩토리얼

##################################################################################################

# R의 Data Type
# 1. numeric(수치형) : 정수와 실수를 구분하지 않는다.
#    100, 100.3, 10L(정수) 나머지는 실수
# 2. character(문자열) : 하나의 문자, 문자열 둘다 문자열로 간주된다.
#    ''와 ""를 혼용해서 사용할 수 있다.
var <- "홍길동"
# 3. logical(논리형) : TRUE(T), FALSE(F)
# 4. complex(복소수형) : 4-3i

# 특수 Data Type
# 1. NULL (java의 null과 유사한 의미)
#   존재하지 않는 객체를 지정할 때 사용
# 2. NA (Not Available)
#   일반적으로 결측치(missing value)를 표현할 때 사용
# 3. NAN (Not A Number)
#   수치값이지만 숫자로 표현이 안되는 값
sqrt(-9)
# 4. Inf(Infinite) : 0의 무한대
3 / 0

##################################################################################################

# R에서 제공하는 기본적인 함수 2개
# mode() : 데이터 타입을 알려주는 함수
var1 <- TRUE
mode(var1)

# is 계열의 함수
var2 <- 300
is.double(var2)
is.integer(var2)

##################################################################################################

# 데이터 타입의 우선순위
# Character > Complex > Numeric > Logical

# 기본적으로 사용되는 자료구조가 Vector
myVar <- c(10, 20, 30, 40)
myVar

myVar <- c(10, 20, 30, TRUE)
myVar

myVar <- c(10, "홍길동", 30, TRUE)
myVar

# as 계열의 함수를 이용한 casting(형변환)
myVar <- "100"
as.numeric(myVar)

##################################################################################################

# R Package

# R의 package는 처리할 Data + 기능(함수, 알고리즘)

# R의 package 시스템은
# 1. base System
#     - base package
#     - recommended package
# 2. other package

# 간단하게 package를 하나 설치해본다.
install.packages("ggplot2")
# 어딘가에 설치된다.
# package를 삭제하려면
remove.packages("ggplot2")

# 어디에 설치됬는지 확인해본다.
.libPaths()
# 설치 위치를 변경하려면
.libPaths("C:/myLib")

# package를 설치한 후 사용하기 위해서는 메모리에 loading해야한다.
library(ggplot2)
require(ggplot2)

myVar <- c("남자", "여자", "여자", "여자", "여자", "남자")

qplot(myVar)

help(mean)
# help()를 이용해도 좋으나 RDocumentation.org 사이트를 이용하는게 더 좋다.

##################################################################################################

# 자료구조

# 자료형은 저장된 데이터의 타입을 지정
# 자료구조는 데이터가 ㅁ모리에 어떤 방식으로 저장되어 있는가

# homogeneous
# - 1. Vector : 1차원 선형 구조, 순서 개념이 존재, 같은 종류의 데이터 타입을 이용
# - 2. Matrix : 2차원 구조, Index를 사용할 수 있다.  같은 종류의 데이터 타입을 이용
# - 3. Array  : 3차원 이상의 구조, Index를 사용할 수 있다. 같은 종류의 데이터 타입을 이용

# heterogeneous
# - 1. List : 1차원 선형구조, 순서 개념이 존재, 실제 저장되는 구조는 map 구조
# - 2. Data Frame : 2차원 테이블 구조

##################################################################################################

# Vector : 1차원 선형자료구조, 순서의 개념이 있다.
#          index를 이용하여 Vector를 사용할 수 있다. 시작은 1
#          []를 이용해서 각 요소를 access할 수 있다.
#          요소가 1개인 Vector는 Scalar이다.
myVar <- c(100)
myVar

# Vector를 만드는 방법
# 1. combine() 함수를 이용한다. => c()
#    Vector를 만드는 가장 대표적인 방법
#    2개 이상의 Vector를 하나의 Vector로 만들 때도 사용할 수 있다.
myVar1 <- c(10, 20, 30)
myVar2 <- c(3.14, 10, 100)

myVar1
myVar2

result <- c(myVar1, myVar2)
result

# 2. ":"를 이용해서 만드는 방법
#    수치형 데이터만 만들 수 있고 단조증가, 단조감소 형태의 Vector를 생성
myVar <- 1:10 # (start:end)
myVar
myVar <- 8.7:2

# 3. 2번의 일반형 seq()
myVar <- seq(1, 10, 2)
myVar <- seq(from=1, to=3, by=-3)
myVar

# 4. 반복적인 값을 이용해서 Vector생성
myVar <- rep(1:3, times=3)
myVar
myVar <- rep(1:3, each=3)
myVar

# 많이 사용하는 함수 중 하나가 Vector안의 요소 개수를 알아내는 함수
myVar <- c(10, 20, 30, 40)
length(myVar)

# Vector 요소의 사용 (indexing 방식)
myVar <- c(3.14, 100, "Hello", TRUE, 300)
myVar

myVar[1] # 첫번째 요소 Access
myVar[length(myVar)]# 마지막 요소 Access

result <- myVar[2:4] # Slicing
result
result <- myVar[c(2, 3, 5)] # Fancy indexing
result
myVar[-1]
myVar[-(3:4)]
myVar[-c(1, 4, 5)]

# Vector 데이터에 이름을 붙인다.
myVar = c(10, 20, 30, 40, 50)
myVar

names(myVar)
names(myVar) <- c("a", "b", "c", "d", "e")
names(myVar)
myVar

# Vector 연산
myVar1 <- 1:3
myVar1 <- 4:6

result <- myVar1 + myVar2
result

myVar3 <- 1:6

result <- myVar1 + myVar3 # Recycle Rule
result

# Vector에 대한 집합 연산(합집합, 교집합, 차집합)
var1 <- 1:5
var2 <- 3:7

union(var1, var2)
intersect(var1, var2)
setdiff(var1, var2)