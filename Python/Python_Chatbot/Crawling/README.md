# Crawling

## 1. Lotto

```python
import random

numbers = random.sample(range(1, 46), 6)

print(numbers)
```

* 외부 모듈을 가져오는 `import`를 사용한다.
* 값을 랜덤하게 뽑을 수 있는 `random.sample`을 사용하기 위해 `random`을 가져온다.
* `random.sampe(range(1, 46), 6)`은 1~45까지의 숫자 중 6개를 뽑는다는 것이다.
* `sample`에 대한 설명을 읽어보면 `Choos unique element`라고 나와있다. 이는 중복된 값이 없다는 뜻이다.

### Lotto 추첨

* [Lotto Site](https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=836)를 이용하여 추첨번호 6개를 가져온다.

	```python
	import random
import json
	
	import requests
	
	url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=836"
	
response = requests.get(url)
	print(response)
	# <Response [200]>
	print(type(response.text))
# <class 'str'>
	
	lotto = json.loads(response.text)
	print(type(lotto))
	# <class 'dict'>
	
	winner = []
	
	for i in range(1, 7):
	    winner.append(lotto.get(f"drwtNo{i}"))
	```
	
	* `requests`패키지를 사용하여 `url`의 내용을 가져와서 `response`에 저장한다.
	* `json`패키지를 사용하여 `url`의 내용을 변환하여 `lotto`에 저장한다.
	* `winner`에 `lotto`에 저장된 내용 중 `drwtNo`에 해당하는 내용을 가져온다.
	
* `random.sample`을 이용해서 뽑은 무작위 숫자 6개와 당첨번호를 비교한다.

  ```python
  # Python 함수
  def pickLotto():
      picked = sorted(random.sample(range(1, 46), 6))
      matched = len(set(winner) & set(picked))
  
      if matched == 6:
          print("1등")
      elif matched == 5:
          print("3등")
      elif matched == 4:
          print("4등")
      elif matched == 3:
          print("5등")
      else:
          print("꽝")
  
  pickLotto()
  ```

  * `def`를 사용해서 `python`함수를 선언해서 기능을 만든다.
  * `pickLotto()`를 사용해서 선언한 함수를 호출한다.


* [Codes](./lotto.py)

## 2. bs4, webbrowser

> bs4는 requests에서 가져오는 html소스들을 보기 좋게 변경해주는 패키지다.
>
> webbrowser는 웹 사이트에 관련된 패키지다.

* 네이버의 `url`을 이용하여 알아본다.

  ```python
  import requests
  from bs4 import BeautifulSoup as bs
  
  import webbrowser
  
  url = "https://www.naver.com/"
  response = requests.get(url).text
  ```

* `bs4`은 다음과 같이 사용한다.

  ```python
  doc = bs(response, 'html.parser')
  ```

  * 여기서 `'html.parser'`는 받아올 형식을 의미한다.

* `HTML`태그를 이용하여 원하는 부분을 추출해야 한다.

  ```python
  result = doc.select('.ah_k')
  ```

  * 여기서 `.`은 `class`를 `#`은 `id`를 의미한다.
  * `'.ah_k'`는 실시간검색어 부분을 가져온다.
  * [Codes](./kospi.py)

* `result`를 이용하여 실시간검색어로 검색한 새로운 인터넷 창을 띄워본다.

  ```python
  search_url = "https://search.naver.com/search.naver?query="
  for i in range(5):
      webbrowser.open(search_url + result[i].text)
  ```

* [Codes 1](./naver.py)
* [Codes 2](./exchange.py)