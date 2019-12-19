# 실습 환율 정보 가져오기
import requests
from bs4 import BeautifulSoup as bs

res = requests.get("https://finance.naver.com/marketindex/")
soup = bs(res.text, 'html.parser')

exc = soup.select_one("#exchangeList > li.on > a.head.usd > div > span.value")
print(f"현재 원/달러 환율은 {exc.text} 입니다.")

# 파일 저장
with open('test.txt', 'w', encoding='utf-8') as f:
    f.write(f"현재 원/달러 환율은 {exc.text} 입니다.")