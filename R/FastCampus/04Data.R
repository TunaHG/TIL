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
# �ϳ��� ��(column)�� �����Ǿ� ����. 1���� ����.
# ������ �м��� �⺻ ����
# �ϳ��� ������ ������ ����

# 1.1 Vector ����� ----
# (1) �ϳ��� ��(element)���� �̷���� Vector
name     <- "���α�"
age      <- 24
marriage <- FALSE


# (2) �� �� �̻��� ������ �̷���� Vector
# i. c(element1, element2, ...)
# c : combine, concatenate�� ����
# element�� ���� ��Ģ�� ���� �� �ַ� �����
# numeric / character / logical vector�� ��� ���� �� ����
our.names    <- c("������", "���ؽ�", "������", "�ӵ���", "���ֿ�", "����")
our.ages     <- c(27, 27, 25, 28, 27, 52)
our.marriage <- c(FALSE, FALSE, FALSE, FALSE, FALSE, FALSE)

c("�̺���", 30, TRUE)
c(30, TRUE)


# ii. :
# numeric vector�� ���� �� ����
# element�� ���� 1�� ���� �Ǵ� 1�� ���ҵǴ� ��Ģ�� 
# �ִ� ���ڵ�� �̷���� Vector�� ����

# ����
# start:end
# start < end : 1�� ����
# start > end : 1�� ����

# start�� �ִ� ���ں��� �����ؼ�
# end�� �ִ� ���ڸ� ���� ���� ������
# 1�� ���� �Ǵ� 1�� ���ҵ�
1:10
1:10000
10:1
10000:1

# ����2
# -2.3:1 ?
-2.3:1

# ����3
# 1:-2.3 ?
1:-2.3


# iii. seq(from = , to = , by = )
# seq : sequence�� ����
# numeric vector�� ���� �� ����
# ��� ����/���Ҹ� ǥ���� �� ����
# :�� Ȯ��

# from : start
# to   : end
# by   : ���� �Ǵ� ������ ��

# from�� �ִ� ���ں��� �����ؼ�
# to�� �ִ� ���ڸ� ���� ���� ������
# by�� �ִ� ���ڸ�ŭ ���� �Ǵ� ���ҵ�

seq(from = 1, to = 5, by = 0.1)
seq(from = 1, to = 1000, by = 10)

# ����4
# 100���� 1�� ���� ���� ������ 
# 5�� �����ϴ� ���ڵ�� �̷���� ���͸� ����ÿ�.
seq(from = 100, to = 1, by = -5)


# iv. rep(vector, times = , each = )
# rep : replicate�� ����
# �־��� ���͸� �����ؼ� �ϳ��� ���͸� ����
# numeric / character / logical vector�� ���� �� ����

rep(1, times = 10)
rep(1, each = 10)

rep(1:2, times = 5)
rep(1:2, each = 5)

# ����5
# "a", "b", "c", "a", "b", "c", "a", "b", "c", "a", "b", "c"�� ���� ���͸� ����ÿ�.
rep(c("a", "b", "c"), times = 4)

rep(1:3, times = 3, each = 5)


# ����6
# "a" : 100��
# "b" : 53��
# "c" " 7��
# �� �̷���� �ϳ��� ���͸� ����ÿ�.
A <- rep("a", times = 100)
B <- rep("b", times = 53)
C <- rep("c", times = 7)
c(A, B, C)
c(rep("a", times = 100),
  rep("b", times = 53),
  rep("c", times = 7))
rep(c("a", "b", "c"), times = c(100, 53, 7)) # ȿ������ �ڵ�.

# ���� : �������� ũ��, �޸����� ����
# object.size(data)
object.size(A)
object.size(B)
object.size(C)
object.size(D)


# v. ���� ���ų� �ʱⰪ���� ���� �����
# vector(mode = , length = )
# mode : "numeric", "character", "logical"
# �ַ� �ʱ�ȭ�� �� �����
vector(mode = "numeric", length = 10)
vector(mode = "character", length = 10)
vector(mode = "logical", length = 10)


# 1.2 Vector�� �Ӽ�(Attributes) ----
height <- c(170, 163, 150)
height
# (1) element�� �̸� : names(vector)
names(height)
names(height) <- c("�ڹ���", "���ֿ�", "����")
height
# NULL : Object�� ���ٴ� �ǹ�
names(height) <- NULL

# (2) element�� ���� : length(vector)
length(height)

# (3) data type      : mode(vector), typeof(vector)
mode(height)
typeof(height)

# (4) is.vector(data)
is.vector(height)

# (5) as.vector(data)


# 1.3 Vector�� Index ----
# index�� ���Ͱ� ������ element���� ��ġ
# index�� 1���� ������


