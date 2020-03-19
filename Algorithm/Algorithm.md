# Algorithm

## 개요

> 유한한 단계를 통해 문제를 해결하기 위한 절차나 방법

* 컴퓨터 용어로 쓰이며, 컴퓨터가 어떤 일을 수행하기 위한 단계적 방법
* 어떠한 문제를 해결하기 위한 절차

### 표현법

#### 슈도코드

> 특정 프로그래밍 언어의 문법을 따라 씌여진 것이 아니라
>
> **일반적인 언어로 코드를 흉내 내어 알고리즘을 써 놓은 코드**

* **의사 코드**로 흉내만 내는 코드
* 실제적인 프로그래밍 언어로 작성된 코드처럼 컴퓨터에서 실행할 수 없음
* 특정 언어로 프로그램을 작성하기 전에 알고리즘의 모델을 대략적으로 모델링 하는데에 쓰임

#### 순서도

> 프로그램이나 작업의 **진행 흐름**을 순서에 따라 여러가지 기호나 문자로 나타낸 도표

* 흐름도, 프로그램의 논리적 흐름, 데이터의 처리과정을 표현하는데 사용
* 프로그램을 작성하기 전에 프로그램의 전체적인 흐름과 과정 파악을 위해 필수적으로 거쳐야되는 작업

## 성능분석

### 어떤 알고리즘이 좋은 알고리즘인가?

* 정확성
  * 얼마나 정확하게 동작하는가?
  * 높을수록 성능이 좋다.
* 작업량
  * 얼마나 적은 연산으로 원하는 결과를 얻어내는가?
  * 적을수록 성능이 좋다
* 메모리사용량
  * 얼마나 적은 메모리를 사용하는가?
  * 적을수록 성능이 좋다.
* 단순성
  * 얼마나 단순한가?
  * 단순할수록 좋은 알고리즘
* 최적성
  * 더 이상 개선할 여지 없이 최적화되었는가?
  * 개선할 여지가 없을수록 최적화된 알고리즘

### 성능분석 필요

* 많은 문제에서 성능 분석의 기준으로 Algorithm의 작업량을 비교

### 시간복잡도

> Time Complexity

* 실제 걸리는 시간을 측정
  * 컴퓨터의 성능에 따라 달라질 수 있음
* **실행되는 명령문의 개수를 계산**
  * 일반적인 방법
* 빅-오(O) 표기법
  * 시간복잡도 함수 중에서 가장 큰 영향력을 주는 N에 대한 항만을 표시
  * 계수(Coefficient)는 생략하여 표시
  * O(3n + 2)의 경우 O(n)이 됨
  * 상수값인 경우 O(1)로 표기함