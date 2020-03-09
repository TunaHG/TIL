# Data Type(자료형), Data Structure(자료구조)
# Vector  1차원, 같은 데이터 타입만 사용할 수 있다.
# Vector 중에 원소가 1개만 있는 Vector는 Scalar이다.
# R은 Index가 0이 아니라 1부터 시작한다.
myVar <- 100
result <- myVar + 200

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

result
options(digits = 5)
result