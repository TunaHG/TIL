# Enum

enum은 **열거형(enumerated type)**이라고 부른다. 
열거형은 서로 연관된 상수들의 집합, 멤버라 불리는 명명된 값의 집합을 이루는 자료형이다.
열거자 이름들은 일반적으로 해당 언어의 상수 역할을 하는 식별자이다. 

## 특성

열거형은 연관된 값들을 저장한다. 또 그 값들이 변경되지 않도록 보장한다.
열거형 자체가 클래스이기 때문에 내부에 생성자, 필드, 메소드를 가질 수 있어서 단순히 상수가 아니라 더 많은 역할을 할 수 있다.

## 예제

아래의 예제를 통해 학습한다.

```java
enum Card{
  Clubs, Diamonds, Hearts, Spades;
}
enum Human {
  Arm, Leg, Hearts;
}
public class Demo {
  public static void main(String[] args) {
    /*
    if(Card.Hearts == Human.Hearts) {
  		System.out.println("카드의 하트와 사람의 하트는 같다.");
		}
    */
    Card type = Card.Hearts;
    switch(type) {
      case Clubs:
        System.out.println("Clubs!");
        break;
      case Diamonds:
				System.out.println("Diamonds!");
        break;
      case Hearts:
				System.out.println("Hearts!");
        break;
      case Spades:
				System.out.println("Spades!");
        break;
    }
  }
}
```

enum은 class, interface와 동급의 형식을 가지는 단위다. 하지만 사실상 class이다. 편의를 위해서 enum만을 위한 문법적 형식을 가지고 있기 때문에 구분하기 위해서 enum이라는 키워드를 사용하는 것이다. 위의 코드는 아래 코드와 사실상 같다.

```java
class Card {
  public static final Card Clubs = new Card();
  public static final Card Diamonds = new Card();
  public static final Card Hearts = new Card();
  public static final Card Spades = new Card();
  private Card() {}
}
```

>   enum은 생성자의 접근제어자가 private이다. 그것이 클래스를 인스턴스로 만들수 없다는 것을 의미한다. 다른 용도로 사용하는 것을 금지하고 있는 것이다.

```java
if(Card.Hearts == Human.Hearts) {
  System.out.println("카드의 하트와 사람의 하트는 같다.");
}
```

>   이 코드는 컴파일 에러가 발생한다. 
>   enum이 서로 다른 상수 그룹에 대한 비교를 컴파일 시점에서 차단할 수 있다.

enum은 생성자를 가질 수 있다.

```java
enum Card{
  Clubs, Diamonds, Hearts, Spades;
  Card() {
    System.out.println("Call Constructor" + this);
  }
}
```

>   실행해보면 Call Constructor가 4번 호출된다. 이는 필드의 숫자만큼 호출되었다는 뜻이다. 
>
>   하지만 enum의 생성자가 접근 제어자 private만을 허용하기 때문에 생성자의 접근제어자를 public으로 변경하면 컴파일 에러가 발생한다.

이 생성자의 매개변수를 통해서 필드의 인스턴스 변수 값을 부여할 수 있다.

```java
enum Card{
  Clubs("black"), Diamonds("red"), Hearts("red"), Spades("black");
  public String color;
  Card(String color) {
    System.out.println("Call Constructor" + this);
    this.color = color;
  }
}
```

>   이후 switch문에서 Card.Clubs.color를 찍어보면 black으로 출력된다.
>
>   이는 Carddㅢ 상수를 선언하면서 동시에 생성자를 호출하고 있다.

열거형은 메소드를 가질 수 있다.

```java
enum Card{
  Clubs("black"), Diamonds("red"), Hearts("red"), Spades("black");
  public String color;
  Card(String color) {
    System.out.println("Call Constructor" + this);
    this.color = color;
  }
  String getColor() {
    return this.color;
  }
}
```

enum은 for문 등 loop문을 통해 멤버 전체를 열거할 수 있는 기능도 제공한다.

```java
for(Card c : Card.values()) {
  System.out.println(c + ", " + c.getColor());
}
```



# 참고

*   [Opentutorials](https://opentutorials.org/course/2517/14151)
*   [Java에서의 사용법, W3School](https://www.w3schools.com/java/java_enums.asp)