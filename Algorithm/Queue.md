# Queue

## Queue의 특성

* 삽입, 삭제의 위치가 제한적인 자료구조
  * 뒤로 삽입, 앞으로 삭제
* 선입선출구조(FIFO, First In First Out)
  * 삽입한 순서대로 원소가 저장
  * 가장 먼저 삽입된 원소는 가장 먼저 삭제됨

## Queue의 구조 및 기본연산

### 구조

* 머리(Front)
  * 저장된 원소 중 첫 번째 원소
* 꼬리(Rear)
  * 저장된 원소 중 마지막 원소

## 기본연산

* enQueue
  * 삽입
* deQueue
  * 삭제

## Queue의 주요 연산

* `enQueue(item)`
  * Queue의 뒤쪽(Rear 다음)에 원소를 삽입하는 연산
* `deQueue()`
  * Queue의 앞쪽(Front)에서 원소를 삭제하고 반환하는 연산
* `createQueue()`
  * 공백 상태의 Queue를 생성하는 연산
* `isEmpty()`
  * Queue가 공백상태인지를 확인하는 연산
* `isFull()`
  * Queue가 포화상태인지를 확인하는 연산
* `Qpeek()`
  * Queue의 앞쪽(Front)에서 원소를 삭제 없이 반환하는 연산

## Queue의 연산 과정

### 기본 연산 과정

1. 공백 큐 생성
   * `createQueue()`
   * Front = Rear = -1
2. 원소 A 삽입
   * `enQueue(A)`
   * Front = -1, Rear = 0
3. 원소 B 삽입
   * `enQueue(B)`
   * Front = -1, Rear = 1
4. 원소 반환/삭제
   * `deQueue()`
   * A 삭제, Front = 0, Rear = 1
5. 원소 C 삽입
   * `enQueue(C)`
   * Front = 0, Rear = 2
6. 원소 반환/삭제
   * `deQueue()`
   * B 삭제, Front = 1, Rear = 2
7. 원소 반환/삭제
   * `deQueue()`
   * C 삭제, Front = 2, Rear = 2
   * Front와 Rear값이 같으면 Queue가 비었다고 판단할 수 있음

## Queue의 종류

### 선형 Queue

> 간단하고 기본적인 형태

* 특징
  * 1차원 배열을 이용한 Queue
    * Queue의 크기 = 배열의 크기
    * Front : 저장된 첫 번째 원소의 인덱스
    * Rear : 저장된 마지막 원소의 인덱스
  * 상태 표현
    * 초기 상태 : Front = Rear = -1
    * 공백 상태 : Front = Rear
    * 포화 상태 : Rear = n - 1(배열의 마지막 인덱스)
* 구현
  * 초기 공백 Queue 생성
    * 크기 n인 1차원 배열 생성
    * Front = Rear = -1로 초기화
  * 삽입 : enQueue(item)
    * 마지막 원소 뒤에 새로운 원소를 삽입하기 위해 Rear 값을 하나 증가시켜 새로운 원소를 삽입할 자리를 마련하고 그 인덱스에 해당하는 배열원소 Q[Rear]에 item을 저장
  * 삭제 : deQueue()
    * 가장 앞에 있는 원소를 삭제하기 위해 Front값을 하나 증가시켜 Queue에 남아있게 될 첫 번째 원소로 이동하고 새로운 첫 번째 원소를 리턴함으로써 삭제와 동일한 기능을 함
  * 공백상태 및 포화상태 거사 : isEmpty(), isFull()
    * 공백상태 : Front = Rear
    * 포화상태 : Rear = n-1(배열의 마지막 인덱스)
  * 검색 : Qpeek()
    * 가장 앞에 있는 원소를 검색하여 반환하는 연산
    * 현재 Front의 한자리 뒤(Front + 1)에 있는 원소, 즉 Queue의 첫 번째에 있는 원소를 의미함
* 문제점
  * 잘못된 포화 상태 인식
  * 삽입, 삭제를 계속할 경우 배열의 앞부분에 활용할 수 있는 공간이 있음에도 불구하고, Rear = n - 1인 상태 즉, 포화상태로 인식하여 더이상의 삽입을 수행하지 않음
