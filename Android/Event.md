

# Event

> 기본적인 Event의 내용은 [Activity](Activity.md)에서 설명하였다.
>
> 여기서는 특정 Event Example을 활용하며 설명한다.

* [Activity_main XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_main.xml), [MainActivity Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/MainActivity.java)

## Image Change

> Button을 클릭하면 Image가 변경되는 예제

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

> 화면을 터치했을 때 Alert창이 출력되는 예제
>
> Android에서 Touch는 눌렀을 때, 뗐을 때를 모두 의미한다.

* Java파일에서 onTouchEvent()메소드를 Overriding한다.

* 내부에 Toast 객체의 makeText() 메소드를 사용한다.

  * 해당 메소드는 Alert과 같이 알림이 표시되도록 하는 메소드이다.

  * 첫 번째 인자는 Context 객체이다

    * Context는 Interface를 의미하는데, 해당 Interface를 Activity가 구현하고 있기 때문에 is a관계에 의해서 Activity가 곧 Context가 된다.

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

> 화면을 Swipe했을 때 Alert로 문자열이 출력되는 예제

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

> Dialog, EditText를 이용하여 다음 Activity로 Message를 전달하는 예제

* Main Activity에서 onClick() 메소드를 다른 Event들과 조금 다르게 설정한다		.

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

## get Data From Activity

> Activity에서 데이터를 전달받아 출력하는 예제

* Main Activity에서 Intent를 사용하는 것은 같다.

  * 하지만 `startActivity`가 아닌 `startActivityForResult()`를 사용한다.
    * 새로 생성되는 Activity로부터 데이터를 받아오기 위한 용도이다.
  * 이는 requestCode가 필요한데 requestCode는 어떤 Activity로부터 데이터를 받는지 알기위해 필요하다.
    * int형으로 어떤값이 들어가든 상관없지만 다른 requestCode와 겹치지 않는 Unique한 값이어야 한다.

* 새로 생성한 Activity의 Layout

  * LinearLayout으로 구성하며 Spinner와 Button을 구성한다.

* Activity Java

  * Spinner 안에 표현될 데이터를 생성하는데 여기서는 문자열이라고 가정한다.

    ```java
    final ArrayList<String> list = new ArrayList<String>();
    list.add("포도");
    list.add("딸기");
    list.add("바나나");
    list.add("사과");
    ```

  * Spinner의 ID를 이용하여 객체를 생성

    ```java
    Spinner spinner = findViewById(R.id.mySpinner);
    ```

  * Data를 Spinner에서 어떻게 보여줄지를 설정할 Adapter 설정

    ```java
    ArrayAdapter adapter = new ArrayAdapter(getApplicationContext(),
            android.R.layout.simple_spinner_dropdown_item, list);
    ```

  * Adapter를 Spinner에 부착

    ```java
    spinner.setAdapter(adapter);
    ```

  * Spinner에서 선택된 Item 데이터를 가져오기 위한 Event를 처리한다.

    * `setOnItemSelectedListener()`를 사용한다.

      * `setOnItemClick`은 누르는 순간을 의미

      * `setOnItemLongClick`은 길게 누르는 순간을 의미

      * `setOnItemSelected`는 떼는 순간을 의미

      * Overriding 해야하는 Method가 두 개가 출력된다.

        ```java
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                result = list.get(position);
                Log.i("SELECTED", result + " Selected");
            }
        
            @Override
            public void onNothingSelected(AdapterView<?> parent) {
        
            }
        });
        ```

        * `onItemSelected` 메소드에서 position은 Spinner에서 선택한 Item이 몇 번째 Item인지 의미한다.

  * Button Click Event 처리

    * Intent, putExtra를 활용하여 데이터를 전송한다.

    * MainActivity에서 결과값을 인식할 수 있는 코드인 resultCode를 입력한다.

      * requestCode와 마찬가지인 역할을 수행하며 역시 Unique한 값이어야한다.

    * 이후 현재 Activity를 종료한다.

      ```java
      Button sendBtn = findViewById(R.id.sendDataBtn);
      sendBtn.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View v) {
              Intent returnIntent = new Intent();
              returnIntent.putExtra("resultValue", result);
              setResult(7000, returnIntent);
      
              Example07_DataFromActivity.this.finish();
          }
      });
      ```

