# Method Overriding

> 부모 Class에 존재하는 메소드를 덮어써서 자신이 가진 메소드로 기능을 수행하게 하는 것이다.

* 메소드명, return타입, parameter 모두 같은 메소드가 상위 Class에 존재해야 한다.
* 상위 Class에서 작성한 메소드를 하위 Class에서 변경해서 사용할 때 주로 사용한다.

## Example

>  [Animal Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Animal.java)와 [Fish Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Fish.java)를 이용하여 설명한다.

* `breath()`메소드가 메소드 오버라이딩된 상태다.
  `Fish`객체에서 사용되는 `breath()`메소드와 `Animal`객체에서 사용되는 `breath()`메소드가 서로 다르게 출력된다.
* `Is A`관계로 선언된 `Animal`타입의 `Fish`객체여도 메소드 오버라이딩이 진행된 상태기 때문에 `Fish Class`의 `breath()`메소드가 실행된다.

## PolyMorphism

* 이러한 메소드 오버라이딩이 가지는 특성을 이용한 Java의 특성을 **다형성**이라한다.

> 다형성은 여러가지 형태를 가질 수 있는 능력이다.
>
> Java의 정석에 나온 설명을 빌리면,
> "Java에서는 한 타입의 참조변수로 여러타입의 객체를 참조할 수 있도록 함으로써 다형성을 프로그램적으로 구현했다. **조상클래스 타입의 참조변수로 자손클래스의 인스턴스를 참조할 수 있도록 하였다는 것이다.**" 라고 했다.

## General Overriding

> 일반적으로 새롭게 Class를 생성할 때는 `Object Class`가 가지고 있는 `equals()`와 `toString()`은 `Overriding`을 진행해줘야 한다.

* 특히 `toString()`메소드는 객체 출력시 사용하지 않아도 자동으로 사용된다.

  ```java
  Animal p1 = new Animal();
  System.out.println(p1);
  System.out.println(p1.toString());
  ```

* 만드는 Class에 맞도록 생성해주면 되는데, Eclipse에서 자동생성을 지원한다
  
  * `Source`메뉴의 `Generate toString()`과 `Generate hashCode() and equals()`를 이용한다.

# Codes

* [Animal](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Animal.java)

* [Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Dog.java)
* [Fish](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Fish.java)

* [print() Override](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Test04_override.java)
* [Animal Override](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/AnimalTest.java)

* [Object Overriding ](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test04_equals.java)
* [Object Overriding Automatically](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test05_generate.java)
* [Polymorpism](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test06_parampoly.java)