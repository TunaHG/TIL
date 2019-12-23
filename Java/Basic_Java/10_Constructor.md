# Constructor (생성자)

> 생성자란, 객체를 생성할 때 어떤 일을 하고 생성될지를 표현하는 코드이다.
>
> 각 Class에는 생성자가 필수로 필요하며, 생성자를 만들지 않았을 시에는 기본생성자가 자동으로 생성된다.
>
> Class이름으로 선언된 코드가 생성자이다.

```java
public class Account {
	private String name;
	private String number;
	private int money;
	
	public Account() {
		this("","",0);
//		System.out.println("~~~~");
//		setNumber("");
//		setName("");
//		setMoney(0);
	}
	public Account(String number,String name,int money) {
		setNumber(number);
		setName(name);
		setMoney(money);
	}
	
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

* `Account()`가 기본생성자를 의미한다. 현재 코드에선 기본생성자가 실행될 때 작동할 코드들을 추가해놨다.
  * `this()`가 의미하는것은 해당 Class의 생성자를 호출하는 것을 의미한다. 여기서는 기본생성자가 아닌 다른생성자를 동작시키는 코드이다. 이렇게 `this()`가 구현부에 포함되면 `super()`는 생성되지 않는다.
* 기본생성자가 아닌 다른생성자는 현재 Class내의 전역변수의 값들을 지정하는 코드를 가지고 있다.
* 생성자는 객체가 생성될 때만 관여하며 그 이후에는 메소드처럼 호출하여 사용하는 것이 불가능하다.
* `Eclipse`에서는 생성자를 자동 생성하는 기능이 존재한다.
  `Source`메뉴의 `Generate Constructor using fields`를 사용하면 된다.

> 이를 활용하는 main메소드가 포함된 코드는 다음과 같다

```java
Account a1 = new Account("2019-12-09-001","홍길동",10);
a1.print();
		
Account a2 = new Account("2019-12-09-008","김길동",7000);
a2.print();

Account a3 = new Account();
a3.print();
```

# Codes

* [Account Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/Account.java)

* [Account Test2](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/AccountTest2.java)

* [Account Test3](https://github.com/TunaHG/Java_Programming/blob/master/src/Day06/AccountTest3.java)

* [Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Test03_Dog.java)
  * 필요 Class [Dog](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Dog.java) [Animal](https://github.com/TunaHG/Java_Programming/blob/master/src/Day07/Animal.java)