* [Example07 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example07_data_from.xml), [Example07 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example07_DataFromActivity.java)

## ANR

> Application Not Responding - 오랜시간 연산이 수행되면 사용자와 Interaction이 중지되서 발생하는 문제
>
> ANR 문제를 경험해보는 예제

* Layout XML은 LinearLayout으로 구성하며 TextView와 Button 두 개를 구현한다.
* TextView에 대한 Reference를 획득
* 첫 번째 Button에 대한 Reference를 획득하고 Event를 처리한다.
  * 100억번 연산을 수행하는 for문을 진행하는 Event (상당히 오랜시간동안 수행되는 연산)
* 두 번째 Button에 대한 Reference를 획득하고 Event를 처리한다.
  * Toast Message를 출력하는 Event
* 앱을 실행시켜보면 첫 번째 Button을 눌렀을 때 두 번째 버튼은 눌리지 않는다.
  * 첫 번째 Button의 Event 연산을 처리중이라 작동하지 않는것
  * 잠시 기다리면 ANR 경고창이 뜨며 대기하거나 앱을 종료하거나 할 수 있다.
* ANR 현상을 방지하기 위하여 Thread를 사용한다.
  * Activity는 Thread로 동작한다. (UI Thread)
  * 로직 처리는 Background Thread를 이용해서 처리해야 한다.
* [Example08 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example08_anr.xml), [Example08 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example08_ANRActivity.java)

## Counter Log

> ANR Example에서 발생했던 문제를 Thread를 이용하여 해결하는 예제

* Layout XML파일은 ANR Example의 파일을 그대로 가져와서 ID만 변경한다.
* 두 번째 Button에 대한 Reference와 Event처리는 ANR Example과 동일하게 진행한다.
* Thread를 사용하기 위한 두가지 방법이 있다.
  1. 새로운 Class를 생성하여 Runnable interface를 상속받는 방법
  2. Activity안에 Inner Class를 사용하는 방법.
* Inner Class를 사용한다.
  * Overriding한 onCreate() 메소드 외부, Activity Class 내부에 Inner Class를 선언한다.
  * Runnable interface를 상속받는다.
  * 추상 메소드인 run()을 Overriding한 후 ANR에서 실패했던 for문을 넣어준다.
* 첫 번째 Button에 대한 Reference를 획득하고 Event를 처리한다.
  * Thread를 사용하여 처리한다.
  * 선언한 Inner Class로 객체를 생성하고 Thread를 생성한다.
  * start() 메소드를 사용하여 Thread를 시작한다.
* 구현 후 앱을 실행시켜본다.
  * 연산 시작버튼을 누르면 다른 Thread가 for문을 돌린다.
  * 다른 Thread가 for문을 돌리고 있기 때문에 두 번째 Button이 눌리고 알림창이 뜬다.
* [Example09 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example09_counter_log.xml), [Example09 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example09_CounterLogActivity.java)

## Progress Bar

> Counter Log Example에서 진행도 상황을 파악할 수 있는 Progress Bar가 추가된 예제

* Layout XML파일은 Counter Log Example파일을 가져온 후 ID를 변경하고 ProgressBar Widget을 추가한다.
* ProgressBar의 처리는 Thread처리를 진행할 Inner Class에서 진행한다.
  * Runnable Interface를 상속하는 Inner Class를 선언한다 
  * run()메소드를 Overriding하며 내부에 Event처리를 진행한다
  * Counter Log Example에서 진행했듯 0부터 100억까지의 덧셈을 진행한다
  * for문의 index를 1억으로 나눴을 때 0으로 나누어 떨어지면 ProgressBar의 수치를 1 증가시킨다.
  * ProgressBar의 수치를 변경하는 것은 `setProgress()`를 사용하며 매개변수로는 int값을 줘야한다.
