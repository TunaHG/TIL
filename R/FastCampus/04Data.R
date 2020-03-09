#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Lecture : Data                                           #
#                                                          #
# Date    : December 17, 2018                              #
# Author  : Hagyun Kim                                     #
# Helper  : Buil Lee                                       #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

# 1. Vector      *****
# 2. Factor      ***
# 3. Matrix
# 4. Array
# 5. Data.Frame  *****
# 6. List        ***


# 1. Vector ----
# 하나의 열(column)로 구성되어 있음. 1차원 구조.
# 데이터 분석의 기본 단위
# 하나의 데이터 유형만 가짐

# 1.1 Vector 만들기 ----
# (1) 하나의 값(element)으로 이루어진 Vector
name     <- "강민기"
age      <- 24
marriage <- FALSE


# (2) 두 개 이상의 값으로 이루어진 Vector
# i. c(element1, element2, ...)
# c : combine, concatenate의 약자
# element들 간에 규칙이 없을 때 주로 사용함
# numeric / character / logical vector를 모두 만들 수 있음
our.names    <- c("안재현", "오준승", "조인정", "임동신", "윤휘영", "박현")
our.ages     <- c(27, 27, 25, 28, 27, 52)
our.marriage <- c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)

c("이부일", 30, TRUE)
c(30, TRUE)


# ii. :
# numeric vector만 만들 수 있음
# element들 간에 1씩 증가 또는 1씩 감소되는 규칙이 
# 있는 숫자들로 이루어진 Vector를 만듬

# 사용법
# start:end
# start < end : 1씩 증가
# start > end : 1씩 감소

# start에 있는 숫자부터 시작해서
# end에 있는 숫자를 넘지 않을 때까지
# 1씩 증가 또는 1씩 감소됨
1:10
1:10000
10:1
10000:1

# 문제2
# -2.3:1 ?
-2.3:1

# 문제3
# 1:-2.3 ?
1:-2.3


# iii. seq(from = , to = , by = )
# seq : sequence의 약자
# numeric vector만 만들 수 있음
# 모든 증가/감소를 표현할 수 있음
# :의 확장

# from : start
# to   : end
# by   : 증가 또는 감소의 폭

# from에 있는 숫자부터 시작해서
# to에 있는 숫자를 넘지 않을 때까지
# by에 있는 숫자만큼 증가 또는 감소됨

seq(from = 1, to = 5, by = 0.1)
seq(from = 1, to = 1000, by = 10)

# 문제4
# 100부터 1을 넘지 않을 때까지 
# 5씩 감소하는 숫자들로 이루어진 벡터를 만드시오.
seq(from = 100, to = 1, by = -5)


# iv. rep(vector, times = , each = )
# rep : replicate의 약자
# 주어진 벡터를 복사해서 하나의 벡터를 만듬
# numeric / character / logical vector를 만들 수 있음

rep(1, times = 10)
rep(1, each = 10)

rep(1:2, times = 5)
rep(1:2, each = 5)

# 문제5
# "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c"를 갖는 벡터를 만드시오.
rep(c("a", "b", "c"), times = 4)

rep(1:3, times = 3, each = 5)


# 문제6
# "a" : 100개
# "b" : 53개
# "c" " 7개
# 로 이루어진 하나의 벡터를 만드시오.
A <- rep("a", times = 100)
B <- rep("b", times = 53)
C <- rep("c", times = 7)
c(A, B, C)
c(rep("a", times = 100),
  rep("b", times = 53),
  rep("c", times = 7))
rep(c("a", "b", "c"), times = c(100, 53, 7)) # 효율적인 코딩.

# 참고 : 데이터의 크기, 메모리적인 측면
# object.size(data)
object.size(A)
object.size(B)
object.size(C)
object.size(D)


# v. 값은 없거나 초기값으로 벡터 만들기
# vector(mode = , length = )
# mode : "numeric", "character", "logical"
# 주로 초기화할 때 사용함
vector(mode = "numeric", length = 10)
vector(mode = "character", length = 10)
vector(mode = "logical", length = 10)


# 1.2 Vector의 속성(Attributes) ----
height <- c(170, 163, 150)
height
# (1) element의 이름 : names(vector)
names(height)
names(height) <- c("박문일", "김주우", "박현")
height
# NULL : Object가 없다는 의미
names(height) <- NULL

# (2) element의 개수 : length(vector)
length(height)

# (3) data type      : mode(vector), typeof(vector)
mode(height)
typeof(height)

# (4) is.vector(data)
is.vector(height)

# (5) as.vector(data)


# 1.3 Vector의 Index ----
# index는 벡터가 가지는 element들의 위치
# index는 1부터 시작함


# 1.4 Vector의 Slicing ----
# 전체 벡터 중에서 일부의 element를 잘라내기 = 추출하기
# vector[index]
weight <- c(70, 67, 52, 45, 65, 73, 82, 45, 70, 60, 53)
weight[1]
weight[3]

