#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#
# Lecture : Import Data                                    #
#                                                          #
# Date    : December 17, 2018                              #
# Author  : Hagyun Kim                                     #
# Helper  : Buil Lee                                       #
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#

# 1. txt 
# 2. csv
# 3. excel : xls, xlsx
# 4. DB : data base


# 1. txt ----
# 1.1 separator : one blank ----
# data.name <- read.table(file = "directory/filename.txt",
#                         header = TRUE,
#                         sep = " ",
#                         stringsAsFactors = TRUE)
blank <- read.table(file = "C:/FastCampus/blank.txt", # C:/Fa 이후 Tab 누를 시 목록표시됨
                    header = TRUE,
                    sep = " ",
                    stringsAsFactors = TRUE)
blank
str(blank)

blank2 <- read.table(file = "C:/FastCampus/blank.txt", # C:/Fa 이후 Tab 누를 시 목록표시됨
                     header = TRUE,
                     sep = " ",
                     stringsAsFactors = FALSE)
blank2
str(blank2)


# 1.2 separator : comma ----
# data.name <- read.table(file = "directory/filename.txt",
#                         header = TRUE,
#                         sep = ",")
comma <- read.table(file = "C:/FastCampus/comma.txt",
                    header = TRUE,
                    sep = ",")
comma


# 1.3 separator : tab ----
# data.name <- read.table(file = "directory/filename.txt",
#                         header = TRUE,
#                         sep = "\t")
tab <- read.table(file = "C:/FastCampus/tab.txt",
                  header = TRUE,
                  sep = "\t")
tab

# 참고 : 문자 처리 또는 분석 - 텍스트 마이닝(Text Mining)
# (1) tab : "\t"
# (2) line feed : "\n" <- separator로 사용하지 않음
# (3) carriage return : "\r"


# 2. csv ----
# comma separated value의 약자
# Excel의 특수한 형태

# data.name <- read.csv(file = "directory/filename.csv",
#                       header = TRUE,
#                       stringsAsFactors = TRUE)
hope <- read.csv(file = "C:/FastCampus/hope.csv",
                 header = TRUE)
hope


# 3. Excel : xls, xlsx ----
# R의 기본 기능으로는 못 읽어옴
# R의 새로운 기능으로 읽어옴

# 기본 기능   : 패키지(pacakage)
# 새로운 기능 : 패키지(pacakage)

# 패키지(pacakage)란?
# (1) 함수   : Function *****
# (2) 데이터 : Data
# (3) 도움말 : Help
# (4) 예제   : Example or Source

# 기본 기능의 패키지 : 9개
# R committee에서 관리함
# R 버전이 업그레이드되는 것은 9개만 됨
search() # 설치된 패키지의 목록 보기

# 새로운 패키지 : 약 13,500개 정도
# 개인들이 관리함
# 패키지당 2MB를 넘지 않도록 제약함

# 엑셀과 관련된 패키지 : readxl

# 18/12/21 ----

# 패키지 설치하기
# 조건 : 인터넷이 연결되어 있어야 함
# 패키지가 업데이트 되지 않은 한 동일 컴퓨터에서는 한 번만 설치함
# install.packages("package.name")
install.packages("readxl")

# 패키지 로딩하기(Loading)
# R과 패키지 연결하기
# 패키지를 메모리에 올리는 기능
# library(package.name) or require(package.name)
# library는 해당 패키지를 사용하고 싶으면 그때마다 로딩해줘야함
library(readxl)

# data.name <- readx1::read_excel(path = "directory/filename.xlsx",
#                                 sheet = "sheet.name" or sheet.index,
#                                 col_names = TRUE)
reading <- readxl::read_excel(path = "C:/FastCampus/reading.xlsx",
                              sheet = "data",
                              col_names = TRUE)
reading

reading2 <- readxl::read_excel(path = "C:/FastCampus/reading.xlsx",
                               sheet = 1,
                               col_names = TRUE)
reading2
# tibble 이라는 데이터 형식으로 출력되는데, 이는 Data.Frame과 같다.
# 변수Type <- dbl = double, chr = character


# 작업공간(Working Directory)
# (1) 현재 설정된 작업공간 알아내기
# getwd()
getwd()

# (2) 작업공간 새로 설정하기
# setwd("directory")
setwd("C:/FastCampus/")

# 제대로 설정 되었는지 확인
getwd()

reading3 <- readxl::read_excel(path = "reading.xlsx",
                               sheet = 1,
                               col_names = TRUE)
reading3


# install.package()는 인터넷에 연결되어 있어야만 가능함
# 인터넷이 안되는 상황에서 패키지 설치하기
# 1단계 : 인터넷이 되는 컴퓨터로 간다.
# 2단계 : www.r-project.org -> CRAN -> Korea
#         -> http://ftp.harukasan.org/CRAN/
#         -> Packages
#         -> Table of available packages
#         -> 다운로드 받고 싶은 패키지를 찾음
#         -> OS에 맞는 압축파일 다운로드
# 3단계 : 외장하드나 USB에 해당 패키지 자료를 저장하기
# 4단계 : 외장하드나 USB에 대해서 보안감사를 받음
# 5단계 : 해당 컴퓨터의 특정 폴더에 복사하여 붙여넣기
# 6단계 : 패키지 설치하기
# install.packages("directory/xxxx.zip", repos = NULL)
#                                        repos <- Local Computer

# 참고 : install.packages("package.name")
# repos : repos = "www.rstudio.com" : default(RStudio)
# repos : 패키지를 다운로드 받는 서버의 주소를 의미

install.packages("dti_1.2-6.1.zip", repos = NULL)


# Useful Packages
# (1) readxl   : Read Excel Data
# (2) writexl  : Write Excel Data
# (3) openxlsx : Read, Write Excel Data
# (4) readr    : 
# (5) foreign  : Read SPSS, SAS Data
# (6) data.table::fread() : Read Big Data
# (7) ROracle  : Read Oracle Database
# (8) RODBC    : Read Database (which is Mysql, Access etc)

# 패키지와 관련된 함수들
# (1) 패키지 설치하기                 : install.packages("package.name")
# (2) 패키지 로딩하기                 : library(package.name) or require(package.name)
# (3) 설치된 패키지 목록보기          : search()
# search()시 번호가 우선순위, 충돌발생시 순위가 높은 패키지의 함수 실행
# (4) 설치된 패키지 목록보기(경로)    : searchpaths()
# (5) 이용가능한 패키지 목록보기      : available.packages()
# (6) 해당 패키지가 설치되었는지 확인 : installed.packages("package.name")
# (7) 패키지 업데이트                 : update.packages("package.name")
# (8) 패키지 다운로드                 : download.packages("package.name") : zip파일로 다운로드
# (9) 메모리에서 패키지 내리기        : detach(package:package.name) : library의 반대
# (10) 패키지 도움말                  : help(package.name) or ?package.name
# (11) 패키지 삭제하기                : remove.packages(pkgs = "package.name") : C에서 삭제

# 패키지 한 번에 다운로드 받기
# packages.list <- available.packages()
# download.packages(pkgs = packages.list,
#                   destdir = "directory",
#                   type = "win.binary" or "mac.binary")
packages.list <- available.packages()
download.packages(pkgs = packages.list[1],
                  destdir = "C:/FastCampus/",
                  type = "win.binary")