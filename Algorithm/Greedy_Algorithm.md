# Greedy Algorithm

> 탐욕알고리즘
>
> 최적해를 구하는 데 사용되는 근시안적인 방법

* 여러 경우 중 하나를 결정해야 할 때마다 **그 순간에 최적이라고 생각되는 것을 선택해 나가는 방식**으로 진행하여 최종적인 해답에 도달
* 각 선택의 시점에서 이루어지는 결정은 지역적으로는 최적이지만, 그것들을 계속 수집하여 최종적인 해답을 만들었다고 하여, **최적이라는 보장은 없음**
* 일반적으로, 머리속에 떠오르는 생각을 검증 없이 바로 구현하면 **Greedy 접근**이 됨

## 수행과정

* 해 선택
  * 현재 상태에서 부분 문제의 최적 해를 구한뒤, 이를 **부분해 집합에 추가**함
* 실행 가능성 검사
  * 새로운 부분 해 집합이 실행 가능한지를 확인
  * **문제의 제약조건을 위반하지 않는지를 검사**
* 해 검사
  * 새로운 부분 해 집합이 **문제의 해가 되는지를 확인**
  * 아직 전체 문제의 해가 완성되지 않았다면 **1의 해 선택부터 다시 시작**

## 예시

> 거스름돈 줄이기

* 어떻게 하면 손님에게 거스름돈으로 주는 지폐와 동전의 개수를 최소한으로 줄일 수 있을까?

1. 해 선택
   * 가장 좋은 해를 선택
   * 가장 단위가 큰 동전을 하나 골라 거스름돈에 추가함
2. 실행 가능성 검사
   * 거스름돈이 손님에게 내드려야 할 액수를 초과하는지를 확인
   * 초과한다면 마지막에 추가한 동전을 거스름돈에서 빼고, 1로 돌아가서 현재보다 한단계 적은 단위의 동전을 추가함
3. 해 검사
   * 거스름돈이 손님에게 내드려야 하는 액수와 일치하는지 확인
   * 액수에 모자라면 다시 1로 돌아가서 거스름돈에 추가할 동전을 고름

## Baby-gin 다시풀기

> [완전탐색으로 알아본 Baby-gin](Exhaustive_Search.md)

1. 6개의 숫자는 6자리의 정수 값으로 입력됨
2. COUNTS Array의 각 원소를 체크하여 run과 triplete 및 Baby-gin 여부를 판단함
   * Greedy Algorithm을 적용함
   * COUNTS Array에서 run과 triplete중 가능한 것을 조사함
   * 조사에 사용한 데이터는 삭제함
   * 남은 데이터를 다시 run과 triplete중 가능한지를 조사함

* 주의할 점
  * 입력받은 숫자를 정렬한 후, 앞 뒤 3자리씩 끊어서 run 및 triplete을 확인하는 방법을 고려할 수 있음
    * 644544는 4 4 4 4 5 6으로 쉽게 Baby-gin확인이 가능
    * 123123은 1 1 2 2 3 3으로 오히려 Baby-gin여부 확인을 실패 
  * Greedy Algorithm적인 접근은 해답을 찾아내지 못하는 경우가 있다!