* 첫 번째 Button의 Event처리는 Counter Log에서처럼 동일하게 진행한다.
* 구현은 가능하나 올바른 방법은 아니다.
  * Android UI Component(Widget)는 Thread Safe하지 않는다.
    * 하나의 Widget에 대하여 여러 개의 Thread가 동시에 접근하는 것을 허락하지 않는다는 뜻이다.
    * 여러 개의 Thread가 동시에 접근하면 원하는 방식으로 진행되지 않을 수 있다.
  * 그러므로 UI Component는 오직 UI Thread(Activity)에 의해서만 제어되어야 한다.
* [Example10 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example10_counter_log_progress.xml), [Example10 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example10_CounterLogProgressActivity.java)

## Handler

> Progress Bar Example에서 Thread문제를 Handler를 활용하여 해결하는 예제

* Layout XML은 Progress Bar Example 파일을 가져온 후 ID만 변경한다.
* TextView, ProgressBar에 대한 Reference를 가져오고 final처리를 진행한다.
* 데이터를 주고받는 역할을 수행하는 Handler 객체 생성
  * `android.os.Handler`를 import한 후 생성한다.
* Thread를 생성하고 실행하는 Event를 처리할 Button Event 처리 구현
  * 이 때 Thread는 이전 Example처럼 Inner Class로 만들지 않고 외부 Class로 구현한다.
    * Activity Class에 Field도 존재하지않으니 Inner Class로 만들 이유가 없다.
  * Thread Class는 다음과 같이 구현한다.
    * Runnable Interface를 상속받는 외부 Class를 구현 후 run() Method Overriding
    * run() Method의 구현부는 Example 10과 동일하게 구현하나, 
      pb.setProgress()와 tv.setText()는 제거한다.
    * Bundle 객체를 생성하고 putString()을 이용하여 key-value값으로 이루어진 데이터를 Bundle객체에 저장한다.
    * Bundle은 데이터를 묶는 역할을 진행하고 Message를 보내는 역할은 Message 객체이다.
    * Message 객체의 setData()를 이용해서 bundle을 추가한다.
    * handler의 sendMessage()를 이용해서 Message를 보낸다.
  * Button의 Event 처리
    * 외부 Class로 구현한 Thread Class 객체를 생성
    * Thread객체 생성, 매개변수로 외부 Class 객체 지정
    * start()
* 다시 Handler 객체로 돌아와서 메시지 받아서 화면처리 구현
  * 받아오는 Message가 Bundle객체로 받아오므로 Bundle 구현
  * `getString(key)`를 사용해서 Bundle에 넣어줬던 String 획득
  * ProgressBar 객체의 `setProgress()`를 사용하여 진행도 수정
    * String으로 받아왔기 때문에 `Integer.parseInt()`를 사용하여 int값으로 Casting
* [Example11 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example11_counter_log_handler.xml), [Example11 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example11_CounterLogHandlerActivity.java)

## Book Search(Simple)

> 단어가 포함된 책의 이름을 찾는 간단한 프로그램

* 단어를 입력할 EditText와 검색을 시작할 Search버튼, 책의 List를 출력할 ListView를 만든다.

* 검색버튼에 대한 Referene를 획득한다.

  ```java
  Button serachBtn = findViewById(R.id.searchBtn);
  ```

* 검색 입력창에 대한 Reference를 획득한다.

  ```java
  final EditText searchTitle = findViewById(R.id.searchTitle);
  ```

* 결과 ListView에 대한 Reference를 획득한다.

  ```java
  final ListView searchList = findViewById(R.id.searchList);
  ```

* Network연결을 해야하는데 이는 UI Thread(Activity)에서 작업하면 안된다.

  * Thread로 해결한다.
  * Thread와 데이터를 주고받기 위해서 Handler를 이용

* Handler 객체 생성

  ```java
  @SuppressLint("HandlerLeak")
  final Handler handler = new Handler(){
      @Override
      public void handleMessage(@NonNull Message msg) {
          super.handleMessage(msg);
      }
  };
  ```

  * Annotation은 Memory Leak를 방지하기위해 붙이는 것이다.
    * 안붙여도 주황색 경고표시만 나타나있으며 앱을 구동될 것이다.
  * Thread에 의해서 sendMessage가 호출될 예정인데, sendMessage에 의해서 전달될 데이터를 처리하기 위해서 handleMessage를 Overriding하면서 instance를 생성