* 문제 해결방법
  * 매 연산이 이루어질 때마다 저장된 원소들을 배열의 앞부분으로 모두 이동시킴
    * 원소의 이동에 많은 시간이 소요되어 Queue의 효율성이 급격히 떨어짐
  * 원형 Queue를 사용하는 방법
    * 1차원 배열을 사용하되, 논리적으로 배열의 처음과 끝이 연결되어 원형 형태의 Queue를 이룬다고 가정하고 사용

### 원형 Queue

> 선형에서 발전된 형태

* 특징

  * 초기 공백 상태

    * Front = Rear = 0

  * Index의 순환

    * Front와 Rear의 위치가 배열의 마지막 인덱스인 n-1을 가리킨 후,
      논리적 순환을 이루어 배열의 처음 인덱스인 0으로 이동해야 함

    * 이를 위해 나머지 연산자 mod를 사용

  * Front 변수

    * 공백 상태와 포화상태 구분을 쉽게하기 위해 Front가 있는 자리는 사용하지 않고 항상 빈자리로 둠

  * 삽입 위치 및 삭제 위치

    |            | 삽입 위치               | 삭제 위치                 |
    | ---------- | ----------------------- | ------------------------- |
    | 선형 Queue | Rear = Rear + 1         | Front = Front + 1         |
    | 원형 Queue | Rear = (Rear + 1) mod n | Front = (Front + 1) mod n |

* 연산 과정

  1. Queue 생성
     * create Queue
     * Front = Rear = 0
  2. 원소 A 삽입
     * `enQueue(A)`
     * Front = 0, Rear = 1
  3. 원소 B 삽입
     * `enQueue(B)`
     * Front = 0, Rear = 2
  4. 원소 삭제
     * `deQueue()`
     * A삭제, Front = 1, Rear = 2
  5. 원소 C 삽입
     * `enQueue(C)`
     * Front = 1, Rear = 3
  6. 원소 D 삽입
     * `enQueue(D)`
     * Front = 1, Rear = 0
     * Front는 사용하지 않기때문에 Queue는 포화상태

