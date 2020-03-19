# Event

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