# 1.4 Vector�� Slicing ----
# ��ü ���� �߿��� �Ϻ��� element�� �߶󳻱� = �����ϱ�
# vector[index]
weight <- c(70, 67, 52, 45, 65, 73, 82, 45, 70, 60, 53)
weight[1]
weight[3]

# ����7
# 1, 4, 11��° element�� �� ���� ����������.
c(weight[1], weight[4], weight[11])
weight[c(1, 4, 11)]

# ����8
# 2 ~ 9��° element�� �� ���� ����������.
weight[2:9]

# ����9
# ¦�� ��° element�� �� ���� ����������.
weight[seq(from = 2, to = 11, by = 2)]
weight[seq(from = 2, to = length(weight), by = 2)]


# 1.5 Vector�� Compute ----
v1 <- 1:3
v1

v2 <- 4:6
v2

v1 + v2 
# Vectorization : ����ȭ
# Vectorization : for�� ���� �ݺ����� ������� �ʰ���
# ����� ���� ����
# for���� ����ϸ� �ӵ��� ������

v3 <- 1:9
v1 + v3 
# Recycling Rule : ���� ��Ģ
# ���� ���� ���ʹ� ū ���� ������ ������ ������
# �����ϰ� ������. ��, �߰������� �����͸� �ӽ÷� ����
# �ӽ÷� ���� ���� �ڽ� �ڽ��� ������ ä��

v4 <- 1:5
v1 + v4

5 * v1


# 2. Factor ----
# �ϳ��� ���� �����Ǿ� ����. 1���� ����.
# �ϳ��� ������ ������ ����
# ������ �м��� �⺻ ����
# �������� �ν���
# ������ ���� �ڷ� = ������ �ڷᰡ ��

# 2.1 Factor ����� ----
# factor(vector, labels = , levels = , ordered = )
bt <- c("o", "o", "b", "o", "o", "b")
bt

bt.factor1 <- factor(bt)
bt.factor1

bt.factor2 <- factor(bt, labels = c("B��", "O��"))
bt.factor2

bt.factor3 <- factor(bt, levels = c("o", "b"))
bt.factor3

bt.factor4 <- factor(bt, 
                     levels = c("o", "b"),
                     labels = c("O��", "B��"))
bt.factor4

bt.factor5 <- factor(bt, 
                     levels  = c("o", "b"),
                     labels  = c("O��", "B��"),
                     ordered = TRUE)
bt.factor5
# ��������� Levels : O�� < B�� �� ��µǴµ�
# B���� �� ũ�ٴ� �ǹ̰� �ƴ�, ������ �ִٴ� �ǹ�.

# ordered = FALSE : ���� �ڷ�, ������(nominal) �ڷ�
# ordered = TRUE  : ���� �ڷ�, ������(ordinal) �ڷ�


# 2.2 Factor�� �Ӽ� ----
# (1) ������ ����       : nlevels(factor)
nlevels(bt.factor5)

# (2) ������ �̸�, ���� : levels(factor)
levels(bt.factor5)

# (3) data type         : mode(factor), typeof(factor)
mode(bt.factor5)
typeof(bt.factor5)
# ���� ���̱�� character ��������
# ���������δ� numeric���� �ν��ϰ� ����

# (4) is.factor(data)
is.factor(bt.factor5)
is.factor(bt)

# (5) as.factor(data)
as.factor(bt)

# (6) element�ǰ��� : length(factor)
length(bt.factor5)


# 2.3 Factor�� Index ----
# 1���� ������


# 2.4 Factor�� Slicing ----
# vector�� ������
# factor[index]
bt.factor5[1]
bt.factor5[c(1, 5, 6)]
bt.factor5[2:4]
bt.factor5[seq(from = 2, to = length(bt.factor5), by = 2)]


# 3. Matrix ----
# ��(row)�� ��(column)�� �����Ǿ� ����. 2���� ����
# �ϳ��� ������ ������ ����
# Vector�� Ȯ���� �� : Vectorization, Recycling Rule�� ����
# ��迡 ���� ����

# 3.1 Matrix ����� ----
v1 <- 1:3
v2 <- 4:6
v3 <- 1:6

# (1) rbind(vector1, vector2, ...)
# bind by row
# ���� ���� ���͸� ������ ������
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
matrix(1:4, nrow = 2, ncol = 2)               # ������ �Է�
matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE) # ����� �Է�
matrix(1:4, nrow = 3, ncol = 2)               # recycling rule
matrix(1:9, nrow = 3, ncol = 2)


# 3.2 Matrix�� �Ӽ� ----
M <- matrix(1:4, nrow = 2, ncol = 2)
M

# (1) ���� ����   : nrow(matrix)
nrow(M)

