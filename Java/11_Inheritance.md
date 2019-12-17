# Inheritance 상속

> 하나의 `Class`가 다른 `Class`를 부모로 가져서 부모의 데이터와 메소드를 사용할 수 있는 기능
>
> `extends`키워드를 사용한다.

```java
public class Dog extends Animal{ }
```

* **SIngle Inheritance (단일 상속)**
  하나의 Class가 가질 수 있는 부모 Class는 1개뿐이다.
* `extends`를 선언하지 않는 모든 Class는 **최상위 Class인 Object Class를 상속**한다.
  * Object Class는 데이터를 가지고 있지 않으며 equals(), toString()등 몇 개의 메소드만 가지고 있다.
* 하위 Class와 상위 Class가 같은 변수명을 이용할 때 상위 Class는 `super`키워드를 사용하여 접근한다.
* 상위 Class의 생성자에 접근할 때 `super()`키워드를 사용한다.
  * `super()`는 `this()`를 사용하지 않고, `super()`를 생성해두지 않으면 자동 생성되며, 생략되어 있다.

## Example

> [Animal Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Animal.java)와 그를 상속하는 [Dog Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Dog.java)를 이용한다.

* `Animal`의 `kind`와 `Dog`의 `kind` 두 변수의 타입과 이름이 겹친다. 하지만 서로 다른 클래스기 때문에 다르게 동작하는데, 이를 구분해 주기 위하여 `this`와 `super`를 이용한다.

  ```java
  // In Dog Class
  Animal.kind = super.kind;
  Dog.kind = this.kind;
  ```

  * 이 때 `main`메소드에서는 상위 `Class`의 데이터에 접근할 수 없다. 접근하기 위해서는 그런 역할을 수행하는 다른 메소드를 만들어줘야한다.

* `Dog`에서 `Animal`의 생성자에 접근하는 방법은 `super()`를 사용하는 것이다.

## Memory

> 메모리 부분에서 상속된 Class가 어떻게 동작하는지 알아본다.

* 하위 Class가 객체로 생성되면 객체는 부모 Class를 자신의 객체 위에 얹어서 하나의 객체로써 생성된다. Dog객체를 생성하면 Animal객체가 하나의 객체로 묶여서 생성되는 방식이다.

* 호출은 가장 아래에 있는 Class부터 호출된 변수가 있는지를 탐색한 후 가져온다.

## IS A

> Is a 관계에 대해서 알아본다.
>
> 모든 객체의 데이터 타입은 부모 Class가 될 수 있다는 것이다.

* Dog객체를 생성할 때 데이터 타입은 Dog뿐만이 아닌 Animal과 Object가 될 수 있다는 것이다.

* 하지만 이 때, 데이터 타입에 따라 Access할 수 있는 객체의 영역이 다르다.

  * 선언된 데이터 타입부터 그 상위 Class로만 Access가 가능하다
    Dog객체를 Animal타입으로 선언하면 Dog Class의 데이터와 메소드에는 Access가 불가능하다.

* 이를 해결하기 위해 **Casting**을 진행하면 된다.

  * 기본형 데이터 타입에서 공부한 Casting과 동일하게 사용한다.

  * 이 때 어떤 타입으로 Casting할 것인지 조심해야 한다.
    Dog객체를 Object타입으로 선언했을 때, String타입으로 Casting이 가능하다. 두 Class 모두 Object를 상위 Class로 가지고 있기 때문이다. 컴파일에러가 발생하지 않지만 실행시키면 에러가 발생한다.

  * 이를 방지하기 위해 `instanceof`를 사용한다.

    ```java
    Dog d = new Dog();
    Object obj = d;
    if(obj instanceof Dog) System.out.println("Good");
    ```

    다음과 같이 변수가 특정 객체인지를 판별해 준다.

## Has A

> Class내부에 다른 Class 객체가 변수로써 선언되는 형태다.
>
> 원을 의미하는 Circle Class와 점을 의미하는 Point Class를 각 의미에 맞게 사용한다고 가정할 때 Circle은 Point의 변수를 포함하고 있다. 이를 효율적으로 변경하기 위해선 상속해야 하는데 그렇다면 Circle이 Point의 하위클래스로 사용된다는게 의미에 맞지 않게되므로 이럴 때 사용하는 것이 포함(has a)관계이다.

```java
class Point {
    int x;
    int y;
}
class Circle {
    Point p;
    int r;
}
```

# Codes

* [Animal](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Animal.java)
* [Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Dog.java)
* [Inheritance Animal, Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Test01_Inheritance.java)
* [Casting](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Test02_Type.java)
* [HasA](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test03_hasa.java)