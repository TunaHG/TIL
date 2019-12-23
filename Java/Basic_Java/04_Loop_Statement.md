# Loop Statement

## 1. for loop

> 반복문을 사용하지 않으면 똑같이 중복되는 코드들을 반복문을 사용함으로써 줄여줄 수 있다.
>
> For loop는 어디부터 어디까지 반복해야될지 확실히 아는 경우에 주로 사용한다.

```java
// for문 이용x
System.out.println(1);
System.out.println(2);
System.out.println(3);
System.out.println(4);
System.out.println(5);

// for문 이용
for(int i = 1; i <= 5; i++){
    System.out.println(i);
}
```

> for문의 사용형태는 다음과 같다.

```java
for(초기값 설정; 조건식 설정; 증감식 설정){
    조건식이 true일 때 실행할 부분
}
```

* for loop의 작동방식은 초기값 설정이후 조건식을 살펴서 true라면 내부의 코드를 실행하고 이후 설정된 증감식을 실행한다. 초기값 설정을 제외한 나머지 작동방식을 조건식이 false가 될때까지 반복한다.

* for문 역시 if문과 마찬가지로 이중으로 겹쳐서 사용이 가능하다

  ```java
  for(int i = 0; i < 5; i++){
      for(int j = 0; j < 5; j++){
          System.out.printf("%d, %d", i, j);
      }
  }
  ```

### Inhanced For Loop

> JDK 1.5 이상에서 제공되는 Inhanced for loop에 대해서 알아본다.

```java
int[] num = {1, 2, 3, 4, 5};
for(int i : num){
    System.out.println(i);
}
```

* 배열이 존재할 때 해당 배열의 값을 하나씩 넣는 For Loop다.

## 2. While Loop

> For Loop와 달리 어디부터 어디까지 반복해야 하는지 확실히 모를 경우 주로 사용한다.
>
> While문의 사용형태는 다음과 같다.

```java
while(조건문){
    조건문이 참일 때 실행할 부분
}
```

* For문과 While문은 다음과 같이 서로 변환이 가능하다.

  ```java
  for(초기값설정; 조건문; 증감식){
      내부 코드;
  }
  
  초기값설정;
  while(조건문){
      내부코드;
      증감식;
  }
  ```

## 3. Break

> while같이 언제 끝날지 모르는 반복문을 사용할 때, 원하는 조건문이 true가 되면 반복문을 break로 끝낼 수 있다.
>
> 다음과 같이 사용할 수 있다.

```java
while(조건문){
    if(원하는결과값이 떴는가?) break;
    내부 코드;
}
```

* 굳이 while문 뿐이 아닌 반복되는 모든 코드에서 반복문을 벗어나는 것이 가능하다.

### Break A

> 중지하고 싶은 반복문을 지정해주는 것도 가능하다.

```java
A : for(int i = 0; i < 5; i++){
    for(int j = 0; j < 5; j++){
        if(j == 3) break A;
    }
}
```

> 첫번째 반복문에 A라는 라벨을 지정해준 후 break A;를 사용하여 A반복문을 중지할 수 있다.

## 4. Continue

>  현재 진행중인 반복문의 아래 코드를 실행하지 않고 다음 반복으로 넘어가는 역할을 한다. 1부터 10까지를 반복한다고 가정했을 때, 2에서 continue를 만나면 2에서 실행되어야 할 continue아래 코드들이 실행되지 않고 3부터 다시 10까지 반복한다는 것이다.

```java
for(int i = 0; i < 10; i++){
    if(i % 2 == 0) continue;
    System.out.print(i);
} // 13579
```

* 2의 배수일 때 continue를 만나 출력코드를 생략하고 다음 반복으로 넘어가기 때문에 위와 같은 결과가 나온다.

# Codes

* [For Loop](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test06_for.java)

* [While Loop](https://github.com/TunaHG/Java_Programming/blob/master/src/Day04/Test02_while.java)

* [Break](https://github.com/TunaHG/Java_Programming/blob/master/src/Day04/Test03_break.java)

* [Inhanced For Loop](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test04_Inhacedfor.java)