# (2) ���� ����   : ncol(matrix)
ncol(M)

# (3) ���� �̸�   : rownames(matrix)
rownames(M)
rownames(M) <- c("R1", "R2")

# (4) ���� �̸�   : colnames(matrix)
colnames(M)
colnames(M) <- c("C1", "C2")

# (5) ����        : dim(matrix), ���� ������ ���� ������ ���ÿ� �˷���
dim(M)

# (6) ������ �̸� : dimnames(matrix), ���� ���� �̸��� ���ÿ� �˷��� 
dimnames(M)


# 3.3 Matrix�� Index ----
# ���� ó�� ���� : 1
# ���� ó�� ���� : 1

# 3.4 Matrix�� Slicing ----
# matrix[row, column]
M1 <- matrix(1:9, nrow = 3, ncol = 3)
M1[1 , ]              # ù ��, Vector
M1[1, , drop = FALSE] # ù ��, Matrix
M1[1:2 , ]
# �ϳ��� ���̳� �ϳ��� ���� �ڸ��� Vector�� �ȴ�.

M1[ , 1]               # ù ��, Vector
M1[ , 1, drop = FALSE] # ù ��, Matrix
M1[ , c(1, 3)]

M1[1, 1]                # 1��, 1��, Vector
M1[1, 1, drop = FALSE]  # 1��, 1��, Matrix

M1[1:2, 1:2]

# 3.5 Matrix�� Compute ----
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)

# (1) ���� / ����
A + B
A - B

# ��������� �ƴ� ��ĵ��� ����
AA <- matrix(1:2, nrow = 2, ncol = 1)
BB <- matrix(3:4, nrow = 1, ncol = 2)
AA + BB
AA - BB
AA * BB
# ��� Error �߻�

# 18/12/20 ----

# (2) ����
# A %*% B 
# ���� : A ����� ���� ������ B ����� ���� ������ ���ƾ� �Ѵ�.
# ��ȯ��Ģ�� �������� �ʴ´�.
A <- matrix(1:2, nrow = 1, ncol = 2)
B <- matrix(3:4, nrow = 2, ncol = 1)
A %*% B
A <- matrix(1:4, nrow = 2, ncol = 2) # ��Ŀ��� ���� ���� ���� ��������.
B <- matrix(5:6, nrow = 2, ncol = 1)
A %*% B
A <- matrix(1:4, nrow = 2, ncol = 2)
B <- matrix(5:8, nrow = 2, ncol = 2)
A %*% B

# A * B : ����� ���� �ƴ�, ���� Index���� ����.
A * B

# (3) ����� : Inverse Matrix
# solve(matrix) : matrix is square matrix
solve(A)
A %*% solve(A)
# ���������� Ǯ��.
# 2x - y = 7
#  x + y = 2
A <- matrix(c(2, 1, -1, 1), nrow = 2, ncol = 2)
C <- matrix(c(7, 2), nrow = 2, ncol = 1)
solve(A) %*% C

# (4) ��ġ��� (Transpose Matrix)
# ��� ���� �ٲ�


# 4. Array ----
# ������ ����
# �ϳ��� ������ ������ ����
# vector, matrix�� Ȯ��

# 4.1 Array ����� ----
# array(vector, dim = )
array(1:5, dim = 10)          # Array���� Vector, 1����
array(1:5, dim = c(3, 3))     # Array���� Matrix, 2����
array(1:5, dim = c(2, 2, 2))  # Array, 3����


# 5. Data.Frame ----
# ��� ���� �����Ǿ� ����, 2���� ����.
# ���� ���� ������ ������ ���� �� ����. (��İ� �ٸ���)
# ��, �ϳ��� ���� �ϳ��� ������ ������ ����.
# Recycling Rule �� �۵����� ����.
# R���� �����Ͷ�� �ϸ� data.frame�� ����.

# 5.1 Data.Frame ����� ----
# data.frame(vector, factor, matrix)
id     <- 1:4
major  <- c("�濵��", "��ǻ�Ͱ���", "���ڰ���", "��ȭ��������")
major  <- factor(major)
car    <- c("����", NA, "Audi", "G80")
income <- c(3000, 5000, 5000, 3000)
survey <- data.frame(id, major, car, income)


# 6. List ----
# 1���� ����
# ���� ������ ������ ������
# ȸ�ͺм� ���� ����� �����ϴ� ������

# 6.1 List ����� ----
# list(vector, factor, matrix, array, data.frame, list)
food <- c("ȸ����", "�ѽĺ���", "������ũ����", "��콺����ũ", "�ѽĺ���")

result <- list(food, A, survey)
result
# [[]] �� ��µǴ� ���� list �ۿ� ����

# 6.2 List�� Slicing ----
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