# 문제7
# 1, 4, 11번째 element를 한 번에 가져오세요.
c(weight[1], weight[4], weight[11])
weight[c(1, 4, 11)]

# 문제8
# 2 ~ 9번째 element를 한 번에 가져오세요.
weight[2:9]

# 문제9
# 짝수 번째 element를 한 번에 가져오세요.
weight[seq(from = 2, to = 11, by = 2)]
weight[seq(from = 2, to = length(weight), by = 2)]


# 1.5 Vector의 Compute ----
v1 <- 1:3
v1

v2 <- 4:6
v2

v1 + v2 
# Vectorization : 벡터화
# Vectorization : for와 같은 반복문을 사용하지 않고도
# 결과를 얻어내는 성질
# for문을 사용하면 속도가 느려짐

v3 <- 1:9
v1 + v3 
# Recycling Rule : 재사용 규칙
# 작은 쪽의 벡터는 큰 쪽의 벡터의 데이터 개수와
# 동일하게 맞춰줌. 즉, 추가적으로 데이터를 임시로 만듬
# 임시로 만든 곳은 자신 자신의 값으로 채움

v4 <- 1:5
v1 + v4

5 * v1


# 2. Factor ----
# 하나의 열로 구성되어 있음. 1차원 구조.
# 하나의 데이터 유형만 가짐
# 데이터 분석의 기본 단위
# 집단으로 인식함
# 무조건 질적 자료 = 범주형 자료가 됨

# 2.1 Factor 만들기 ----
# factor(vector, labels = , levels = , ordered = )
bt <- c("o", "o", "b", "o", "o", "b")
bt

bt.factor1 <- factor(bt)
bt.factor1

bt.factor2 <- factor(bt, labels = c("B형", "O형"))
bt.factor2

bt.factor3 <- factor(bt, levels = c("o", "b"))
bt.factor3

bt.factor4 <- factor(bt, 
                     levels = c("o", "b"),
                     labels = c("O형", "B형"))
bt.factor4

bt.factor5 <- factor(bt, 
                     levels  = c("o", "b"),
                     labels  = c("O형", "B형"),
                     ordered = TRUE)
bt.factor5
# 결과값으로 Levels : O형 < B형 이 출력되는데
# B형이 더 크다는 의미가 아닌, 순서가 있다는 의미.

# ordered = FALSE : 질적 자료, 명목형(nominal) 자료
# ordered = TRUE  : 질적 자료, 순서형(ordinal) 자료


# 2.2 Factor의 속성 ----
# (1) 집단의 개수       : nlevels(factor)
nlevels(bt.factor5)

# (2) 집단의 이름, 순서 : levels(factor)
levels(bt.factor5)

# (3) data type         : mode(factor), typeof(factor)
mode(bt.factor5)
typeof(bt.factor5)
# 눈에 보이기는 character 보이지만
# 실질적으로는 numeric으로 인식하고 있음

# (4) is.factor(data)
is.factor(bt.factor5)
is.factor(bt)

# (5) as.factor(data)
as.factor(bt)

# (6) element의개수 : length(factor)
length(bt.factor5)


# 2.3 Factor의 Index ----
# 1부터 시작함


# 2.4 Factor의 Slicing ----
# vector와 동일함
# factor[index]
bt.factor5[1]
bt.factor5[c(1, 5, 6)]
bt.factor5[2:4]
bt.factor5[seq(from = 2, to = length(bt.factor5), by = 2)]


# 3. Matrix ----
# 행(row)과 열(column)로 구성되어 있음. 2차원 구조
# 하나의 데이터 유형만 가짐
# Vector의 확장이 됨 : Vectorization, Recycling Rule이 적용
# 통계에 많이 쓰임

# 3.1 Matrix 만들기 ----
v1 <- 1:3
v2 <- 4:6
v3 <- 1:6

# (1) rbind(vector1, vector2, ...)
# bind by row
# 여러 개의 벡터를 행으로 묶어줌
A1 <- rbind(v1, v2) 
A1

A2 <- rbind(v1, v2, v3)
A2

# (2) cbind(vector1, vector2, ...)
# bind by column
B1 <- cbind(v1, v2)
B1

B2 <- cbind(v1, v2, v3)
B2

# (3) matrix(vector, nrow = , ncol = , byrow = , dimnames = )
matrix(1:4, nrow = 2, ncol = 2)               # 열부터 입력
matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE) # 행부터 입력
matrix(1:4, nrow = 3, ncol = 2)               # recycling rule
matrix(1:9, nrow = 3, ncol = 2)


# 3.2 Matrix의 속성 ----
M <- matrix(1:4, nrow = 2, ncol = 2)
M

# (1) 행의 개수   : nrow(matrix)
nrow(M)

# (2) 열의 개수   : ncol(matrix)
ncol(M)

# (3) 행의 이름   : rownames(matrix)
rownames(M)
rownames(M) <- c("R1", "R2")

