# Class

## 1. class

> 변수 세개를 가지는 간단한 Employee class를 만들어 실습하며 공부한다.

```java
class Employee{
	String name;
	String dept;
	int age;
	
	public void print() {
		System.out.printf("[%s,%s,%d]%n",this.name,this.dept,this.age);
		return  ;
	}
}
```

* `class`명은 `Employee`이며 `name`, `dept`, `age` 세 개의 데이터를 가지고 이를 출력하는 메소드를 가지고 있다.

```java
Employee emp1 = new Employee();
emp1.name = "홍길동";
emp1.dept = "기술부";
emp1.age  = 32;

Employee emp2 = new Employee();
emp2.name = "고길동";
emp2.dept = "교육부";
emp2.age = 29;

Employee emp3 = emp1;
      
emp1.print();
emp2.print();
emp3.print();

Employee[] employees = new Employee[3];
```

* `main`에서 위와 같이 사용한다.  객체가 가진 데이터와 메소드에 접근하기 위해서는 `객체명.데이터명`와 `객체명.메소드명`을 이용해야 한다.
* `new`를 사용하여 객체를 생성해줘야 하며 이후 객체에 접근하여 객체가 가진 데이터에 값을 입력해준다.
* `print()`메소드는 `Employee`클래스에서 선언한 메소드가 실행된다.
* `emp3 = emp1`부분을 살펴보면 배열때 공부한 **Call By Reference**를 의미한다.
* `Employee[]`에서 배열의 값은 객체를 의미하는 것이 아니라 객체를 가르키는 주소를 의미한다.
* `Employee`클래스는 `main`과 같은 java파일에서 작성되었다. 
  * 하나의 java파일에는 `public class`가 여러 개 있을 수 없다. 하나만 존재해야 한다.

## 2. static

> `Employee`클래스를 사용할 때는 객체를 생성해서 객체에서 데이터와 메소드를 호출해서 사용했다. 하지만 static으로 선언하면 메모리 중 static영역에 바로 올라가기 때문에 객체를 생성하지 않아도 데이터와 메소드가 사용이 가능하다.

* 실습을 위해 Calc Class를 static으로 만든다.

  ```java
  public class Calc {
  	public static int add(int a,int b){
  		return a+b;
  	}
  }
  ```

  * 이렇게 `static`으로 선언된 `Class`에서는 `this`와 `super`등의 키워드를 사용할 수 없다.

* 같은 패키지 내에 존재하는 `main`에서 다음과 같은 코드를 구성한다.

  ```java
  int res = Calc.add(99, 44);
  System.out.println(res);
  
  double r = Calc.add(55.5, 11.7);
  System.out.println(r);
  ```

  * 객체를 생성하지 않고 `Class`명을 이용해서 바로 호출하는 것을 확인할 수 있다.

## 3. Encapsulation

> Class를 실습할 때 main메소드에서 직접적으로 객체의 데이터를 변경해 줄 수 있었다.
>
> 이를 방지하기 위해 새로 만드는 Class에서는 Encapsulation을 통해 Getter / Setter를 사용하여야만 데이터 값을 변경하고 출력할 수 있게끔 만들어 준다.

```java
public class Account {
	private String name;
	private String number;
	private int money;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
    public void print(){
		System.out.printf("[%s(%s) 잔고:%7d원]%n",number,name,money);
		return;
	}
}
```

* 각 데이터를 `private`으로 선언하고, Getter / Setter를 위처럼 생성한다.
  * `Getter/Setter`는 `Eclipse`에서 `Source`메뉴에 `Generate Getter/Setter ...`를 통해 자동생성할 수 있다.
* 이제 데이터의 변수값을 변경하려면 Setter를 사용하고 변수값을 가져오려면 Getter를 사용해야한다.
* `this`를 사용해준 이유는 메소드 내에서는 로컬변수가 우선시되기 때문에 전역변수임을 알 수 있도록 `this`를 앞에 붙여준다.
  * 하지만 로컬변수로 전역변수와 같은 이름이 없다면 `this`를 사용하지 않아도 전역변수로 인식한다.

# Codes

* [Simple Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test05_class.java)
* [Static Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test06_static.java)

* [Account Test](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/AccountTest.java)
  * 필요 [Account Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/Account.java)

* [TV Test](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/TVTest.java)
* [Time](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/Test02_time.java)

* [Calc.add, Sort, max](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/Test01_util.java)
  * 필요 [Util](https://github.com/TunaHG/Java_Programming/blob/master/src/Util/myUtil.java)