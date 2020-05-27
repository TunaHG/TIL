# Tree

## Tree

### 특성

* 개념
  * 비선형 구조로 원소들 간에 1:n관계를 가지는 자료구조
    * 원소들 간에 계층관계를 가지는 계층형 자료구조
    * 상위 원소에서 하위 원소로 내려가면서 확장되는 Tree(나무)모양의 구조
* 한 개 이상의 노드로 이루어진 유한 집합
  * 루트(Root) : 노드 중 최상위 노드
  * 나머지 노드들 : n(>= 0)개의 분리집합 T1, ... TN으로 분리될 수있음
* 이들 T1, ..., TN은 각각 하나의 Tree가 되며(재귀적 정의) 루트의 부트리(SubTree)라고 함

### 구성요소

* 노드
  * Tree의 원소
* 간선
  * 노드를 연결하는 선
  * 간선AB : A와 B를 연결하는 선
* 루트 노드(Root node)
  * Tree의 시작 노드
* 형제 노드(Sibling node)
  * 같은 부모 노드의 자식 노드들
* 조상 노드(Ancestor node)
  * 간선을 따라 루트 노드까지 이르는 경로에 있는 모든 노드들
* 부트리(SubTree)
  * 부모 노드와 연결된 간선을 끊었을 때 생성되는 Tree
* 자손 노드(Descendent node)
  * 부트리에 있는 하위 레벨의 노드들
* 차수(degree)
  * 노드에 연결된 자식 노드의 수
* Tree의 차수
  * Tree의 차수는 노드의 차수 중에서 가장 큰 값
* 단말 노드(리프 노드)
  * 차수가 0인 노드
  * 자식 노드가 없는 노드
* 높이
  * 루트에서 노드에 이르는 간선의 수
  * 노드의 레벨
* Tree의 높이
  * Tree에 있는 노드의 높이 중에서 가장 큰 값
  * 최대 레벨

## Binary Tree

### 특징

* 모든 노드들이 2개의 부트리를 갖는 특별한 형태의 Tree
* 노드가 자식 노드를 최대한 2개까지만 가질 수 있는 Tree
  * 왼쪽 자식 노드
  * 오른쪽 자식 노드
* 레벨 i에서 노드의 최대개수는 2의 i제곱 개
* 높이가 h인 Binary Tree가 가질 수 있는 노드의 최소 개수는 h+1개
  최대 개수는 2의 h+1제곱 + 1개

### 종류

* 포화 이진 트리
  * Full Binary Tree
  * 모든 레벨에 노드가 포화상태(좌, 우 자식노드가 전부 존재하는)로 차 있는 Binary Tree
  * 최대의 노드 개수인 2의 h+1제곱-1개의 노드를 가진 Binary Tree
  * 루트를 1번으로 하여 2의 h+1제곱 - 1까지 정해진 위치에 대한 노드 번호를 가짐
* 완전 이진 트리
  * Complete Binary Tree
  * 높이가 h이고 노드 수가 n개일 때 노드 번호 1번부터 n번까지 빈 자리가 없는 Binary Tree
* 편향 이진 트리
  * Skewed Binary Tree
  * 높이 h에 대한 최소 개수의 노드를 가지면서 한쪽 방향의 자식 노드만을 가진 Binary Tree

### 순회

* Tree의 각 노드를 중복되지 않게 전부 방문하는 것
* Tree는 비선형 구조이기 때문에 선형구조에서와 같이 선후 연결관계를 알 수 있음
* 전위 순회 (Preorder Traversal)
  * VLR (V : 루트, L : 왼쪽부트리, R : 오른쪽부트리)
  * 자손노드보다 루트노드를 먼저 방문
  * 수행 방법
    1. 현재 노드 n을 방문하여 처리 : V
    2. 현재 노드 n의 왼쪽 부트리로 이동 : L
    3. 현재 노드 n의 오른쪽 부트리로 이동 : R
* 중위 순회 (Inorder Traversal)
  * LVR (V : 루트, L : 왼쪽부트리, R : 오른쪽부트리)
  * 왼쪽 자손, 루트, 오른쪽 자손 순으로 방문
  * 수행 방법
    1. 현재 노드 n의 왼쪽 부트리로 이동 : L
    2. 현재 노드 n을 방문하여 처리 : V
    3. 현재 노드 n의 오른쪽 부트리로 이동 : R
* 후위 순회 (Postorder Traversal)
  * LRV (V : 루트, L : 왼쪽부트리, R : 오른쪽부트리)
  * 루트노드보다 자손을 먼저 방문
  * 수행 방법
    1. 현재 노드 n의 왼쪽 부트리로 이동 : L
    2. 현재 노드 n의 오른쪽 부트리로 이동 : R
    3. 현재 노드 n을 방문하여 처리 : V