* Button에 대한 Event처리

  * Thread 생성하여 실행

  ```java
  searchBtn.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
          BookSearchRunnable runnable = new BookSearchRunnable(handler, searchTitle.getText().toString());
          Thread t = new Thread(runnable);
          t.start();
      }
  });
  ```

  * runnable 객체에 handler와 keyword를 넣어준다.
    * 이 때 keyword는 searchTitle의 getText()를 이용해 가져오는데, 이는 Editable이므로 toString()을 통해 String형태로 만들어준다.

* Thread를 생성하기 위한 Runnable Interface를 상속받는 Class 구현

  * Handler를 사용하여 데이터를 주고받을 것이기 때문에 Activity Class 외부에 구현

  * handler와 검색할 단어를 의미하는 keyword를 변수로 가진다.

    * 해당 변수들을 생성자로 받아오도록 만든다.

    ```java
    BookSearchRunnable(Handler handler, String keyword) {
        this.handler = handler;
        this.keyword = keyword;
    }
    ```

  * Web Application을 호출, 결과를 받아와서 Handler를 통하여 Activity에게 전달한다.

    1. 접속할 URL을 준비한다.

       * 해당 URL은 [BookSearch](../R/MySQL.md)에서 진행했던 URL이다.

       ```java
       String url = "http://localhost:8080/bookSearch/searchTitle?keyword=" + keyword;
       ```

    2. Java Network 기능은 Exception 처리를 해야한다. (try-catch)

    3. URL 객체를 생성

       ```java
       URL obj = new URL(url);
       ```

       * URL 객체가 가진 Method를 사용하여 접속하기 위해 URL 객체로 생성한다.

    4. URL 객체를 이용해서 접속을 시도

       ```java
       HttpURLConnection con = (HttpURLConnection)obj.openConnection();
       ```

       * con값이 null이면 접속이 안됬다는 의미

    5. Web Application의 호출방식을 설정

       ```java
       con.setRequestMethod("GET");
       ```

    6. 정상적으로 접속이 되었는지 확인

       ```java
       int responseCode = con.getResponseCode();
       Log.i("BookSearch", "서버로부터 전달된 Code: " + responseCode);
       ```

    7. 보안을 설정

       * Android App은 특정 기능을 사용하기 위해 보안을 설정해야 한다.

         * Android 9(Pie) 버전부터는 보안이 강화되어 Web Protocol에 대한 기본 프로토콜이 HTTP에서 HTTPS로 변경되었다.
         * HTTP Protocol을 사용하는 경우 다음과 같은 설정을 해야한다.

       * AndroidManifest.xml에 다음의 Code를 추가한다.

         ```xml
         <uses-permission android:name="android.permission.INTERNET"/>
         ```

       * 또한 application 태그 내부에 다음을 추가한다.

         ```xml
         android:usesCleartextTraffic="true"
         ```

    8. 서버에서 받아온 데이터를 읽어와야 한다.

       ```java
       BufferedReader br = new BufferedReader(
           new InputStreamReader(con.getInputStream()));
       String readLine = "";
       StringBuffer responseTxt = new StringBuffer();
       while((readLine = br.readLine()) != null){
       	responseTxt.append(readLine);
       }
       br.close();
       ```

       * 기본적인 연결통로 (InputStreamReader)를 이용해서 조금 더 효율적인 연결통로(BufferedReader)로 다시 만들어서 사용한다.

    9. 받아온 JSON형식의 데이터를 Java의 자료구조로 변경하기 위해 JACKSON Library를 이용

       * JSON Library Download

         * Gradle Script - build.gradle(Module: app) - dependencies에 다음의 코드 추가

           ```
           implementation 'com.fasterxml.jackson.core:jackson-core:2.9.7'
           implementation 'com.fasterxml.jackson.core:jackson-annotation:2.9.7'
           implementation 'com.fasterxml.jackson.core:jackson-databind:2.9.7'
           ```

         * 추가한 이후, 상단의 Sync Now를 클릭하거나 File - Sync Project with gradle files를 클릭하여 적용한다.

       * JACKSON library를 사용

         ```java
         ObjectMapper mapper = new ObjectMapper();
         String[] resultArr = mapper.readValue(responseTxt.toString(), String[].class);
         ```

         * JSON문자열을 String 배열로 변환

    10. 최종 결과를 Activity에게 전달

        1. Bundle에 전달할 데이터 부착

           ```java
           Bundle bundle = new Bundle();
           bundle.putStringArray("BOOKLIST", resultArr);
           ```

        2. Message를 만들어서 Bundle을 Message에 부착

           ```java
           Message msg = new Message();
           msg.setData(bundle);
           ```

        3. Handler를 이용해서 Message를 Activity에 전달

           ```java
           handler.sendMessage(msg);
           ```

