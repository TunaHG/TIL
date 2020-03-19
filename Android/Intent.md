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
