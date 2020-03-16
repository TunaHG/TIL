library(tidyverse)
library(httr)
library(rvest)
library(writexl)
library(ggplot2)
library(wordcloud)

## 1.

# 1. 자동차 배기량에 따라 고속도로 연비가 다른지 알아보려 한다. 
# displ(배기량)이 4 이하인 자동차와 5 이상인 자동차 중 
# 어떤 자동차의 hwy(고속도로 연비)가 평균적으로 더 높은지 확인하세요.
df1 <- mpg %>% 
  mutate(grp = ifelse(displ <= 4, "LOW", "HIGH")) %>% 
  group_by(grp) %>% 
  summarise(avg = mean(hwy))
df1

# 2. 자동차 제조 회사에 따라 도시 연비가 다른지 알아보려고 한다. 
# "audi"와 "toyota" 중 어느 manufacturer(제조회사)의 cty(도시 연비)가 
# 평균적으로 더 높은지 확인하세요.
df2 <- mpg %>% 
  filter(manufacturer %in% c("audi", "toyota")) %>% 
  group_by(manufacturer) %>% 
  summarise(mean = mean(cty))
df2

# 3. "chevrolet", "ford", "honda" 자동차의 고속도로 연비 평균을 알아보려고 한다. 
# 이 회사들의 데이터를 추출한 후 hwy(고속도로 연비) 전체 평균을 구하세요.
filter(mpg, manufacturer %in% c("chevrolet","ford","honda"))%>%group_by(manufacturer)%>%summarise(hwy_AVG=mean(hwy))
df3 <- mpg %>% 
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>% 
  summarise(avg = mean(hwy))
df3

# 4. "audi"에서 생산한 자동차 중에 어떤 자동차 모델의 hwy(고속도로 연비)가 
# 높은지 알아보려고 한다. "audi"에서 생산한 자동차 중 hwy가 1~5위에 해당하는 
# 자동차의 데이터를 출력하세요.
df4 <- mpg %>% 
  filter(manufacturer == "audi") %>% 
  arrange(desc(hwy)) %>% 
  head(n = 5)
df4

# 5. mpg 데이터는 연비를 나타내는 변수가 2개입니다. 
# 두 변수를 각각 활용하는 대신 하나의 통합 연비 변수를 만들어 사용하려 합니다. 
# 평균 연비 변수는 두 연비(고속도로와 도시)의 평균을 이용합니다. 
# 회사별로 "suv" 자동차의 평균 연비를 구한후 내림차순으로 정렬한 후 1~5위까지 데이터를 출력하세요.
df5 <- mpg %>% 
  filter(class == "suv") %>% 
  group_by(manufacturer) %>% 
  summarise(avgy = (mean(cty) + mean(hwy)) / 2) %>% 
  arrange(desc(avgy))
df5

# 6. mpg 데이터의 class는 "suv", "compact" 등 자동차의 특징에 따라 
# 일곱 종류로 분류한 변수입니다. 어떤 차종의 도시 연비가 높은지 비교하려 합니다. 
# class별 cty 평균을 구하고 cty 평균이 높은 순으로 정렬해 출력하세요.
df6 <- mpg %>% 
  group_by(class) %>% 
  summarise(ctyMean = mean(cty)) %>% 
  arrange(desc(ctyMean))
df6

# 7. 어떤 회사 자동차의 hwy(고속도로 연비)가 가장 높은지 알아보려 합니다. 
# hwy(고속도로 연비) 평균이 가장 높은 회사 세 곳을 출력하세요.
df7 <- mpg %>% 
  group_by(manufacturer) %>% 
  summarise(hwyAvg = mean(hwy)) %>% 
  arrange(desc(hwyAvg)) %>% 
  head(3)
df7

# 8. 어떤 회사에서 "compact" 차종을 가장 많이 생산하는지 알아보려고 합니다. 
# 각 회사별 "compact" 차종 수를 내림차순으로 정렬해 출력하세요.
df8 <- mpg %>% 
  group_by(manufacturer) %>% 
  filter(class == "compact") %>% 
  count(class)
