# Math 1

## 나머지 연산

컴퓨터의 정수는 저장할 수 있는 범위가 저장되어 있기 때문에, 답을 M으로 나눈 나머지를 출력하라는 문제
이러한 문제는 답을 구한 이후 나머지연산을 진행하는 것이 아닌 중간중간 나머지 연산을 진행한다.
$$
(A+B) \bmod M = ((A \bmod M) + (B \bmod M)) \bmod M \\
(A*B) \bmod M = ((A \bmod M) * (B \bmod M)) \bmod M
$$

나누기의 경우에는 성립하지 않는다. (Modular Inverse를 구해야 함)
뺄셈의 경우에는 먼저 mod 연산을 한 결과가 음수가 나올 수 있기 때문에 다음과 같이 해야한다.
$$
(A-B) \bmod M = ((A \bmod M) - (B \bmod M) + M) \bmod M
$$

## 최대공약수 (GCD)

두 수 A와 B의 공통된 약수 중에서 가장 큰 정수

최대공약수를 구하는 가장 쉬운 방법은 2부터 min(A, B)까지 모든 정수로 나누어 보는 방법이 있다.
최대공약수가 1인 수를 서로수라고 한다.

### 유클리드 호제법

최대공약수를 구하는 빠른 방법

a를 b로 나눈 나머지를 r이라고 했을 때 GCD(a, b) = GCD(b, r)과 같다.
r이 0이면 그 때 b가 최대 공약수이다.

재귀함수를 사용해서 유클리드 호제법을 구현이 가능하다.

```c
int gcd(int a, int b) {
    if (b == 0) {
        return a;
    } else {
        return gcd(b, a%b);
    }
}
```

```c
int gcd(int a, int b) {
    while(b != 0){
        int r = a%b;
        a = b;
        b = r;
    }
    return a;
}
```

## 최소공배수 (LCM)

 두 수의 공통된 배수 중에서 가장 작은 정수

GCD를 응용해서 구할 수 있다.
두 수 a, b의 최대공약수를 g라고 했을 때 최소공배수 `l = g *  (a/g) * (b/g)`이다.

## 소수

약수가 1과 자기 자신 밖에 없는 수

N이 소수가 되려면, 2보다 크거나 같고 N-1보다 작거나 같은 자연수로 나누어 떨어지면 안된다.

### 소수 판별 방법

> 어떤 수 N이 소수인지 아닌지 판별하는 방법

```c
bool prime(int n) {
    if(n < 2) {
        return false;
    }
    for(int i = 2; i <= n - 1; i++){
        if(n % i == 0) {
            return false;
        }
    }
    return true;
}
```

더 좋은 방법이 존재함. N/2보다 작거나 같은 자연수로 나누어 떨어지면 안되는 방법.
어떤 수 N이 소수가 아니라고 한다면, a와 b의 곱으로 나타낼 수 있는데 이 때 a의 최소값은 2이고 b의 최대값은 N/2이다.
가장 작은 수가 2이면 가장 큰 수는 N/2 이므로 (N/2 + 1)부터 (N - 1)까지는 절대로 약수가 있을수가 없다.

```c
bool prime(int n) {
    if(n < 2) {
        return false;
    }
    for(int i = 2; i <= n/2; i++){
        if(n % i == 0) {
            return false;
        }
    }
    return true;
}
```

두 가지 방법 모두 시간복잡도는 **O(N)**이다.

더더 좋은 방법이 존재한다! N이 소수가 되려면, 2보다 크거나 같고 루트N 보다 작거나 같은 자연수로 나누어 떨어지면 안된다.
a와 b가 둘 다 루트N보다 작다고 가정한다면, 두 수의 곱은 항상 N보다 작기 때문에 두 수의 곱이 N이 되는 경우는 없다.
두 수가 모두 루트N보다 크다고 가정해도, 곱이 항상 N보다 크기 때문에 N이 되는 경우는 없다.
그러므로 한쪽에서만 루트N보다 작은 수를 탐색해보면 된다.
두 수가 모두 루트N과 같다면 소수가 아니므로 생각하지 않아도 된다.

```c
bool prime(int n) {
    if(n < 2) {
        return false;
    }
    for(int i = 2; i * i <= n; i++){
        if(n % i == 0) {
            return false;
        }
    }
    return true;
}
```

> 반복문에서 i가 루트N보다 작다고 하려면 루트 N이 정수가 아닌 실수가 나올 수 있기 때문에 종료 조건문을 위와같이 설정한다.

이 방법의 시간복잡도는 **O(루트N)**이다.

### 소수를 찾아내는 방법

> N보다 작거나 같은 모든 자연수 중에서 소수를 찾아내는 방법

