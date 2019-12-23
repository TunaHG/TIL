# SingleTone

> Java에서 클래스를 이용하여 객체를 생성하면, 각 객체당 다른 메모리 영역을 차지한다.
>
> 그럴 필요가 없다면 하나의 객체만을 생성한 후 다시 객체를 생성하고자 했을 때 이미 생성된 객체를 이용하는 방법이 존재한다. 접근 지정자인 `private`을 이용한다.

* 같은 클래스 내에서만 사용이 가능한 `private` 접근 지정자를 가진 생성자를 만든다.

  ```java
  private SingleTone(){ }
  ```

* 이는 다른 클래스에서 기본 생성자를 사용할 수 없게되므로 new를 이용한 객체생성이 불가능해진다.

  ```java
  SingleTone st = new SingleTone(); // Error
  ```

* 생성자를 이용해 객체를 생성할 수 없으니 메소드를 이용해 생성한다.

  ```java
  private static SingleTone s;
  public static SingleTone getInstance(){
      if(s == null) s = new SingleTone();
      return s;
  }
  ```

  * 객체를 생성하지 않고 메소드를 사용해야 하므로 `static`을 추가하였으며 마찬가지로 객체가 이미 생성되었는지 판단하며 객체가 없이 사용되야할 SingleTone 타입의 변수 s도 `static`으로 선언한다.
  * 객체가 생성되어있지 않은 `null`상태라면 새로이 객체를 생성하며 이미 생성되어있다면 생성되어있는 객체 s를 `return`한다.

* 오버라이딩되어있지않은 Object Class의 `toString()`을 사용하면 객체의 주소를 알 수 있다. 이를 활용하여 객체의 주소가 같다는 것을 확인한다.

  ```java
  SingleTone s1 = SingleTone.getInstance();
  SingleTone s2 = SingleTone.getInstance();
  System.out.println(s1);
  System.out.println(s2);
  ```

# Codes

* [SingleTone](https://github.com/TunaHG/Java_Programming/blob/master/src/Day08/Test02_SingleTone.java)