* Activity에서 생성한 Handler 객체로 돌아와 Message를 받는다.

  * Message에 포함된 Bundle 추출

    ```java
    Bundle bundle = msg.getData();
    ```

  * Bundle의 Key값을 활용하여 데이터 추출

    ```java
    String[] booklist = (String[])bundle.get("BOOKLIST");
    ```

* 전달 받은 데이터를 Adapter를 활용하여 ListView에 전달해야한다.

  * ListView의 사용은 Spinner와 비슷하다.

  * Adapter를 생성하여 데이터를 설정

    ```java
    ArrayAdapter adapter = new ArrayAdapter(getApplicationContext(),
            android.R.layout.simple_list_item_1,
            booklist);
    ```

  * ListView에 Adapter를 부착

    ```java
    searchList.setAdapter(adapter);
    ```
  
* [Example 12 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example12_simple_book_search.xml), [Example 12 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example12_SimpleBookSearchActivity.java)


## Book Search(Expand)

> Simple을 책 제목을 ListView에 띄우는 것 까지 였다면, Expand에서는 Web에서 책 제목뿐만 아니라 ISBN까지 가져온 후 책 제목만 출력하고 ISBN을 다음 Example에서 쓸수 있도록 준비하는 Example이다.

* Activity를 설정하기에 앞서, 데이터를 가져오는 Web Application에 대한 변경이 필요하다.

### Web Application

> Eclipse에서 MySQL의 데이터를 가져오는 Project를 만든다.

* Dynamic Web Project를 생성하고 MVC Pattern을 이용한다.

  * Project를 생성할 때 ContextRoot를 `bookSearch`로 설정한다.

* Controller 패키지를 생성하고 Servlet파일을 생성한다.

  * GET방식을 사용할 예정이므로 doGet메소드의 내용을 작성한다.

  * 클라이언트가 보내는 입력을 받는다.

    ```java
    String keyword = request.getParameter("keyword");
    ```

  * 로직처리를 진행할 Service 객체를 생성한다.

    ```java
    BookService service = new BookService();
    ```

  * Service 객체에서 로직 처리를 진행할 메소드를 호출한다.

    ```java
    ArrayList<BookVO> result = service.getBookInfo(keyword);
    ```

  * 가져온 결과 데이터를 Android App에게 Stream으로 출력하기 위해 JSON으로 만들어야한다.

    * Jackson Library를 이용하여 변환

    ```java
    ObjectMapper mapper = new ObjectMapper();
    String jsonData = mapper.writeValueAsString(result);
    		
    response.setContentType("text/plain; charset=utf-8");
    PrintWriter out = response.getWriter();
    out.print(jsonData);
    out.flush();
    out.close();
    ```

    * jackson과 관련된 core.jar, annotations.jar, databind.jar 세개의 파일이 존재해야 한다.

* VO 패키지를 생성하고 BookVO Class를 생성한다.

  * 데이터 전달객체(DTO, VO)가 존재해야 데이터 전달이 쉽다.
  * 책 1권에 대한 데이터를 담는 객체를 생성한다.
  * MySQL의 DB Table을 확인한 후 해당 Table에 존재하는 모든 Column을 변수로 추가한다.
  * 기본생성자를 만들고 Getter/Setter를 모든 변수에 대해 생성한다.