### Array를 이용한 이해와 표현

* Binary Tree에 각 노드 번호를 다음과 같이 부여
  * 루트 번호를 1로
  * 레벨 n에 있는 노드에 대하여 왼쪽부터 오른쪽으로 2의 n제곱부터 2의 n+1제곱 - 1까지 번호를 차례대로 부여
* 노드 번호의 성질
  * 노드 번호가 i인 노드의 부모 노드 번호는 : i / 2
  * 노드 번호가 i인 노드의 왼쪽 자식 노드 번호는 : i * 2
  * 노드 번호가 i인 노드의 오른쪽 자식 노드 번호는 : i * 2 + 1
* 노드 번호를 Array의 인덱스로 사용
* 높이가 h인 Binary Tree를 위한 Array의 크기는 레벨 i의 최대 노드수
* 단점
  * 메모리 공간 낭비 발생
    * Skewed Binary Tree의 경우에 사용하지 않는 Array 원소에 대한 메모리 공간 낭비 발생
  * 노드가 자식 노드를 최대한 2개까지만 가질 수 있는 Tree
    * Tree의 중간에 새로운 노드를 삽입하거나 기존의 노드를 삭제할 경우 Array의 크기변경이 어려워 비효율적

### 연결 List를 이용한 이해와 표현

* 연결 List를 이용하여 Tree를 표현
  * Array를 이용한 Binary Tree의 단점 보완
* 연결 자료구조를 이용한 Binary Tree의 이해와 표현
  * Binary Tree의 모든 노드는 최대 2개의 자식 노드를 가지므로 일정한 구조의 단순 연결 List 노드를 사용하여 구현

## Expression Tree

### 특징

* 수식을 표현하는 Binary Tree
* Expression Binary Tree(수식 이진 트리)라고 부르기도 함
* 연산자는 루트 노드이거나 가지 노드
* 피연산자는 모두 리프 노드(단말 노드)

### 순회

* 중위 순회
  * `A / B * C * D + E`
* 후위 순회
  * `A B / C * D * E +`
* 전위 순회
  * `+ * * / A B C D E`

## Binary Search Tree

### 특징

* 탐색작업을 효율적으로 하기 위한 자료구조
* 모든 원소는 서로 다른 유일한 키를 가짐
* key(왼쪽 부트리) < key(루트 노드) key(오른쪽 부트리)
* 왼쪽 부트리와 오른쪽 부트리도 Binary Search Tree임
* 중위 순회하면 오름차순으로 정렬된 값을 얻을 수 있음

### 연산

* 루트에서 시작
* 탐색할 key값 x를 루트 노드의 키값과 비교
  * 키값과 루트노드의 키값이 같을경우 원하는 원소를 찾았으므로 탐색 연산 성공
  * 키값이 루트노드의 키값보다 작으면 루트 노드의 왼쪽 서브 Tree에 대해서 탐색연산 수행
  * 키값이 루트노드의 키값보다 크면 루트 노드의 오른쪽 서브 Tree에 대해서 탐색연산 수행
* 부트리에 대해서 순환적으로 탐색 연산을 반복
* 삽입 연산
  * 먼저 탐색 연산을 수행
    * 삽입할 원소와 같은 원소가 Tree에 있으면 삽입할 수 없으므로
      같은 원소가 Tree에 있는지 탐색하여 확인
    * 탐색에서 탐색 실패가 결정되는 위치가 삽입 위치가 됨
  * 탐색 실패한 위치에 원소를 삽입

### 성능

* 탐색, 삽입, 삭제 시간은 Tree의 높이(h)에 좌우됨
  * 시간복잡도 : O(h)
* 평균의 경우
  * Binary Tree가 균형적으로 생성되어 있는 경우
  * 시간복잡도 : O(log n)
* 최악의 경우
  * 한쪽으로 치우친 경사 Binary Tree의 경우
  * 시간복잡도 : O(n)
  * 순차 탐색과 시간복잡도가 같음

## Heap

### 특징

* Complete Binary Tree에 있는 노드 중에서 키값이 가장 큰 노드나 키값이 가장 작은 노드를 찾기 위해서 만든 자료구조
  * 최대 힙
    * 키값이 가장 큰 노드를 찾기 위한 Complete Binary Tree
    * 부모 노드의 키값 > 자식 노드의 키값
    * 루트 노드 : 키값이 가장 큰 노드
  * 최소 힙
    * 키값이 가장 작은 노드를 찾기 위한 Complete Binary Tree
    * 부모 노드의 키값 < 자식 노드의 키값
    * 루트 노드 : 키값이 가장 작은 노드

### 연산

* 삽입 연산
* 삭제 연산