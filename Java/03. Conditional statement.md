# Conditional statement

## 1. If-Else

> `if`조건문은 다음과 같은 형태로 사용한다.

```java
if(조건문1) {
    조건문이 참일 때 실행할 부분
} else if(조건문2) {
    조건문1이 거짓이며 조건문2가 참일 때 실행할 부분
} else {
    조건문1과 조건문2가 모두 거짓일 때 실행할 부분
}
```

* 이 때 조건문은 true혹은 false로 판단되는 식이 들어가야 한다.

* 다음과 같이 조건문 내부에 조건문이 포함될 수 있다.

  ```java
  if(조건문1){
      if(조건문2){
          조건문1과 조건문2가 모두 참일 때 실행할 부분
      } else {
          조건문1이 참이며 조건문2가 거짓일 때 실행할 부분
      }
  } else {
      조건문1이 거짓일 때 실행할 부분
  }
  ```

## 삼항 조건문(?:)

> 삼항 조건문`(?:)`은 다음과 같이 사용한다.

```java
(조건문 ? 조건문이 참일 때 실행할 부분 : 조건문이 거짓일 때 실행할 부분)
```

* 역시 마찬가지로 조건문은 true혹은 false로 판단되는 식이 들어가야 한다.

## Switch-Case

> `switch-case`조건문은 다음과 같이 사용한다.

```java
switch(변수명){
    case 특정값:
        변수명이 특정값일 때 실행할 부분
        break;
    default:
        변수명이 위에서 언급된 특정값이 아닐 경우 실행할 부분
}
```

* case는 여러개가 존재할 수 있다.
* break문을 써주는 이유는 특정 case로 진입하여 실행했을 때 그 아래의 case들이 실행되지 않게 하기 위함이다.
* 변수명과 특정값이 들어가는 특성상 변수로는 `int`, `char`, `String`만 올 수 있다.

# Codes

* [IF](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test04_if.java)
* [Else IF](https://github.com/TunaHG/Java_Programming/blob/master/src/Day03/Test05_elseif.java)
* [Switch](https://github.com/TunaHG/Java_Programming/blob/master/src/Day04/Test01_switch.java)

