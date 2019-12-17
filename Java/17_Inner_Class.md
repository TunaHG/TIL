# Inner Class

> B라는 Class에서 A라는 Class의 Data에 쉽게 접근하여 사용하고 싶을 때, B Class를 A Class의 Inner Class로 A Class 내부에 선언해 줄 수 있다.

* `Inner Class`를 사용하지 않으면 `Is a 관계` 또는 `Has a 관계`로 접근할 수 있다.

  ```java
  class A {
      String name = "홍길동";
  }
  class B {
      A a = new A();
      public void print() {
          System.out.println(a.name);
      }
  }
  ```

* `Inner Class`를 사용하면 내부적으로 메모리 영역에서 이점이 있고, 가장 쉽게 접근할 수 있다

  ```java
  class A {
  	String name = "홍길동";
  	
  	public A() { }
  	public A(String name) {
  		this.name = name;
  	}
  	void print() {
  		System.out.println(name.charAt(0) + "**");
  	}
  	
  	class B {
  		void print() {
  			System.out.println(name);
  		}
  	}
  }
  ```

  * 상속이 아니므로 `prnit()`가 오버라이딩되지 않는다.
  * B Class에서 A Class의 변수 name에 대하여 쉽게 접근이 가능하다.

* `Inner Class`로 선언하면 `.class`파일의 저장명도 바뀐다.

  * A Class는 `A.class`로 그대로 저장되지만 B Class는 `A$B.class`로 저장된다.

* `Inner Class`를 객체로 생성할 때도 방법이 다르다.

  ```java
  A a = new A("고길동");
  a.print();
  		
  A.B b1 = a.new B();
  b1.print();
  		
  A.B b2 = new A().new B();
  b2.print();
  ```

## Anonymous Inner Class

> Inner Class를 Class명 없이 사용할 수 있다.

* 간단한 `interface`하나를 사용한다.

  ```java
  interface Controller{
      void exec();
  }
  ```

* `Controller`객체를 생성할 때 처럼 new를 사용한다.

  ```java
  Controller insert = new Controller(){
      @Override
      public void exec(){
          System.out.println("insert Execute");
      }
  };
  ```

  * `A$B.class`로 저장된 `Inner Class`처럼 `{Classname}$1.class`로 저장된다.

## Lambda

> Anonymous Inner Class보다 더욱 간단한 방법

* `Interface`에만 사용이 가능하며 추상 메소드가 단 하나만 존재할 경우에 사용할 수 있다.

  ```java
  Controller insert = () -> {
      System.out.println("insert Execute");
  }
  ```

  * 메소드 구현부가 한줄이므로 { } 괄호 또한 삭제해도 된다.

    ```java
    Controller insert = () -> System.out.println("insert Execute");
    ```

# Codes

* [Inner Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test02_inner.java)
* [Anonymous Inner Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test03_anony.java)
* [Lambda](https://github.com/TunaHG/Java_Programming/blob/master/src/Day09/Test04_lambda.java)