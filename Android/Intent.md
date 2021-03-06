# Intent

> 다른 Activity를 호출하는 두가지 방식에 대해 알아본다.
>
> Explicit방식과 Implicit방식 두 가지가 존재한다.

## Explicit 방식

> 명시적 방식

### Main Activity 구성

> activity_main.xml

* LinearLayout 구성

  ```xml
  <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
      android:layout_width="match_parent"
      android:layout_height="match_parent"
      android:orientation="vertical">
  
  </LinearLayout>
  ```

* TextView와 Button 생성

  ```xml
  <TextView
      android:layout_width="match_parent"
      android:layout_height="wrap_content"
      android:background="@color/colorYellow"
      android:text="Android 예제입니다!"
      android:textAlignment="center"
      android:gravity="center_horizontal"
      android:textSize="10pt"/>
  <Button
      android:layout_width="match_parent"
      android:layout_height="wrap_content"
      android:text="01.LinearLayout 예제"
      android:id="@+id/_01_linearlayoutBtn"/>
  ```

### Event 처리

* New Activity 생성
  * Example01_Layout
    * xml파일 이름에 `_`가 2개 들어가게 된다. 이를 하나 지워준다.

* ID를 부여한 Button의 Event 처리를 진행

  ```
  _01_linearlayoutBtn = findViewById(R.id._01_linearlayoutBtn);
  
  _01_linearlayoutBtn.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
          
      }
  });
  ```

* 다른 Activity를 찾기위한 Intent 객체 생성

  ```java
  Intent i = new Intent();
  ```

* ComponentName 객체 생성

  ```java
  ComponentName cname = new ComponentName("com.example.androidlectureexample",
          "com.example.androidlectureexample.Example01_LayoutActivity");
  ```

  * 첫 번째 인자는 Activity가 포함된 Package의 이름(경로)
  * 두 번째 인자는 호출할 Activity (Package의 경로까지 포함하여)

* Intent에 ComponentName을 `setComponent()`로 전달

  ```java
  i.setComponent(cname);
  ```

* Intent를 사용하여 Activity를 실행

  ```java
  startActivity(i);
  ```

## Implicit 방식

> 묵시적 방식

### Event 처리

* Activity Java파일에서 다른 Activity를 찾기 위한 Intent 객체 생성

  ```java
  Intent i = new Intent();
  ```

* Android Manifest 파일을 수정한다.

  * 새로 만들어진 Example15Sub의 Activity 태그안에 `<intent-filter>`를 추가한다.
  * `<intent-filter>`태그 안에 `<action>`을 지정한다.
    * action에는 User가 임의적으로 정한 name을 지정해줘야한다
    * action은 하나만 나올 수 있다.
  * `<intent-filter>`태그 안에 `<category>`를 지정한다.
    * action과 마찬가지로 name을 지정한다.
      * default라고 입력하면 자동완성으로 android.intent.category.DEFAULT가 생성된다
    * action과 달리 여러 개가 나올 수 있다.
      * 여러 개가 들어오더라도 default는 무조건 있어야한다.

  ```xml
  <activity android:name=".Example15Sub_ImplicitIntentActivity">
      <intent-filter>
          <action android:name="MY_ACTION"/>
          <category android:name="android.intent.category.DEFAULT"/>
          <category android:name="INTENT_TEST"/>
      </intent-filter>
  </activity>
  ```

* Activity Java파일로 돌아온다

  * intent 객체에서 Action을 지정한다.

    ```java
    i.setAction("MY_ACTION");
    ```

  * Intent객체에서 Category를 지정한다.

    ```java
    i.addCategory("INTENT_TEST");
    ```

  * Action과 Category가 둘다 맞게 해당되는 Activity가 존재해야 한다.

  * 제대로 전달되는지 확인하기 위해 데이터도 하나 날려준다.

    ```java
    i.putExtra("Send Data", "Hello!");
    ```

  * Intent를 이용하여 Activity를 시작한다

    ```java
    startActivity(i);
    ```

* Example15 Sub의 Activity Java파일에서 Intent 처리를 한다.

  * `getIntent()`를 통해 Intent 객체를 받아온다.

    ```java
    Intent i = getIntent();
    ```

  * 데이터를 가져왔는지 확인하기 위해 `Toast.makeText()`를 사용해본다.

    ```java
    Toast.makeText(getApplicationContext(),
            i.getExtras().getString("Send Data"), Toast.LENGTH_SHORT).show();
    ```

* 이미 만들어져있는 Action을 사용하는 방법 또한 존재한다

  * 전화걸기 Activity를 호출해본다.

  * 이미 만들어진 Action을 지정한다

    ```java
    i.setAction(Intent.ACTION_DIAL);
    ```

  * 전화를 걸 번호를 Data로 넘겨준다.

    * 이 때, ACTION_DIAL이 받는 양식대로 Data를 넘겨야한다.

      ```java
      i.setData(Uri.parse("tel:01096117555"));
      ```

      * Uri형식으로 받아야하며, String에서도 전화번호를 의미하는 `tel:`이 추가되어 있어야 한다.

  * Activity를 시작해본다.

  * Browser 호출해본다.

  * 역시 이미 만들어진 Action을 지정한다

    ```java
    i.setAction(Intent.ACTION_VIEW);
    ```

    * ACTION_VIEW에서 주의할 점은 Browser가 겹친다는 점이다.
    * 실행시키면 어떤 Browser로 실행시킬지 물어볼수도 있다.

  * Browser에서 띄울 URL을 Data로 넘겨준다.

    ```java
    i.setData(Uri.parse("http://www.naver.com"));
    ```

  * Activity를 시작해본다.
  
* [Example 15 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example15_implicit_intent.xml), [Example 15 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example15_ImplicitIntentActivity.java), [Example 15 Sub Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example15Sub_ImplicitIntentActivity.java)