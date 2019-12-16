# Method Overloading

> 같은 `Method`명을 가졌으나 받는 `parameter`의 타입이나 개수가 다른 경우를 **Method Overloading**되었다고 한다.

* [Class](./08. Class.md)에서 사용한 `Calc`클래스를 활용한다

  ```java
  public class Calc {
      //메소드 오버로딩 
  	public static int add(int a,int b){
  		return a+b;
  	}
      
  	public static double add(double a,double b){
  		return a+b;
  	}	
      
  	public static int add(int ... a) {
  		int sum = 0;
  		for (int i = 0; i < a.length; i++) {
  			sum += a[i];
  		}
  		return sum;
  	}
  }
  
  ```

  * 같은 `add`라는 메소드명을 사용하나 받는 `parameter`의 개수나 타입이 다르다.
  * 같은 타입 중 `parameter`의 개수만 바뀌는 것에 대응하기 위해 `int ... a`를 `parameter`로 가지는 메소드 또한 만들었다. 이를 **가변인자**라고 한다.
    * 이 때 `a`는 배열과 같이 취급되어 배열처럼 사용하면 된다.
  * 이 때 int형 두 개를 사용하면 메소드 우선순위에 따라 가변인자를 사용하는 것이 아닌 int형 두 개를 인자로 가지는 위의 메소드를 실행하게 된다.

* 이 코드를 main메소드에서 사용해본다.

  ```java
  int res = Calc.add(99, 44);
  System.out.println(res);
  
  double r = Calc.add(55.5, 11.7);
  System.out.println(r);
  
  int res2 = Calc.add(13, 25, 44);
  System.out.println(res2);
  ```

# Codes

* [Calc Class](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Calc.java)
* [main method](https://github.com/TunaHG/Java_Programming/blob/master/src/Day05/Test06_static.java)

