# Event

> 기본적인 Event의 내용은 [Activity](Activity.md)에서 설명하였다.
>
> 여기서는 특정 Event Example을 활용하며 설명한다.

* [Activity_main XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_main.xml), [MainActivity Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/MainActivity.java)

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

* [Example03 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example03_event.xml), [Example03 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example03_EventActivity.java)

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

* [Example04 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example04_touch_event.xml), [Example04 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example04_TouchEventActivity.java)

## Swipe Event

* Swipe는 눌렀을 때와 뗐을 때의 X좌표 혹은 Y좌표 값이 다를경우로 인식한다.

* Layout의 XML파일을 LinearLayout으로 구성한다.

  * 이 때 LinearLayout 자체에 ID를 부여한다.

* Event Source 객체로 ID를 부여한 LinearLayout의 객체를 생성한다.

  ```java
  LinearLayout ll = findViewById(R.id.myLinearlayout);
  ```

* Handler와 Event가 결합된 메소드를 선언한다.

  * 이전에는 setOnClickListener()를 사용했지만 이번에는 Touch와 관련된 작업을 진행할 것이므로 setOnTouchListener를 사용한다.
  * 역시 마찬가지로 매개변수 또한 `new View.OnTouchListener()`를 지정한다.
  * 또한 Overriding해야하는 메소드 또한 onClick이 아닌 onTouch가 된다.

* 3개의 변수를 선언한다.

  * 누르는 Touch일 경우 X값을 저장할 double형 x1 변수
  * 떼는 Touch일 경우 X값을 저장할 double형 x2 변수
  * Swipe를 출력할 String형 msg 변수

* 누르는 Touch일 경우 X값을 저장하기 위하여 event.getAction()을 이용한다.

  ```java
  if(event.getAction() == MotionEvent.ACTION_DOWN) {
      x1 = event.getX(); // 누르는 Touch일 경우, 그때의 X좌표
  }
  ```

  * event는 onTouch() 메소드에 매개변수로 주어지는 MotionEvent 객체이다.
  * `MotionEvent.ACTION_DOWN`은 누르는 Touch를 의미한다.
  * getX()는 X값을 가져온다.

* 떼는 Touch일 경우 X값을 저장하고 x1과 x2를 비교하여 msg를 출력한다.

  ```java
  if(event.getAction() == MotionEvent.ACTION_UP) {
      x2 = event.getX(); // 떼는 Touch일 경우, 그 때의 X좌표
      if(x1 < x2){
          msg = "Right Swipe";
      } else {
          msg = "Left Swipe";
      }
      Toast.makeText(Example05_SwipeEventActivity.this, msg, Toast.LENGTH_SHORT).show();
  }
  ```

  * 출력하는 msg는 Toast.makeText()를 이용하여 알림을 띄운다.
  * `Toast.makeText`의 첫 번째 인자는 그냥 this를 사용하면 안된다. 해당 onTouch() 메소드가 존재하는 위치가 Anonymous Inner Class이기 때문에 직접 Class를 선언해주어야 한다.

* 주황색 경고표시가 떠있어도 실행되지만 없애고 싶다면 Alt + Enter를 통해 Annotation 하나를 추가한다.

  * onCreate() 메소드 위에 다음 Annotation이 추가되며 주황색 경고표시가 사라질것이다.

    ```java
    @SuppressLint("ClickableViewAccessibility")
    ```

* [Example05 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example05_swipe_event.xml), [Example05 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example05_SwipeEventActivity.java)

## Message to Activity

* Main Activity에서 onClick() 메소드를 다른 Event들과 조금 다르게 설정한다.

  * 사용자가 문자열을 입력할 Widget으로 EditText 객체를 먼저 생성해야 한다.

    ```java
    EditText edittext = new EditText(MainActivity.this);
    ```

    * 생성자의 매개변수로 Context가 필요하다.

  * 경고창을 출력하기 위한 Builder를 생성한다

    ```java
    AlertDialog.Builder builder = new AlertDialog.Builder(MainActivity.this);
    ```

    * 생성자의 매개변수로 Context가 필요하다.

  * 생성한 Builder로 Widget의 Title과 Message, View, Button를 지정한다.

    * 순서대로 출력된다.

    * View는 위에서 생성한 EditText 객체를 지정해준다.

      ```java
      builder.setTitle("Activity 데이터 전달");
      builder.setMessage("다음 Activity에 전달할 내용을 입력하세요.");
      builder.setView(edittext);
      ```

    * Button은 확인을 의미하는 PositiveButton과 취소를 의미하는 NegativeButtion의 이름을 지정한다.

    * 또한 각 Button이 클릭되었을 때의 동작을 추가한다.

      * `new DialogInterface.OnClickListener()`를 사용한다.

      * 위의 Listener 내부에 Overriding된 onClick() 메소드에는 이전과 비슷하게 Intent를 사용한다.

      * 하지만 EditText에 입력한 데이터를 전달해야 하기 때문에 `putExtra()`를 이용한다.

        ```java
        builder.setPositiveButton("전달",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 전달을 눌렀을 때 수행되는 이벤트 처리
                        Intent i = new Intent();
                        ComponentName cname = new ComponentName("com.example.androidlectureexample",  "com.example.androidlectureexample.Example06_SendMessageActivity");
                        i.setComponent(cname);
                        // 데이터를 전달해서 Activity를 시작
                        i.putExtra("sendMSG", edittext.getText());
                        startActivity(i);
                    }
                });
        builder.setNegativeButton("취소",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 취소를 눌렀을 때 수행되는 이벤트
                        // 특별한 처리를 안하면 Dialog가 종료되고 끝남
                    }
                });
        ```

  * Builder를 구성했다면 show() 메소드를 사용하여 출력한다.

    ```java
    builder.show();
    ```

* 데이터를 전달받을 New Activity를 생성

  * LinearLayout으로 구성하고 전달받은 데이터를 보여줄 TextView와 Activity를 종료시킬 Button을 추가

  * Java파일에서 TextView와 Button 객체 생성

  * Java파일에서 전달받은 데이터를 Intent로 받기

    ```java
    Intent i = getIntent();
    String msg = (String)i.getExtras().get("sendMSG");
    tv.setText(msg);
    ```

    * `getExtras()`로 모든 Extra를 가져오고 그 중에서 "sendMSG"라는 key를 사용하는 Object를 `get()`을 사용하여 가져온다.
    * Object기 때문에 Casting으로 String변경
    * 이후 String을 TextView의 text값으로 전달

  * Activity를 종료시킬 Button 구현

    * `OnClickListener`를 사용

    * Overriding하는 `onClick()`메소드의 내부에 Activity를 의미하는 this를 선언 후 `finish()`메소드 사용

      ```java
      closeBtn.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View v) {
              Example06_SendMessageActivity.this.finish();
          }
      });
      ```

* [Example06 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example06_send_message.xml), [Example06 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example06_SendMessageActivity.java)