* 구현

  * 초기 공백 Queue 생성 : `createQueue()`
    * 크기 n인 1차원 배열 생성
    * Front = Rear = 0으로 초기화
  * 공백상태 및 포화상태 검사 : `is
    * 공백상태 : Front = Rear
    * 포화상태 : 삽입할 Rear값의 다음 위치 = 현재 Front
      * (Rear + 1) mod n = Front
  * 원소 삽입 : `enQueue(item)`
    * 마지막 원소 뒤에 새로운 원소를 삽입하기 위해 Rear값을 조정하여 새로운 원소를 삽입할 자리를 마련하고 인덱스에 해당하는 배열 원소 cQ[Rear]에 item을 저장
    * Rear = (Rear + 1) mod n;
  * 원소 삭제 : `deQueue()`
    * 가장 앞에 있는 원소를 삭제하기 위해 Front값을 조정하여 삭제할 자리를 준비하고 새로운 Front원소를 리턴함으로써 삭제와 동일한 기능을 함

### 연결 Queue

> 리스트 형식 사용

* 특징
  * 단순 연결 리스트(Linked List)를 이용한 Queue
    * Queue의 원소 : 단순 연결 리스트의 노드
    * Queue의 원소 순서 : 노드의 연결 순서, 링크로 연결되어 있음
    * Front : 첫 번째 노드를 가리키는 링크
    * Rear : 마지막 노드를 가리키는 링크
  * 상태 표현
    * 초기 상태 : Front = Rear = NULL
    * 공백 상태 : Front = Rear = NULL
    * 계속해서 연결할 수 있기 때문에 포화상태가 없음
* 연산 과정
  1. 공백 큐 생성
     * `createLinkedQueue()`
     * Front = Rear = NULL
  2. 원소 A 삽입
     * `enQueue(A)`
     * Front = A의 주소
     * Rear = A가 가리키는 노드
  3. 원소 B 삽입
     * `enQueue(B)`
     * Front = A의 주소
     * Rear = B가 가리키는 노드
     * A가 가리키는 노드가 B의 주소가 됨
  4. 원소 삭제
     * `deQueue()`
     * Front = B의 주소
     * Rear = B가 가리키는 노드
  5. 원소 C 삽입
     * `enQueue(C)`
     * Front = B의 주소
     * Rear = C가 가리키는 노드
  6. 원소 삭제
     * `deQueue()`
     * Front = C의 주소
     * Rear = C가 가리키는 주소
  7. 원소 삭제
     * `deQueue()`
     * Front = Rear = C가 가리키는 주소
* 구현
  * 초기 공백 Queue 생성: `createLinkedQueue()`
    * 리스트 노드 없이 포인터 변수만 생성
    * Front = Rear = NULL로 초기화
  * 공백상태 검사 : `isEmpty()`
    * 공백상태 : Front = Rear = NULL
  * 삽입 : `enQueue(item)`
    * 새로운 노드 생성 후 데이터 필드에 item 저장
    * 연결 Queue가 공백인 경우, 아닌 경우에 따라 Front, Rear변수 지정
      * 공백인 경우, Front와 Rear에 삽입할 새 노드를 지정
      * 공백이 아닌 경우, 기존 Rear의 Link에 새로 삽입하는 노드 위치를 지정, Rear가 새 노드를 가리키게 함
  * 삭제 : `deQueue()`
    * old가 지울 노드를 가리키게 하고, Front를 기존 가리키던 값으로 재설정
    * 삭제 후 공백 Queue가 되는 경우, Rear도 NULL로 설정
    * old가 가리키는 노드를 삭제하고 메모리 반환
      * 반환하지 않고 종료하면 노드에 메모리가 남아 메모리 누수가 발생

## Queue의 활용

### 우선순위 Queue

* 특징
  * 우선순위를 가진 항목들을 저장하는 큐
  * FIFO 순서가 아니라 우선순위가 높은 순서대로 먼저 나가게 됨
  * 적용 분야
    * 시뮬레이션 시스템
    * 네트워크 트래픽 제어
    * 운영체제의 태스크 스케줄링
* 구현
  * 배열을 이용한 우선순위 Queue
    * 배열을 이용하여 자료 저장
    * 원소를 삽입하는 과정에서 우선순위를 비교하여 적절한 위치에 삽입하는 구조
    * 가장 앞에 최고 우선순위의 원소가 위치하게 됨
    * 문제점
      * 배열을 사용하므로, 삽입이나 삭제 연산이 일어날 때 원소의 재배치가 발생
      * 소요되는 시간, 메모리 낭비가 큼
    * 해결방법
      * 연결 리스트를 이용한 우선순위 Queue
      * Heap 자료구조
  * 리스트를 이용한 우선순위 Queue
* 기본 연산
  * 삽입 : enQueue
  * 삭제 : deQueue
  * 항목 삽입시 우선순위에 맞는 위치를 찾아 삽입
  * 삭제시 앞에서 우선순위가 가장 높거나 낮은 항목을 삭제

### 버퍼

* 의미
  * 데이터를 한 곳에서 다른 한 곳으로 전송하는 동안 일시적으로 그 데이터를 보관하는 메모리의 영역
  * 버퍼링 : 버퍼를 활용하는 방식 또는 버퍼를 채우는 동작을 의미
* 자료 구조
  * 일반적으로 입출력 및 네트워크와 관련된 기능에서 이용
  * 순서대로 입력/출력/전달되어야 하므로 FIFO 방식의 자료구조인 Queue가 활용됨

## BFS

> 너비우선탐색

### DFS vs BFS

#### DFS

* Depth First Search, 깊이 우선 탐색
* Stack 활용

#### BFS

* Breadth First Search, 너비 우선 탐색
* Queue 활용
* 시작점의 인접한 정점들을 모두 차례로 방문한 후 방문했던 정점을 시작점으로 하여 다시 인접한 정점들을 차례로 방문하는 방식
* 인접한 정점들을 탐색한 후, 차례로 너비 우선 탐색을 진행해야 하므로, 선입선출 형태의 자료구조인 Queue 활용

### 알고리즘

1. 탐색 시작점 V를 결정하여 Queue에 삽입
2. 점 V를 방문한 것으로 표시
3. 큐가 비어있지 않은 경우 반복문
4. Queue의 첫 번째 원소 T를 반환
5. T를 방문한 것으로 표시
6. T와 연결된 모든 이웃 정점 중에 방문하지 않은 정점을 Queue에 삽입
7. 3 ~ 6의 과정을 반복하여 탐색