* 로직 처리를 진행할 Service Class와 Service Class에 포함된 Method가 필요하다.

  * Service 패키지를 생성하고 Class파일을 생성한다.

  * 크게 다른 로직 처리없이 DB처리만을 진행한다.

    * 하지만 DB처리조차 DAO에서 진행하기 때문에 DAO 객체를 생성하여 DB처리 Method를 실행

    ```java
    public ArrayList<BookVO> getBookInfo(String keyword) {
    	BookDAO dao = new BookDAO();
    	ArrayList<BookVO> result = dao.selectInfo(keyword);
    	
    	return result;
    }
    ```

* DAO 패키지를 생성하고 BookDAO Class를 생성한다.

  * DB처리 Code를 작성한다.

  * 다음의 코드를 작성한다

    ```java
    public ArrayList<BookVO> selectInfo(String keyword) {
    	Connection con = null;
    	ArrayList<BookVO> list = new ArrayList<>();
    		
    	try {
    		Context initContext = new InitialContext();
    		DataSource ds = 
                (DataSource)initContext.lookup("java:comp/env/jdbc/mySQLDB");
    		con = ds.getConnection();
    			
    		String sql = "select btitle, bisbn from book where btitle like ?";
    		PreparedStatement pstmt = con.prepareStatement(sql);
    		pstmt.setString(1, "%" + keyword + "%");
    		ResultSet rs = pstmt.executeQuery();
    		while(rs.next()) {
    			BookVO vo = new BookVO();
    			vo.setBtitle(rs.getString("btitle"));
    			vo.setBisbn(rs.getString("bisbn"));
    			list.add(vo);
    		}
    		rs.close();
    		pstmt.close();
    		con.close();
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	return list;
    }
    ```

    * Context와 InitialContext, DataSource는 MySQL과 연동하기 위한 Code이다.
    * 이후의 Code는 전형적인 DB 처리 Code이다.

* 이제 ListView의 항목 하나마다 새로운 기능을 구현할 때 다시 Web을 찾아오고 App부분을 먼저 살펴본다

* [Example 13 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example13_expand_book_search.xml), [Example 13 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example13_ExpandBookSearchActivity.java)

### Android App

* 화면 구성은 Simple Example과 동일하게 사용한다.

* 기본 코드 구성 또한 Simple Example과 동일하게 작성한다

* Thread에서 동작하는 Web과의 Network작업을 일부 변경한다

  * URL을 새로만든 Eclipse 프로젝트에 맞도록 변경한다.
  * Jackson Library를 사용하여 JSON데이터를 가져올 때, String[]을 BookVO[] Class로 변경한다.
    * 또한 여기에 BookVO가 필요하므로 Eclipse에서 작성한 BookVO Class를 그대로 아래에 붙여넣는다.
      * package와 class의 public을 삭제한다.
  * String[]이 아닌 BookVO를 사용하므로 bundle에서 putStringArray대신 putSerializable을 사용한다.

* Activity에서 Handler의 동작을 변경한다.

  * BookVO[]로 받아오므로 여기서 받는 데이터 타입도 BookVO[]로 받는다.

    * getSerializable을 사용한다.

      ```java
      BookVO[] booklist = (BookVO[])bundle.getSerializable("BOOKLIST");
      ```

  * ListView에는 책 제목만 출력할 예정이므로 BookVO[]에서 String[]을 추출해야한다.

    * String[] 변수를 생성한 후 BookVO에서 btitle을 추출한다.

      ```java
      String[] titles = new String[booklist.length];
      int i = 0;
      for(BookVO vo : booklist){
          titles[i++] = vo.getBtitle();
      }
      ```

  * Simple Example에서 진행한 것처럼 ArrayAdapter를 생성하여 ListView에 부착한다.

    ```java
    ArrayAdapter adapter = new ArrayAdapter(getApplicationContext(),
            android.R.layout.simple_list_item_1, titles);
    
    expandSearchList.setAdapter(adapter);
    ```

## Book Search(Detail)

> Expand Example에서 진행한 ListView를 클릭하면 ISBN값을 넘겨받아서 ISBN으로 Web에서 책 정보를 가져오고 책 정보를 새로운 Activity에 출력하는 Example
>
> 수행평가로 제출하는 내용이다.

### Example 13 (Expand Activity)

