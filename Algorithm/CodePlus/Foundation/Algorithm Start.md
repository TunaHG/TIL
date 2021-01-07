# Algorithm Start

## Time Complexity

* 시간 복잡도를 이용하면 작성한 코드가 시간이 대략 얼마나 걸릴지 예상할 수 있다.
* 표기법으로 대문자 O를 사용한다.
  * Big-O Notation
  * 다양한 시간 복잡도가 많지만 보통 Big-O만 사용한다.
  * O(N)

* 입력의 크기 N에 대해서 시간이 얼마나 걸릴지 나타내는 방법

* 즉, 최악의 경우에 시간이 얼마나 걸릴지 알 수 있다.

  * 99%의 확률로 0.01초, 1%의 확률로 100초가 걸릴 때 시간복잡도는 100초라고 한다.

* 예시

  * N명의 사람이 식당에 방문, 식당에 있는 메뉴는 M개이고 메뉴판은 1개
  * 사람 1명이 메뉴판을 읽는데 걸리는 시간은 O(M)
  * 주문한 모든 메뉴는 동시에 나왔고, 각 사람 i가 식사를 하는데 걸리는 시간은 Ai
  * 각 사람이 계산을 하는데 걸리는 시간은 O(P)
  * 각 사람이 메뉴판에 있는 모든 메뉴를 읽는 시간 복잡도는 O(NM)
  * 모든 사람이 식사를 마치는데 걸리는 시간은 O(max(Ai))
  * 식사를 모두 마친 다음 한 줄로 서서 각자 계산을 하는 시간 복잡도는 O(NP)

* 시간복잡도는 소스를 보고 계산할 수도 있고, 소스를 작성하기 전에 먼저 계산해 볼 수 있다.

* 문제를 풀기 전에 먼저 생각한 방법의 시간 복잡도를 계산해보고 이게 시간 안에 수행될 수 있을 것 같은 경우에만 구현하는 것이 좋다.

* 예시

  ```JAVA
  int sum = 0;
  for (int i = 1; i <= N; i++) { // O(N)
      for (int j = 1; j <= N; j++){ // O(N)
          if (i == j) {
              sum += j;
          }
      }
  }
  ```

  * O(N제곱)

  ```java
  int sum = 0;
  sum = N * (N + 1) / 2;
  ```

  * O(1)

* 시간 복잡도 안에 가장 큰 입력 범위를 넣었을 때, 1억이 1초정도이다.

  * N이 10만이라고 가정하면,
    * O(1)은 1
    * O(N)은 10만, 1000분의 1초
    * O(N제곱)은 100억, 100초

* 이 값은 대략적인 값으로, 실제로 구현해보면 1억을 조금 넘어도 1초 이내에 수행이 가능하다.

* 1초가 걸리는 입력의 크기

  * O(1)
  * O(logN)
  * O(N) : 1억
  * O(NlogN) : 5백만
  * O(N^2) : 1만
  * O(N^3) : 500
  * O(2^N) : 20
  * O(N!) : 10

* Big O Notation에서 상수는 버린다.

  * O(3N^2) = O(N^2)
  * O(1/2 N^2) = O(N^2)

* 두 가지 항이 있을 때, 변수가 같으면 큰 것만 빼고 다 버린다.

  * O(N^2 + N) = O(N^2)
  * O(N^2 + NlogN) = O(N^2)

* 두 가지 항이 있는데 변수가 다르면 놔둔다.

  * O(N^2 + M)

## Memory

* 보통 가장 많은 공간을 사용하는 것이 보통 배열이다.
* 배열이 사용한 공간 : 배열의 크기 X 자료형의 크기 B
  * `int a[10000];` => 10000 * 4B = 40000B = 39.06KB
  * `int a[10000][10000];` => 10000 * 10000 * 4B = 381.469MB
* 보통 배열의 크기가 크면 시간 초과를 받는 경우가 많다.
* 불필요한 공간이 없다면, 메모리 제한은 알아서 지켜진다.

## I/O

> 입출력

* Scanner와 System.out을 사용하여 입출력
  * `Scanner sc = new Scanner(System.in);`
* 입력이 많은 경우에는 속도가 느리기 때문에, BufferedReader를 사용
  * `BufferedReader br = new BuffreredReader(new InputStreamReader(System.in));`
* 출력이 많은 경우에는 StringBuilder를 사용해서 한 문자열로 만들어서 출력을 한번만 사용하거나 BufferedWriter를 사용한다.

### 입력 속도 비교

* 10,000이하의 자연수 10,000,000개가 적힌 파일을 입력받는데 걸리는 시간
  * Java (BufferedReader) : 0.6585초
  * Java (Scanner) : 4.8448초

### 출력 속도 비교

* 1부터 10,000,000까지 자연수를 한 줄에 하나씩 출력하는 시간
  * Java (BufferedWriter): 0.9581초
  * Java (StringBuilder): 1.1881초
  * Java (System.out.println): 30.013초

## Example

* Hello World
  * https://www.acmicpc.net/problem/2557
* A+B
  * https://www.acmicpc.net/problem/1000
  * https://www.acmicpc.net/problem/2558
  * https://www.acmicpc.net/problem/10950
  * https://www.acmicpc.net/problem/10951
  * https://www.acmicpc.net/problem/10952
  * https://www.acmicpc.net/problem/10953
  * https://www.acmicpc.net/problem/11021
  * https://www.acmicpc.net/problem/11022
* A+B - 3
  * https://www.acmicpc.net/problem/10950
  * Testcase가 존재하는 경우, 모든 Testcase를 연산 이후에 한번에 출력하려고 하지말고 각 Testcase마다 입력받고, 출력하고의 반복으로 진행하는 것이 좋다.
* A+B - 4
  * https://www.acmicpc.net/problem/10951
  * 입력을 EOF(EndOfFile)까지 받으면 된다.