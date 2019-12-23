# Interface

> Abstract와 비슷한 목적으로 사용한다.
>
> 하위 Class에 특정한 메소드가 반드시 존재하도록 강제한다.

* `interface`키워드를 사용하여 선언한다.

* Abstract와 다르게 `interface`에는 `final member variable`과 `abstract method`만 올 수 있다.

  ```java
  abstract class Shape_a{
      String color;
      public abstract double cArea(double r);
      public void print(){
          
      }
  }
  
  interface Shape_i {
      final static String color = "red";
      double cArea(double r);
  }
  ```

  * 메소드를 선언할 때 interface내에서는 `public abstract`를 생략할 수 있다.

* 선언된 `interface`를 구현할 땐 `implements`키워드를 사용한다.

  ```java
  class Circle_i implements Shape_i {
      @Override
      public double cArea(double r){
          return Math.PI * r * r;
      }
  }
  ```

  * `cArea()`를 오버라이딩해줘야 에러가 발생하지 않는다.

* `interface`는 일반 Class가 아니기 때문에 상위 Class가 `Object`가 아니다.

* Class는 `Class`를 상속 받으며 `interface`를 구현할 수 있다.

  ```java
  class Circle extends Object implements Shape_i {}
  ```

  * 물론 `extends Object`는 생략할 수 있다.

## 다중 인터페이스

> interface는 Class상속과 다르게 여러개를 한번에 구현할 수 있다.

* 두 인터페이스를 한번에 구현한다.

  ```java
  class Circle implements Drawable, Moveable {}
  ```

* 두 인터페이스에 존재하는 특정 메소드들을 모두 오버라이딩 해줘야 한다.

  ```java
  class Circle implements Drawable, Moveable {
  	@Override
  	public void move() {
  		System.out.println(name + " 이동(move)");
  	}
  
  	@Override
  	public void draw() {
  		System.out.println(name + " 그리기(draw)");
  	}
  	
  }
  ```

  * `move()`는 `Moveable interface`에 존재하는 메소드이며, `draw()`는 `Drawable interface`에 존재하는 메소드이다.

* 이럴 때 `Drawable` 타입으로 `Circle`객체를 생성하게 되면 `move()`를 사용할 수 없다. 사용하려면 `Moveable`타입으로 `Casting`을 진행해야 한다.

  ```java
  Drawable s = new Circle();
  s.draw();
  s.move(); // Error
  ((Moveable)s).move();
  ```

* 이런 방식을 방지하기 위해 두 인터페이스가 구현된 하나의 인터페이스를 만들 수 있다.

  ```java
  interface T extends Drawable, Moveable {}
  ```

  * 두 `interface`를 상속받는 하나의 `interface`를 구현한다. 이를 **다중 인터페이스**라고 한다.

  ```java
  class Circle implements T {}
  ```

  * 다중 인터페이스를 구현하며 `T`타입으로 변수를 선언하면 `draw()`와 `move()`둘 다 사용 가능하다.

* `interface`내에서도 오버라이딩하지 않고 함수를 사용하는 방법이 존재한다.

  ```java
  void exec();
  default public void base(){
      System.out.println("Command base() 기능");
  }
  ```

  * `exec()`는 오버라이딩하여 사용해야하지만 `base()`는 하지않아도 사용이 가능하다. 물론 오버라이딩해서 사용할수도 있다.

# Codes

* [Interface](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test07_Interface.java)
* [Multi Interface](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test08_Multi_Interface.java)
* [default](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test01_default.java)