df8


## 2.

# Top100 Site
url <- "https://www.rottentomatoes.com/top/bestofrt/?year=2019"
res <- read_html(url, encoding = "UTF-8")
print(res)

# get Top100 Movies Title
# #top_movies_main > div > table > tbody > tr:nth-child(1) > td:nth-child(3) > a
title <- res %>% 
  html_nodes(css = "#top_movies_main > div > table >  tr > td > a") %>% 
  html_text() %>% 
  str_remove(pattern = "[\\s]*")
title

# get Top00 Movie's Site Link
link <- res %>% 
  html_nodes(css = "#top_movies_main > div > table >  tr > td > a") %>% 
  html_attr("href")
link

# Basic URL using link
basicUrl <- "https://www.rottentomatoes.com"

# Init rating, genre
userRating <- c()
genre <- c()

# Loop for Top100 Movies
for(i in 1:length(title)){
  # Combine Url
  titleUrl <- str_c(basicUrl, link[i])
  
  # get Url Response
  titleRes <- titleUrl %>% 
    read_html(encoding = "UTF-8")
  
  # get Rating using Selector
  # #topSection > div.col-sm-17.col-xs-24.score-panel-wrap > div.mop-ratings-wrap.score_panel.js-mop-ratings-wrap > section > section > div.mop-ratings-wrap__half.audience-score > h2 > a > span.mop-ratings-wrap__percentage
  titleRating <- titleRes %>% 
    html_nodes(css = "div.audience-score > h2 > a > span.mop-ratings-wrap__percentage") %>% 
    html_text() %>%
    str_trim()
  if(length(titleRating) == 0){
    titleRating <- NA
  }
  
  # get genre using Selector
  # #mainColumn > section.panel.panel-rt.panel-box.movie_info.media > div > div > ul > li:nth-child(2) > div.meta-value > a:nth-child(1)
  titleGenre <- titleRes %>% 
    html_nodes(css = "div.meta-value") %>% 
    html_text() %>% 
    `[[`(2) %>% 
    str_trim() %>% 
    str_remove_all(pattern = "(?<=, )\\s*")
  
  # Combine rating, genre
  userRating <- c(userRating, titleRating)
  genre <- c(genre, titleGenre)
  cat(i, " 번째 작업 진행중\n")
}

# Create Dataframe with title, rating, genre
result <- data.frame(title, userRating, genre, stringsAsFactors = FALSE)

# Export result Dataframe to Excel
write_xlsx(result, path = "C:/TIL/R/R_Workspace/rottentomatoesResult.xlsx")


## 3.

useNIADic()

# Movie Comment Site
stdurl <- "https://movie.naver.com/movie/point/af/list.nhn?st=mcode&sword=136900&page="
review <- c()
for(i in 1:10){
  url <- str_c(stdurl, i)
  res <- read_html(url, encoding = "CP949")
  
  # #old_content > table > tbody > tr:nth-child(3) > td.title
  tmp <- res %>% 
    html_nodes(css = 'td.title') %>% 
    html_text() %>% 
    str_remove(pattern = "[\\s\\S]*10점 중[\\d]*") %>% 
    str_remove(pattern = "신고") %>% 
    str_trim()
  review <- c(review, tmp)
  cat(i, "번쨰 페이지 작업")
}

words <-extractNoun(review)
result <- unlist(words)

wordcount <- table(result)

wordcount_df <-as.data.frame(wordcount, stringsAsFactors = F)

word_df <- wordcount_df %>%
  filter(nchar(result) >= 2) %>%
  arrange(desc(Freq)) %>%
  head(20)

pal<-brewer.pal(8,"Dark2")

set.seed(1)
wordcloud(words=word_df$result, freq = word_df$Freq, min.freq = 2, max.words = 200, random.order = F, rot.per = 0.1, colors = pal)
