# Array

> 변수에 데이터를 저장할 때 가은 데이터 타입의 데이터를 같은 용도로 많이 저장하려면 그만큼 많이 변수가 필요하다. 이를 효율적으로 하기 위해 배열(Array)이 존재한다.

## 1. 1차원 배열

* 배열은 같은 데이터 타입을 가지며, 크기를 선언하며, 크기만큼의 데이터 수를 가질 수 있다.

* 배열은 참조형 데이터 타입이며 Heap 메모리 영역에 배열이 생성된다. 선언된 변수명은 배열의 주소를 가지는데, 배열은 크기만큼의 주소 개수를 가지고 있기 때문에 변수명이 가지는 배열의 주소는 배열의 첫번째 칸의 주소를 의미한다.

* 배열의 선언은 다음과 같다.

  ```java
  int num[];
  num = new int[5];
  
  int[] num;
  num = new int[5];
  
  int num[] = new int[5];
  
  int[] num = new int[5];
  ```

* 배열의 초기 값은 다음과 같다

  ```java
  int[] num = new int[5];
  String[] str = new String[5];
  
  for(int i = 0; i < 5; i++){
      System.out.println(num[i] + " " + str[i]);
  }
  ```

  * 수치형 데이터는 0으로, 문자열 데이터는 null로 초기화된다.

## 2. 2차원 배열

> 1차원 배열 여러 개를 이용하여 배열을 하나 더 만드는 느낌이다.

* 선언

  ```java
  int[][] num = new int[2][3];
  int[][] num = new int[][] {{1, 2, 3}, {4, 5, 6}};
  int[][] num = {{1, 2, 3}, {4, 5, 6}};
  ```

* 2차원 배열은 **정방형**이지 않아도 된다.

  * 1행의 열개수가 2행의 열개수가 달라도 된다는 소리이며, 이를 **가변배열**이라 한다.

  ```java
  int[][] num = new int[4][];
  num[0] = new int[1];
  num[1] = new int[2];
  num[2] = new int[3];
  num[3] = new int[4];
  ```

* 동작방식

  * 2차원 배열을 선언한 변수 `num`은 각 행의 첫 열의 주소를 가지고 있는 배열의 첫 칸의 주소를 가진다. (각 행을 하나의 배열로 생각하면 각 배열의 주소값들을 모아놓은 배열의 주소가 num의 값이라는 소리다.)

  * 참조형 데이터 변수이다.

    ```java
    int[][] num2 = num;
    ```

    * num이 가진 값은 배열의 주소이기 때문에 num배열의 값을 변경하면 num2배열의 값도 변경된다. 이를 **Call By Reference**라고 한다.

## 3. 배열 관련 메소드

### Arrays

> `java.util Package`에 존재하는 배열에 대한 여러가지 함수를 지원해주는 `Class`이다.

#### toString()

> `toString()`메소드를 이용하여 1차원 배열을 반복문을 사용하지 않고 한번에 출력할 수 있다.

```java
int[] num = new int[10];

for(int i = 0; i < 10; i++){
    num[i] = (int) (Math.random() * 100) + 1;
}
System.out.println(Arrays.toString(num));
```

### arraycopy()

> `System`에 존재하는 `Method`로 배열을 복사하는 역할을 수행한다.

```java
int[] num = new int[10];
		
for (int i = 0; i < num.length; i++) {
	num[i] = (int)(Math.random() * 100) + 1;
}
System.out.println(Arrays.toString(num));

int[] tmp = new int[num.length * 2];
System.arraycopy(num, 0, tmp, 10, num.length);
System.out.println(Arrays.toString(tmp));
```

* `arraycopy()`가 받는 `parameter`는 순서대로 (복사하고자 하는 배열, 복사하고자 하는 배열의 시작위치, 붙여넣고자 하는 배열, 붙여넣고자 하는 배열의 시작위치, 복사하고자 하는 길이)를 의미한다.

* `length`는 배열의 길이를 return한다.

# Codes

* [Array](https://github.com/TunaHG/Java_Programming/blob/master/src/Day04/Test04_array.java)

* [Arraycopy](https://github.com/TunaHG/Java_Programming/blob/master/src/Day04/Test05_arraycopy.java)

* [Deduplication and Sort](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test01_duplicate.java)

* [Two Dimension](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test02_Twodim.java)