# (4) 열의 이름   : colnames(matrix)
colnames(M)
colnames(M) <- c("C1", "C2")

# (5) 차원        : dim(matrix), 행의 개수와 열의 개수를 동시에 알려줌
dim(M)

# (6) 차원의 이름 : dimnames(matrix), 행의 열의 이름을 동시에 알려줌 
dimnames(M)


# 3.3 Matrix의 Index ----
# 행의 처음 시작 : 1
# 열의 처음 시작 : 1

# 3.4 Matrix의 Slicing ----
# matrix[row, column]
M1 <- matrix(1:9, nrow = 3, ncol = 3)
M1[1 , ]              # 첫 행, Vector
M1[1, , drop = FALSE] # 첫 행, Matrix
M1[1:2 , ]
# 하나의 행이나 하나의 열만 자르면 Vector가 된다.

M1[ , 1]               # 첫 열, Vector
M1[ , 1, drop = FALSE] # 첫 열, Matrix
M1[ , c(1, 3)]

M1[1, 1]                # 1행, 1열, Vector
M1[1, 1, drop = FALSE]  # 1행, 1열, Matrix

M1[1:2, 1:2]

# 3.5 Matrix의 Compute ----
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)

# (1) 덧셈 / 뺄셈
A + B
A - B

# 정방행렬이 아닌 행렬들의 연산
AA <- matrix(1:2, nrow = 2, ncol = 1)
BB <- matrix(3:4, nrow = 1, ncol = 2)
AA + BB
AA - BB
AA * BB
# 모두 Error 발생

# 18/12/20 ----

# (2) 곱셈
# A %*% B 
# 조건 : A 행렬의 열의 개수와 B 행렬의 행의 개수가 같아야 한다.
# 교환법칙이 성립하지 않는다.
A <- matrix(1:2, nrow = 1, ncol = 2)
B <- matrix(3:4, nrow = 2, ncol = 1)
A %*% B
A <- matrix(1:4, nrow = 2, ncol = 2) # 행렬에서 값이 들어갈땐 열이 먼저들어간다.
B <- matrix(5:6, nrow = 2, ncol = 1)
A %*% B
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)
A %*% B

# A * B : 행렬의 곱이 아님, 같은 Index끼리 곱함.
A * B

# (3) 역행렬 : Inverse Matrix
# solve(matrix) : matrix is square matrix
solve(A)
A %*% solve(A)
# 연립방정식 풀기.
# 2x - y = 7
#  x + y = 2
A <- matrix(c(2, 1, -1, 1), nrow = 2, ncol = 2)
C <- matrix(c(7, 2), nrow = 2, ncol = 1)
solve(A) %*% C

# (4) 전치행렬 (Transpose Matrix)
# 행과 열을 바꿈


# 4. Array ----
# 다차원 구조
# 하나의 데이터 유형만 가짐
# vector, matrix의 확장

# 4.1 Array 만들기 ----
# array(vector, dim = )
array(1:5, dim = 10)          # Array이자 Vector, 1차원
array(1:5, dim = c(3, 3))     # Array이자 Matrix, 2차원
array(1:5, dim = c(2, 2, 2))  # Array, 3차원


# 5. Data.Frame ----
# 행과 열로 구성되어 있음, 2차원 구조.
# 여러 개의 데이터 유형을 가질 수 있음. (행렬과 다른점)
# 단, 하나의 열은 하나의 데이터 유형만 가짐.
# Recycling Rule 이 작동하지 않음.
# R에서 데이터라고 하면 data.frame을 말함.

# 5.1 Data.Frame 만들기 ----
# data.frame(vector, factor, matrix)
id     <- 1:4
major  <- c("경영학", "컴퓨터공학", "전자공학", "문화콘텐츠학")
major  <- factor(major)
car    <- c("포나", NA, "Audi", "G80")
income <- c(3000, 5000, 5000, 3000)
survey <- data.frame(id, major, car, income)


# 6. List ----
# 1차원 구조
# 가장 유연한 형태의 데이터
# 회귀분석 등의 결과를 저장하는 데이터

# 6.1 List 만들기 ----
# list(vector, factor, matrix, array, data.frame, list)
food <- c("회덮밥", "한식뷔페", "스테이크덮밥", "목살스테이크", "한식뷔페")

result <- list(food, A, survey)
result
# [[]] 가 출력되는 것은 list 밖에 없음

# 6.2 List의 Slicing ----
# (1) list[index]
# (2) list[[index]]

result[1]                 # List
result[1][1]              # List
result[1][[1]]            # Vector
result[[1]]               # Vector
result[[1]][2]            # Vector
result[[1]][c(1, 5)]      # Vector
result[[1]][c(1, 5)][2]   # Vector

result[2]                 # List
result[[2]]               # Matrix
result[[2]][1, , drop = FALSE] # Matrix
result[[2]][1,]           # Vector

result[3]                 # List
result[[3]]               # Data.Frame

