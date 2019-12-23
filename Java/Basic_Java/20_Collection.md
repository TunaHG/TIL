# Collection

> Collection이란, 객체의 집합을 의미한다.

## Generic Class

```java
class Employee<T>{
    String name;
    T number;
    
    public Employee(String name, T number){
        super();
        this.name = name;
        this.number = number;
    }
    
    @Override
    public String toString(){
        return "Employee [name=" + name + ", number=" + number + "]";
    }
}
```

* `<T>`가 의미하는 것이 `Generic Class`이며 `String`, `int`와 같은 데이터 타입처럼 사용할 수 있다.

* `Employee<T> class`를 `main`메소드에서 어떻게 사용하는지 알아본다

  ```java
  public class Test01_generic {
  
  	public static void main(String[] args) {
  		Employee<String> emp1 = new Employee("홍길동", "2019001");
  		System.out.println(emp1);
  		System.out.println(emp1.number.charAt(3));
  		
  		Employee<Integer> emp2 = new Employee("고길동", 2019002);
  		System.out.println(emp2);
  		System.out.println(emp2.number.getClass());
  		
  		Employee emp3 = new Employee("김길동", 2019003);
  		System.out.println(emp3);
  		System.out.println(emp3.number.getClass());
  	}
  
  }
  ```

  * `emp1`은 `T`를 `String`으로 선언하였다. 그렇기에 객체를 생성할 때 두번째 인자를 `String`타입으로 입력했다. 또한 `String` 데이터 타입이기 때문에 `charAt()`과 같은 메소드를 사용할 수 있다.

  * `emp2`는 `Integer`타입으로 선언하였다. `getClass()`를 통해 확인해보니 `Integer`가 나온다.

  * `emp3`에서는 `T`의 데이터 타입을 선언하지 않았다. 이럴 경우 자동으로 `Object`타입으로 선언된다. 여기서는 `Object`로 선언되었으나 입력받은 값이 `int`형이기 때문에 `getClass()`는 `Integer`가 나온다. 하지만 이렇게 `Object`로 선언해주는 것은 매 사용시마다 다운캐스팅이 진행되기 때문에 좋지 않다.

  * Eclipse에서 이렇게 코드를 구성하면 노란색 경고줄이 표시되있다. 이는 객체를 생성할 때 다음과 같이 `< >`의 Generic Class를 붙여주지 않아서 그렇다.

    ```java
    Employee<String> emp4 = new Employee<String>("김길동", "2019001");
    ```

* Generic Class는 `<T>`처럼 하나의 타입만 선언할 수 있는 것은 아니다. `<T, P>`처럼 여러 개도 가능하다.

  ```java
  class Employee2<T, P extends Number> {
  	T name;
  	P number;
  	
  	public Employee2(T name, P number) {
  		super();
  		this.name = name;
  		this.number = number;
  	}
  
  	@Override
  	public String toString() {
  		return "Employee2 [name=" + name + ", number=" + number + "]";
  	}
  }
  ```

  * 여기서 주의할 것은 `P`에 `Number`가 상속되어 있다는 것이다. 이렇게 `Number`를 상속하면 다른 데이터 타입으로 사용할 때 `Number`를 상속받는 데이터 타입으로 사용해야 한다.

    ```java
    public class Test02_twin {
    
    	public static void main(String[] args) {
    //		Employee2<String, String> emp1 = new Employee2("홍길동", "2019001");
    //		Employee2<String, String> emp1 = new Employee2<String, String>("홍길동", "2019001");
    //		System.out.println(emp1);
    		
    		Employee2<String, Integer> emp2 = new Employee2<String, Integer>("홍길동", 2019001);
    		System.out.println(emp2.number/1000);
    		
    		Employee2<String, Double> emp3 = new Employee2<String, Double>("홍길동", 2019001.0);
    		System.out.println(emp3);
    		
    		Employee2 emp4 = new Employee2("고길동", 201701);
    		System.out.println(emp4);
    		System.out.println(emp4.number.getClass());
    	}
    
    }
    ```

    * 이처럼 사용하는 방법은 똑같지만 `Number`를 상속받지 않는 `String`타입으로는 사용하지 못한다.
    * `Double`로 사용할 때 `Int`형으로 값을 지정해줬더니 컴파일에러가 발생한다. `.0`을 뒤에 붙여서 `double`형이라는 것을 명시해줌으로써 에러를 해결할 수 있다.
    * `Integer`, `Double`등 `Wrapper Class`는 객체인 참조형과 기본형 데이터를 `Boxing`, `Unboxing`하며 자동으로 변환된다.

