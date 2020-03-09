#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Lecture : Data                                           #
#                                                          #
# Date    : December 17, 2018                              #
# Author  : Hagyun Kim                                     #
# Helper  : Buil Lee                                       #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

# 1. Data type ----
# 1.1 수치형(Numeric) ----
# (1) 정수형(integer) ----
x1 <- 10
x2 <- 10L

# (2) 실수형(double) ----
x3 <- 10.2


# 1.2 문자형(Character) ----
x4 <- 'Love is not feeling.'
x5 <- "Love is choice."


# 1.3 논리형(Logical) ----
x6 <- TRUE
x7 <- FALSE


# 2. 데이터 유형을 알아내기 ----
# 2.1 mode(data) ----
mode(x1)
mode(x2)
mode(x3)
mode(x4)
mode(x5)
mode(x6)
mode(x7)

# 2.2 typeof(data) ----
typeof(x1)
typeof(x2)
typeof(x3)
typeof(x4)
typeof(x5)
typeof(x6)
typeof(x7)

# 2.3 is.xxxx(data) -----
is.numeric(x1)
is.numeric(x2)
is.numeric(x4)

is.character(x1)
is.character(x5)

is.logical(x5)
is.logical(x6)


# 3. 데이터 유형을 강제적으로 변환하기 ----
# as.xxxx(data)
x1 <- 10
x2 <- "10"
x3 <- "Lee"
x4 <- FALSE

as.numeric(x2)   # character -> numeric   : ok
as.numeric(x3)   # character -> numeric   : not ok
as.numeric(x4)   # logical   -> numeric   : ok

as.character(x1) # numeric   -> character : ok
as.character(x4) # logical   -> character : ok

as.logical(x1)   # numeric   -> logical   : ok
as.logical(x2)   # character -> logical   : not ok
as.logical(x3)   # character -> logical   : not ok


# 4. 데이터 유형의 우선순위 ----
# Character > Numeric > Logical