* Expand Example의 Activity에 ListView의 항목 클릭에 대한 Event를 처리한다.

  * ListView에 Adapter를 부착해놨으니 OnItemClickListener를 사용한다.

  * 이 때 선언한 booklist는 지역변수로 handleMessage() 안에 포함되어 있는데, 이를 사용하기 위해 전역변수로 선언해줘야한다.

    * Activity Class에서 전역변수로 선언한다. onCreate() 밖에서 선언해주면된다.

  * Intent를 사용하여 Example 14 Detail Example을 호출한다.

    * putExtra를 사용하여 isbn값을 넘겨줘야한다.

      ```java
      i.putExtra("BookISBN", booklist[position].getBisbn());
      ```

* Example 14 Detail Activity를 생성한다.

* Detail Activity에서 작동할 DB연결부분 처리를 Eclipse에서 새로운 Servlet을 생성하여야 한다.

### Web Application

* 새로운 Servlet을 생성한다.

  * Servlet의 구성은 Expand Example에서 진행했던 Servlet과 큰 차이가없다.

  * 호출하는 URL구성은 `/bookDetail`로 지정하였다.

  * Keyword로 주었던 Parameter를 bisbn으로 변경했다.

  * doGet() Method는 다음과 같이 구성되어 있다.

    ```java
    String bisbn = request.getParameter("bisbn");
    BookService service = new BookService();
    BookVO result = service.getBookDetail(bisbn);
    		
    ObjectMapper mapper = new ObjectMapper();
    String jsonData = mapper.writeValueAsString(result);
    			
    response.setContentType("text/plain; charset=utf-8");
    PrintWriter out = response.getWriter();
    out.print(jsonData);
    out.flush();
    out.close();
    ```

* 새로이 생성해야하는 Service의 getBookDetail() Method를 생성한다.

  * 역시 Expand Example과의 차이가 없다.

    ```java
    public BookVO getBookDetail(String bisbn) {
    	BookVO result = dao.selectDetail(bisbn);
    		
    	return result;
    }
    ```

* 또 새로이 생성해야 하는 DAO의 selectDetail() Method를 생성한다.

  ```java
  public BookVO selectDetail(String bisbn) {
  	// 전형적인 DB처리 Code 작성
  	Connection con = null;
  	BookVO vo = new BookVO();
  			
  	try {
  		Context initContext = new InitialContext();
  		DataSource ds = (DataSource)initContext.lookup("java:comp/env/jdbc/mySQLDB");
  		con = ds.getConnection();
  		String sql = "select bisbn, btitle, bauthor, bprice, bimgurl from book where bisbn = ?";
  		PreparedStatement pstmt = con.prepareStatement(sql);
  		pstmt.setString(1, bisbn);
  		ResultSet rs = pstmt.executeQuery();
  		rs.next();
  		vo.setBisbn(rs.getString("bisbn"));
  		vo.setBtitle(rs.getString("btitle"));
  		vo.setBauthor(rs.getString("bauthor"));
  		vo.setBprice(rs.getInt("bprice"));
  		vo.setBimgurl(rs.getString("bimgurl"));
  		
  		rs.close();
  		pstmt.close();
  		con.close();
  	} catch(Exception e) {
  		e.printStackTrace();
  	}
  	return vo;
  }
  ```

  * Expand Example과의 차이는 SQL쿼리문과 주어지는 인자가 bisbn이라는 것
  * 받아오는 방식이 BookVO[]에서 BookVO로 변경되었다.
    * rs.next()는 입력해줘야 첫번째 rs로 진입한다.

* 이렇게 3가지 작업을 진행하면 Web Application의 작업은 끝났다.

### Detail Activity

* Layout에서는 보여주고 싶은 ImageView 1개와 TextView가 2개씩 포함될 LinearLayout 4개로 구성했다.

  * TextView에서는 하나는 `ISBN, 제목, 저자, 가격`이라는 항목 명을 다른 하나는 해당 값을 넣을 수 있게 구성했다.

* Activity에서 Thread를 이용해서 MySQL과의 연결과 URL을 통한 Img불러오기 작업을 진행하고  Handler를 통하여 Activity로 전달하여 값을 부여한다.

