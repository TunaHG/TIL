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
blank <- read.table(file = "C:/FastCampus/blank.txt", # C:/Fa ���� Tab ���� �� ���ǥ�õ�
                    header = TRUE,
                    sep = " ",
                    stringsAsFactors = TRUE)
blank
str(blank)

blank2 <- read.table(file = "C:/FastCampus/blank.txt", # C:/Fa ���� Tab ���� �� ���ǥ�õ�
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

# ���� : ���� ó�� �Ǵ� �м� - �ؽ�Ʈ ���̴�(Text Mining)
# (1) tab : "\t"
# (2) line feed : "\n" <- separator�� ������� ����
# (3) carriage return : "\r"


# 2. csv ----
# comma separated value�� ����
# Excel�� Ư���� ����

# data.name <- read.csv(file = "directory/filename.csv",
#                       header = TRUE,
#                       stringsAsFactors = TRUE)
hope <- read.csv(file = "C:/FastCampus/hope.csv",
                 header = TRUE)
hope


# 3. Excel : xls, xlsx ----
# R�� �⺻ ������δ� �� �о��
# R�� ���ο� ������� �о��

# �⺻ ���   : ��Ű��(pacakage)
# ���ο� ��� : ��Ű��(pacakage)

# ��Ű��(pacakage)��?
# (1) �Լ�   : Function *****
# (2) ������ : Data
# (3) ���� : Help
# (4) ����   : Example or Source

# �⺻ ����� ��Ű�� : 9��
# R committee���� ������
# R ������ ���׷��̵�Ǵ� ���� 9���� ��
search() # ��ġ�� ��Ű���� ��� ����

# ���ο� ��Ű�� : �� 13,500�� ����
# ���ε��� ������
# ��Ű���� 2MB�� ���� �ʵ��� ������

# ������ ���õ� ��Ű�� : readxl

# 18/12/21 ----

# ��Ű�� ��ġ�ϱ�
# ���� : ���ͳ��� ����Ǿ� �־�� ��
# ��Ű���� ������Ʈ ���� ���� �� ���� ��ǻ�Ϳ����� �� ���� ��ġ��
# install.packages("package.name")
install.packages("readxl")

# ��Ű�� �ε��ϱ�(Loading)
# R�� ��Ű�� �����ϱ�
# ��Ű���� �޸𸮿� �ø��� ���
# library(package.name) or require(package.name)
# library�� �ش� ��Ű���� ����ϰ� ������ �׶����� �ε��������
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
# tibble �̶�� ������ �������� ��µǴµ�, �̴� Data.Frame�� ����.
# ����Type <- dbl = double, chr = character


# �۾�����(Working Directory)
# (1) ���� ������ �۾����� �˾Ƴ���
# getwd()
getwd()

# (2) �۾����� ���� �����ϱ�
# setwd("directory")
setwd("C:/FastCampus/")

# ����� ���� �Ǿ����� Ȯ��
getwd()

reading3 <- readxl::read_excel(path = "reading.xlsx",
                               sheet = 1,
                               col_names = TRUE)
reading3


# install.package()�� ���ͳݿ� ����Ǿ� �־�߸� ������
# ���ͳ��� �ȵǴ� ��Ȳ���� ��Ű�� ��ġ�ϱ�
# 1�ܰ� : ���ͳ��� �Ǵ� ��ǻ�ͷ� ����.
# 2�ܰ� : www.r-project.org -> CRAN -> Korea
#         -> http://ftp.harukasan.org/CRAN/
#         -> Packages
#         -> Table of available packages
#         -> �ٿ�ε� �ް� ���� ��Ű���� ã��
#         -> OS�� �´� �������� �ٿ�ε�
# 3�ܰ� : �����ϵ峪 USB�� �ش� ��Ű�� �ڷḦ �����ϱ�
# 4�ܰ� : �����ϵ峪 USB�� ���ؼ� ���Ȱ��縦 ����
# 5�ܰ� : �ش� ��ǻ���� Ư�� ������ �����Ͽ� �ٿ��ֱ�
# 6�ܰ� : ��Ű�� ��ġ�ϱ�
# install.packages("directory/xxxx.zip", repos = NULL)
#                                        repos <- Local Computer

# ���� : install.packages("package.name")
# repos : repos = "www.rstudio.com" : default(RStudio)
# repos : ��Ű���� �ٿ�ε� �޴� ������ �ּҸ� �ǹ�

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

# ��Ű���� ���õ� �Լ���
# (1) ��Ű�� ��ġ�ϱ�                 : install.packages("package.name")
# (2) ��Ű�� �ε��ϱ�                 : library(package.name) or require(package.name)
# (3) ��ġ�� ��Ű�� ��Ϻ���          : search()
# search()�� ��ȣ�� �켱����, �浹�߻��� ������ ���� ��Ű���� �Լ� ����
# (4) ��ġ�� ��Ű�� ��Ϻ���(���)    : searchpaths()
# (5) �̿밡���� ��Ű�� ��Ϻ���      : available.packages()
# (6) �ش� ��Ű���� ��ġ�Ǿ����� Ȯ�� : installed.packages("package.name")
# (7) ��Ű�� ������Ʈ                 : update.packages("package.name")
# (8) ��Ű�� �ٿ�ε�                 : download.packages("package.name") : zip���Ϸ� �ٿ�ε�
# (9) �޸𸮿��� ��Ű�� ������        : detach(package:package.name) : library�� �ݴ�
# (10) ��Ű�� ����                  : help(package.name) or ?package.name
# (11) ��Ű�� �����ϱ�                : remove.packages(pkgs = "package.name") : C���� ����

# ��Ű�� �� ���� �ٿ�ε� �ޱ�
# packages.list <- available.packages()
# download.packages(pkgs = packages.list,
#                   destdir = "directory",
#                   type = "win.binary" or "mac.binary")
packages.list <- available.packages()
download.packages(pkgs = packages.list[1],
                  destdir = "C:/FastCampus/",
                  type = "win.binary")