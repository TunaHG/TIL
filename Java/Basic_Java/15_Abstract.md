# Abstract

> 추상화란 특정 메소드를 무조건 오버라이딩하도록 만들기 위해서 진행하는 작업이다.

* 추상 메소드로 선언하기 위한 키워드는 `abstract`이다.

  ```java
  public abstract void breath();
  ```

  * 메소드의 선언부만 존재하며 구현부는 존재하지 않는다.
  * 해당 메소드만 가지고는 호출할 수 없으며 메소드 오버라이딩이 되어있는 상태여야한다.

* 추상 메소드가 선언되면 해당 Class 또한 추상 Class가 되어야한다.

  ```java
  public abstract class Animal{
      public abstract void breath();
  }
  ```

  * 추상 Class에 추상 메소드가 아닌 기본 메소드와 데이터가 존재할 수 있다.

* 추상 Class를 상속받은 하위 Class에서는 추상 메소드를 오버라이딩하지않으면 에러가 발생한다.

* 추상 Class는 해당 Class만을 가지고는 추상 메소드가 어떻게 동작해야될지 모르므로 객체를 생성할수 없다. 하지만 추상 Class를 데이터 타입으로는 선언할 수 있다.

# Codes

* [Animal](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Animal.java)
* [Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Dog.java)
* [Fish](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Fish.java)
* [Abstract Test](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/AnimalTest.java)