위에서 알아낸 시간복잡도로 인해, 어떤 수가 소수인지 아닌지를 알아내는데 걸리는 시간복잡도는 O(루트N)이다.
그럼 1부터 1,000,000까지 모든 소수를 구하는데 걸리는 시간 복잡도는 몇일까?
각각의 수에 대해서 O(루트N)의 시간이 걸리는데, 수는 총 N개이므로 O(N루트N)의 시간복잡도를 가진다.
1,000,000 * 1,000 (루트1,000,000) = 1,000,000,000 = 10억 = 10초
너무 긴시간이 필요하다!

#### 에라토스테네스의 체

구하고자 하는 수까지 모든 수를 작성한 이후, 지워지지 않은 수 중에서 가장 작은 수의 배수를 모두 지우는 방법이다.
2의 배수를 지울 때 2 * 3은 지웠으므로 3의 배수를 지울 때 3 * 2는 지울 필요가 없다. 3 * 3부터 진행하면 된다.
그런 이치로, 가장 작은 수와 동일한 배수부터 진행하면 된다. (2 * 2, 3 * 3, 5 * 5, 11 * 11)
100까지의 수를 탐색한다면, 11 * 11은 121로 이미 100을 넘었으므로 11부터는 지우지 않아도 된다.

```c
int prime[100]; // 소수 저장
int pn = 0; // 소수의 개수
bool check[101]; // 지워졌으면 true
int n = 100; // 100까지의 소수
for (int i=2; i<=n; i++) {
    if (check[i] == false) {
        prime[pn++] = i;
        for (int j = i*i; j<=n; j+=i) {
            check[j] = true;
        }
    }
}
```

> for문의 j값을 지정할 때는 i*i는 지양하는것이 좋다. N이 백만일 경우 해당 수가 int값을 넘어서서 이상한 값이 들어갈 수 있기 때문. i * 2를 넣는 것이 좋다.

#### 골드바흐의 추측

2보다 큰 모든 짝수는 두 소수의 합으로 표현이 가능하다.
위의 문장에 3을 더하면
5보다 큰 모든 홀수는 세 소수의 합으로 표현이 가능하다.
이 문제는 아직 증명되지 않았지만, 10의 18승 이하에서는 참인 것이 증명되어 있다.

백만 이하의 짝수에 대해서 골드 바흐의 추측을 검증하는 문제가 있다.
에라토스테네스의 체를 이용한다. N = a + b가 참이어야 증명이 되므로 N - b가 에라토스테네스 체로 지워진 수인지를 판별한다.

모든 소수는 6n + 1 혹은 6n + 5의 형태를 가진다. 이를 에라토스테네스의 체에 적용하여 시간을 줄일 수 있다.
시간이 6배 빨라질 것 같지만, 에라토스테네스의 체가 기본적으로 빠르기때문에 시간차이가 크지않다.

## 팩토리얼

N! = 1 x 2 x ... x N

### 팩토리얼 0의 개수

팩토리얼의 결과값에 0이 몇 개인지를 알아내는 문제.
int값에 제한이 되어 있기 때문에 팩토리얼의 결과값을 구하고 0을 탐색하려면 문제가 발생한다.

0의 개수는 소인수 분해해보면 알 수 있다.
0이 존재하려면 10의 배수여야 하므로 2 * 5가 몇개인지 소인수 분해를 통해 알아내면 된다.
하지만 소인수분해의 결과중 2의 개수는 항상 5의 개수보다 많기 때문에 5의 배수가 몇개인지를 알아내면 된다.

100!의 경우 인수로 5가 들어가는 것을 찾는다.
5의 배수에서 5가 1개씩 등장하므로 20번 등장하고, 5가 두번씩 들어가는 25, 50, 75, 100에서 한번씩 추가해야 되므로 100/25 = 4를 추가한다.

### 조합 0의 개수

nCm의 0의 개수를 구하는 문제이다.

여기서는 2의 배수가 더 적을 수 있기 때문에 2의 배수와 5의 배수의 개수를 모두 구하고 그 중 최소값을 찾는다.

# 연습

## GCD 합

https://www.acmicpc.net/problem/9613

수 N개가 주어졌을 때, 가능한 모든 쌍의 GCD의 합을 구하는 문제

## 숨바꼭질 6

https://www.acmicpc.net/problem/17087

동생 N명을 찾는 1초에 +D, -D만큼 이동하면서 찾는 문제. 가능한 D의 최댓값
D는 거리의 차이의 약수, 모든 거리 차이의 최대공약수를 구하는 문제.

a, b, c의 최대공약수는 a,b 의 최대공약수, c의 최대공약수이다.

## 진법 변환

* https://www.acmicpc.net/problem/1373
  2진법을 8진법으로 변환하는 문제
  2진수를 3자리씩 뒤에서 끊으면 8진수를 만들수 있다.
* https://www.acmicpc.net/problem/2089
  N을 -2진수로 바꾸는 문제, N진법변환과 동일하게 진행하되 음수변환을 조심

## 소수

* 골드바흐 파티션
  https://www.acmicpc.net/problem/17103
  백만 이하의 짝수 N을 두 소수의 합으로 나타내는 방법의 수를 구하는 문제