* Thread의 기본구성은 Expand Example에서 진행했던 구성과 흡사하다.

  * 하지만 값을 받아올 때, BookVO[]로 진행했던 것을 하나만 받아오기 때문에 BookVO로 변경하였다.

    ```java
    BookVO result = mapper.readValue(responseTxt.toString(), BookVO.class);
    ```

    * 이에 putSerializable에서 에러가 발생하는데, 이를 방지하기 위해 Expand Example에서 생성한 BookVO Class에 Serializable Interface를 상속하였다.

      ```java
      @SuppressWarnings("serial")
      class BookVO implements Serializable {
          ...
      }
      ```

  * BookVO로 값을 받아오면 URL을 통한 Img처리 또한 Thread에서 진행해야 한다.

    * 우선 해당 ImgURL을 통해서 Web과 연결하고 InputStream을 통해 값을 가져온다.

      ```java
      String bimgurl = result.getBimgurl();
      
      URL imgurl = new URL(bimgurl);
      HttpURLConnection conn = (HttpURLConnection)imgurl.openConnection();
      conn.setDoInput(true);
      conn.connect();
      
      InputStream is = conn.getInputStream();
      ```

    * 가져온 값을 BitmapFactory의 decodeStream을 통해 Bitmap으로 변경한다.

      ```java
      Bitmap bitmap = BitmapFactory.decodeStream(is);
      ```

    * Bitmap은 Bundle로 넘길수 없기에 ByteArray로 변경후에 넘겨야 한다.

      ```java
      ByteArrayOutputStream bs = new ByteArrayOutputStream();
      bitmap.compress(Bitmap.CompressFormat.PNG, 50, bs);
      ```

    * 이제 BookVO값과 ByteArray 두개를 Bundle과 Message를 사용하여 Activity로 넘겨준다.

      ```java
      Bundle bundle = new Bundle();
      bundle.putSerializable("BookDetail", result);
      bundle.putByteArray("Bitmap", bs.toByteArray());
      
      Message msg = new Message();
      msg.setData(bundle);
      
      handler.sendMessage(msg);
      ```

* 이제 Activity에서 handleMessage를 통해 Message를 받아오고 Bundle의 값을 이용해 UI들의 값을 변경한다.

  * 받아온 Message에서 Bundle을 가져오고 Bundle에 포함된 값들을 가져온다.

    ```java
    Bundle bundle = msg.getData();
    
    BookVO vo = (BookVO)bundle.getSerializable("BookDetail");
    byte[] img = bundle.getByteArray("Bitmap");
    ```

  * ByteArray로 가져온 Img는 다시 Bitmap형식으로 변경해야한다.

    ```java
    Bitmap b = BitmapFactory.decodeByteArray(img, 0, img.length);
    ```

  * 이제 UI들을 선언하고 해당 UI들의 값을 변경한다.

    ```java
    ImageView iv = findViewById(R.id.detailBookIV);
    
    iv.setImageBitmap(b);
    
    TextView isbnTV = findViewById(R.id.detailBookISBN);
    TextView titleTV = findViewById(R.id.detailBookTitle);
    TextView authorTV = findViewById(R.id.detailBookAuthor);
    TextView priceTV = findViewById(R.id.detailBookPrice);
    
    isbnTV.setText(vo.getBisbn());
    titleTV.setText(vo.getBtitle());
    authorTV.setText(vo.getBauthor());
    priceTV.setText(String.valueOf(vo.getBprice()));
    ```

    * Bitmap이미지이기 때문에 ImageView에서 `setImageBitmap()`을 사용했다.
    * price가 int값이기 때문에 `String.valueOf()`를 사용하여 String으로 변경해줘야 한다.

* Handler도 선언이 끝났으니 이제 외부 Thread를 구동하면 된다.

  * onCreate() Method내에서 Thread를 생성하고 시작한다

    ```java
    MyBookDetailRunnable runnable = new MyBookDetailRunnable(handler, bisbn);
    Thread t = new Thread(runnable);
    t.start();
    ```

* [Example 14 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example14_detail_book_search.xml), [Example 14 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example14_DetailBookSearchActivity.java)