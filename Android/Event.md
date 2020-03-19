# Event

> 기본적인 Event의 내용은 [Activity](Activity.md)에서 설명하였다.
>
> 여기서는 특정 Event Example을 활용하며 설명한다.

## Image Change

* Layout의 xml에서 ImageView와 Button의 ID를 부여해둔 상태여야 한다.

* Button에 부여한 ID를 이용하여 Button 객체를 생성한다.

  ```java
  Button btn = findViewById(R.id.ImageChangeBtn);
  ```

* ImageView에 부여한 ID를 이용하여 ImageView객체를 생성한다.

  ```java
  ImageView iv = findViewById(R.id.iv);
  ```

* Button을 클릭했을 때 동작하도록 Handler와 Event를 지정한다.

  ```java
  btn.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
          
      }
  });
  ```

* ImageView의 image를 변경하는 코드를 onClick()메소드 안에 선언한다.

  ```java
  iv.setImageResource(R.drawable.cat2);
  ```

## Touch Event

> Android에서 Touch는 눌렀을 때, 뗐을 때를 모두 의미한다.

* Java파일에서 onTouchEvent()메소드를 Overriding한다.

* 내부에 Toast 객체의 makeText() 메소드를 사용한다.

  * 해당 메소드는 Alert과 같이 알림이 표시되도록 하는 메소드이다.
  * 첫 번째 인자는 Context 객체인데, this Activity가 Context객체를 상속하고 있기 때문에 this Activity를 넣어준다.
    * `this`를 사용한다.
  * 두 번째 인자는 문자열을 입력한다.
    * `"소리없는 아우성"`이라는 아무 문자열을 입력했다.
  * 세 번째 인자는 Toast 메시지가 얼마나 오래 보여질 지를 선언한다.
    * `Toast.LENGTH_SHORT`라는 잠깐 떠있다 사라진다는 표현을 사용했다.

* 이후 makeText()메소드의 뒤에 show()메소드를 사용하여 이를 화면에 표시한다.

  ```java
  Toast.makeText(this, "소리없는 아우성", Toast.LENGTH_SHORT).show();
  ```

* Swipe는 눌렀을 때와 뗐을 때의 X좌표 혹은 Y좌표 값이 다를경우로 인식한다.