## Collection

> Stack과 Queue와 같은 자료구조들이 이렇게 구성되므로 잘 알아둔다.

### 1. List

> 배열 기반 혹은 노드 기반으로 관리하는 선형 구조
>
> 중복을 허용하며 대표적으로 LinkedList와 같은 형태가 있다.
>
> 배열과 비교했을 때, 어떤 값을 탐색할 때 주소를 찾아다니는 List가 배열보다 처리속도가 느리다. 하지만 데이터 삽입 또는 삭제가 이루어질 때 배열은 해당 위치 이후의 값들을 변경해줘야 하는 반면에 List는 참조하는 주소만 변경해주면 되기 때문에 쉽게 이루어진다.

* `ArrayList`를 이용하여 알아보면, `java.util`패키지에 있으며 다음과 같이 사용한다.

  ```java
  List<String> list = new ArrayList<String>();
  ```

* `add()`를 이용하여 값을 추가한다. 이 때 어느 위치에 넣을건지 정해줄 수 있다.

* `contains()`를 이용하여 특정 값이 `List`내에 존재하는 지를 알 수 있다.

* `ArrayList`말고도 `Vector`라는 `List`구조가 있는데, 이는 특정 메소드에 `synchronized`키워드가 추가된 클래스이다. 이는 여러 개의 쓰레드를 사용한다는 뜻이며 동기화 문제가 우려된다면 `Vector`를 사용하고 아니라면 `ArrayList`를 사용해주면 된다.

### Iterator

> Collection과 관련된 Interface
>
> 다음 세개의 메소드를 가지고 있다.

* `hasNext()`

  > 남아있는 데이터가 있는지를 살펴보는 메소드

* `next()`

  > 다음 데이터를 가져오는 메소드

* `remove()`

  > 데이터를 삭제하는 메소드

* `java.util`패키지에 포함되어 있으며, 다음과 같이 선언하여 사용한다.

  ```java
  Iterator<String> it = list.iterator();
  ```

* `Iterator`를 사용하여 `for`문처럼 순회를 진행하여 값을 출력하려면 다음과 같이 사용한다.

  ```java
  while(it.hasNext()){
      String data = it.next();
      System.out.println(data);
  }
  ```

* `Iterator`를 사용하여 데이터를 삭제하려면 다음과 같이 사용한다.

  ```java
  String rname = Scanner.nextLine();
  while(it.hasNext()){
      String data = it.next();
      if(rname.equals(data)) it.remove();
  }
  System.out.println(list);
  ```

  * 이 때의 `while`은 `Ctrl + Space`를 사용하여 빠르게 완성할 수 있다.

### 2. Set

> 주머니 같은 공간에 데이터를 넣어서 보관하는 것. 넣을 때는 아무렇게나 넣으며 꺼낼 때는 들어간 순서가 보장이 안되고 랜덤하게 꺼낸다.
>
> 중복된 데이터가 존재할 수 없다. 하지만 기본메소드인 equals()를 오버라이딩해주지 않는다면 객체간의 중복비교를 Object의 equals()로 비교하여 중복이 생길 수 있다. 그래서 Set을 이용한 데이터 타입에서는 equals()를 오버라이딩해서 중복을 체크할 수 있도록 해줘야한다.

* `HashSet`을 이용하여 알아보면, `java.util`패키지에 존재하며 다음과 같이 사용한다.

  ```java
  Set<Book> bookList = new HashSet<Book>();
  ```

* `<Book>`클래스 내부에 `euqals()`를 메소드 오버라이딩해줬기 때문에 중복을 입력하면 제거된다.

* `add()`를 사용하여 데이터를 추가한다.

* `Iterator`를 사용하는 것은 `List`와 동일하다.

### 3. Map

> key와 value가 짝을 이루는 구조
>
> 특정 key값에 해당하는 value를 탐색하는 처리속도가 빠른구조다.

* `put()`을 이용하여 데이터를 삽입한다.
* `key`들의 집합을 `return`해주는 `keySet()`이라는 메소드가 존재한다. 하지만 이는 `return`타입이 `Set`이다. 그렇기에 `Set`으로 선언해서 데이터를 받고난 후 `Set`을 다시 `Iterator`를 통하여 출력한다.