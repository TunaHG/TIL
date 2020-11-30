# Data Structure

## Stack

> 한쪽 끝에서만 자료를 넣고 뺄 수 있는 자료구조, LIFO(Last In First Out)

```c
int stack[10000];
int size = 0;

void push(int data) {
    stack[size] = data;
    size += 1;
}
int pop() {
    stack[size - 1] = 0;
    size -= 1;
}
```

* 구현 문제
  * https://www.acmicpc.net/problem/10828
  * [구현소스](http://codeplus.codes/905a5953c84340d1a573ba3466b16f83)
  * [라이브러리 사용 소스](http://codeplus.codes/cab3aefa6412478f8d81c7f37cc31721)
    * C: std::stack, Java: Stack 라이브러리 존재
* 단어 뒤집기
  * https://www.acmicpc.net/problem/9093
* 괄호
  * https://www.acmicpc.net/problem/9012
* 스택수열
  * https://www.acmicpc.net/problem/1874
* 에디터
  * https://www.acmicpc.net/problem/1406
  * 두 개의 스택을 활용하여 문제 해결

## Queue

> 한쪽 끝에서만 자료를 넣고 다른 한쪽 끝에서만 뺄 수 있는 자료구조, FIFO(First In First Out)

* 연산
  * push : 자료 넣는 연산
  * pop : 자료 빼는 연산
  * front : 가장 앞의 자료를 확인하는 연산
  * back : 가장 뒤의 자료를 확인하는 연산
  * empty : 비어있는지 확인하는 연산
  * size : 크기를 확인하는 연산
* 구현
  * C++의 경우 STL의 queue
  * Java의 경우 Java.util.Queue 사용
* 조세퍼스 문제
  * https://www.acmicpc.net/problem/1158
  * pop, push를 반복하며 N번째일경우 push를 하지않음

## Deque

> 양 끝에서 자료를 넣고 양 끝에서 뺄 수 있는 자료구조, Double-ended queue

* 연산
  * push_front: 덱의 앞에 자료를 넣는 연산
  * push_back: 덱의 뒤에 자료를 넣는 연산
  * pop_front: 덱의 앞에 자료를 빼는 연산
  * pop_back: 덱의 뒤에 자료를 빼는 연산
  * front: 가장 앞의 자료를 확인하는 연산
  * back: 가장 뒤의 자료를 확인하는 연산

## Example

* 단어 뒤집기 2
  * https://www.acmicpc.net/problem/17413
  * 단어 뒤집기 1과 태그가 등장한다는 차이가 있음
  * 태그의 안인지 밖인지 구분하여 뒤집기
  * 태그의 여는 부분이 나왔을 경우 그동안 모인 Stack을 전부 출력
* 쇠막대기
  * https://www.acmicpc.net/problem/10799
  * 닫는 괄호가 나왔을 때, 여는 괄호를 찾는 것은 괄호문제와 동일하지만 쇠막대기인지를 판별해야되는 것이 추가
  * Stack의 top과 인덱스 차이가 1이 나면 레이저
  * 남은 Stack의 크기는 레이저가 잘라서 추가되는 쇠막대기의 개수
  * http://codeplus.codes/dc40a92c327543c6958c28ca4cde6daa
* 오큰수
  * https://www.acmicpc.net/problem/17298
  * Ai보다 오른쪽에 있으면서 Ai보다 큰 수 중에서 가장 왼쪽에 있는 수

* 오등큰수
  * https://www.acmicpc.net/problem/17299
  * 등장횟수 Count하면서 비교