# Access Modifier

> 접근에 대한 권한을 지정하는 접근지정자 4개에 대해 알아본다.

|                    | 같은 클래스 | 같은 패키지 | 하위 클래스 | 전체 |
| :----------------: | :---------: | :---------: | :---------: | :--: |
|      `public`      |      O      |      O      |      O      |  O   |
|    `protected`     |      O      |      O      |      O      |  X   |
| `package(default)` |      O      |      O      |      X      |  X   |
|     `private`      |      O      |      X      |      X      |  X   |

* 평소에 생략하고 사용하는 접근지정자는 모두 `package`이다.
  * 같은 패키지 내에서만 사용하며 객체로 생성되었을 경우 객체.변수명으로 직접적으로 접근하여 값을 변경하거나 출력할 수 있다.
* `private`은 상속을 사용할 때 **Encapsulation**을 공부하며 사용해봤다.
  * 같은 Class내에서만 사용이 가능하며 그 외에는 Getter/Setter를 이용하여 접근할 수 있다.
* `protected`는 상속받은 하위 Class에서는 `super.data`와 같이 접근이 가능하나, 다른 패키지에서는 불가능 하다는 것이다.
* `public`은 어디서나 사용가능한 접근 지정자이다.
* Class는 public과 package 두 개의 접근지정자로만 선언이 가능하다.

# Codes

* [Protected](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test01_protected.java)
  * [Animal](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Animal.java)