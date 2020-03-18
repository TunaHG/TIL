# Activity

> App을 구성하고 있는 화면을 지칭

## New Activity

* 새로운 Activity를 만들고 싶다면 New - Activity - Empty Activity를 선택한다.

  * Generate Layout File을 통해 layout파일을 자동으로 생성한다.
  * Launcher Activity를 체크하면 해당 Activity가 앱을 시작 Activity가 된다.

* 새로운 Activity에서 생성된 layout과 연결이 되지 않고 에러가 발생되어 있을 수 있다.

  * File - Invalidate Caches / Restart를 진행하여 다시 Build하면 연결이 되어있는 상태로 된다.

* 새로운 Activity를 생성 후 Manifest 파일을 살펴보면 다음의 코드가 추가되어 있다.

  ```xml
  <activity android:name=".WidgetActivity"></activity>
  ```

## Manifest

* manifests 폴더에 AndroidManifest.xml을 살펴보면 activity가 하나있다.
  * name을 살펴보면 MainActivity라 나와있다.
  * 이는 MainActivitiy Class를 의미한다.
  * 내부의 태그들은 앱이 시작될 때 먼저 실행되는 Activity라는 것을 의미한다.
* manifest.xml는 앱의 전체 설정을 잡는 파일이다.

## Class

* MainActivity Class를 살펴본다.
  * AppCompatActivity를 상속받는다. 이는 Activity로 구현하기 위해 상속받는 Class이다.
  * Servlet과 마찬가지로 main() 메소드가 존재하지 않는다.
  * onCreate() 메소드는 상위 Class의 메소드를 Overriding한 것이다.
    * Class의 instance가 생성될 때 시스템에 의해서 호출되는 메소드이다. (Callback 메소드)

* Activity의 화면을 구성하는 방식은 2가지
  1. Java Code
     * Java Code로 Widget Component를 생성해서 화면에 붙이는 방식
  2. XML
     * XML 파일을 이용해서 화면구성을 xml을 이용해서 처리하는 방식
     * 표현(화면구성 - UI)과 구현(로직처리)을 분리
     * 유지측면에서 유리
* `setContentView()`를 살펴본다.
  * R은 R.java로 Android에 의해서 자동으로 생성되는 Class이다.
    * res의 layout폴더에 새로운 리소스를 등록하면 해당 리소스에 대한 링크를 상수로 바꿔준다.
  * 하위의 `layout`과 `activity_main`이 static으로 잡혀있다.
  * `layout.activity_main`의 결과값은 int를 반환한다.

### Logcat

> log를 찍어서 현재 Android의 상태를 확인할 수 있다.

* IDE의 아래의 Tab들을 살펴보면 Logcat이 존재한다.
  * 눌러보면 현재 실행중인 AVD가 있을경우 해당 AVD에 해당하는 log들이 출력된다.
* `Log.i();`
  * android.util.Log를 import 해야한다. 
    * Alt + Enter 단축키를 사용하여 자동 import한다.
  * 두가지 argument를 준다. `("MYTEST", "이것은 소리없는 아우성")`
    * 각 Argument 앞에 tag, msg로 표시되는 것들은 입력하는 것이 아닌 IDE에서 보여주는 것이다.
* `Log.i()`를 Class 내에 입력한 후 AVD에서 앱을 실행해보면 Logcat부분에 입력한 msg가 Log로 출력되는 것을 확인할 수 있다.

## XML

> res 폴더 내의 4가지 폴더에 대해 먼저 설명한다.

* res폴더 내의 4가지 폴더에 들어가는 xml파일들의 이름은 무조건 소문자가 되어야 한다.

### Drawable

> Application 내에서 사용하는 그림 파일을 저장하는 위치

* XML파일이 보이겠지만 더블클릭해서 열어보면 이미지가 보인다.

### Layout

> Activity에서 사용할 화면구성을 위한 XML파일을 저장하는 위치

* XML에 여러 가지 Widget을 넣어서 사용자 Component를 표현한다.
* LayoutManager
  * Widget을 내가 원하는 크기로 원하는 위치에 표현하기 위해서 Widget을 관리하는 Component
  * LinearLayout, GridLayout, ...

#### activity_main.xml

* 좌측의 Button 등을 드래그하여 우측의 화면 내에 넣으면 인자를 추가할 수 있다.
* 하지만 익숙해진 이후에 드래그하여 사용하고, 현재는 xml파일을 이용하여 구성한다.
  * 디자인 Tab에서 Xml탭으로 넘어가는 버튼은 IDE 우측상단에서 조금 아래를 보면 버튼 세개가 존재한다.
  * 정렬처럼, Text처럼 생긴 아이콘은 Code로 XML파일만을 보여준다.
  * Text와 이미지가 합쳐진 것처럼 생긴 아이콘은 Split으로 XML파일과 Android화면을 같이 보여준다.
  * 이미지처럼 보이는 아이콘은 Design으로 기본으로 설정되어 있는 각 요소들과 Android화면을 보여준다.
* Code아이콘을 클릭하여 XML파일을 살펴본다.
  * `<androidx.~~.ConstraintLayout`으로 Layout이 하나 지정되어 있다.
  * `<TextView>`로 텍스트를 출력하는 태그가 하나 선언되어 있다.
    * 다음 Attribute를 추가해서 확인해본다.
    * `android:textSize="10pt"`
    * `android:background="@color/colorRed"`
    * AVD에서 앱을 다시 실행시켜보면 Hello World!로 출력되는 Text가 변경된 것을 확인할 수 있다.

#### LinearLayout

* LinearLayout은 왼쪽에서 오른쪽, 위에서 아래로 Layout을 붙여나가는 방식 (Waterfall)

* activity_main.xml에서 `<?xml version` 라인을 제외한 나머지를 전부 삭제 후 직접 구성해본다.
* LinearLayout 태그를 생성하면 layout_height, layout_width가 필요하다는 경고표시가 나온다.
* layout_height를 생성하면 `xmlns:android=`와 같은 Attribute가 추가된다.
  * layout_height 앞의 android:를 사용할 수 있게 해주는 태그이며 자동생성되므로 신경쓰지 않아도 된다.
* orientation은 default값이 horizontal이다.
  * Widget의 위치를 지정하지 않으면 왼쪽에서 오른쪽으로 계속 붙는다.
  * 위에서 아래로 붙이고 싶다면 vertical으로 변경한다.
* layout_weight를 지정하여 크기를 변경할 수 있다.
  * orientation이 vertical이므로 위 아래를 의미하는 layout_height가 무시되고 weight가 지정된 것만큼 크기가 변경된다.

#### View & ViewGroup

##### View

* View는 통상적으로 눈에 보이는 Component
  * Button, TextView(lable), ImageView(그림), etc
* TextView
  * `android:layout_width="wrap_parent"`
    * wrap_parent는 Content영역에 해당하는 부분을 의미한다.
    * 숫자가 올 수 있지만 기기에 따라 해상도가 다르기 때문에 상대적 크기로 지정해주는 것이 좋다.
  * `android:text` : 해당 TextView가 출력할 text를 의미한다.
  * `android:textAlignment` : Layout내에서 정렬을 진행한다.
    * 경고가 표시되며 `android:gravity`를 추가해야 정상작동한다고 나온다.
    * `android:gravity`가 `center_horizontal`로 자동생성할 수 있다.
      * 이를 `center_vertical`로 수정하면 RtlCompat가 필요하다고 나오니 자동생성한다.

##### ViewGroup

* ViewGroup은 View의 크기와 위치를 조절해서 설정해주는 것
  * Layout
* Layout
  * `android:layout_width="match_parent"`
    * parent는 Activity를 의미한다.
    * 이는 Activity의 가로길이만큼 Layout의 가로길이를 지정한다는 것이다.

#### Event

> 사용자 혹은 시스템에 의해서 발생되는 모든 것

* Event Handling

  * Event Delegation Model을 이용하여 Event를 처리

* Event 처리 객체

  * Event Source : Event가 발생한 객체
    * Button을 클릭하면 Button 자체를 의미함.
  * Event Handler(Listener) : Event를 처리하는 객체
  * Event : 발생된 Event에 대한 세부정보를 가지고 있는 객체
    * 현재 클릭된 Button의 X, Y좌표 / RMB or LMB or Shift + MB인지 등의 세부정보
    * 자동적으로 생성되며, 자동으로 Handler에게 주어짐
  * Event Source에 Event Handler를 부착시키고 Event가 발생하면 부착된 Handler를 통하여 Event를 처리한다.

* Event Source 객체 가져오기

  * Button에 ID를 부여한다.
    * 값을 `@id`로 주면 id라는 것을 찾으라는 의미이다.
    * 값을 `@+id/{id}`를 사용하여 `{id}`를 id에 추가한다는 의미이다.
  * java파일에서 ID를 부여한 Button 객체를 가져와야 한다.
    * android.widget.Button 객체를 사용한다.
    * `findViewById()`를 사용하여 ID를 이용한 View를 찾는다.
      * 매개변수로는 R.id.{id}를 입력한다.
      * `findViewById()`의 return값은 Object객체이지만 Android Studio에서 자동으로 Casting한다.

* Event Handler 외부 Class 만들기

  * 일반 Class 객체가 아닌 Event를 처리할 수 있는 interface를 상속한 Listener 객체가 필요
    * `View.onClickListener` Interface를 상속받는다.
  * 상속받은 Interface의 추상메소드 onClick을 Overriding한다.
  * Class를 만들었으면 해당 객체를 생성한다.

* Event Source에 Handler 부착하기

  * `setOnClickListener(handlet)`

* TextView의 내용을 변경할 예정이기 때문에 TextView 또한 ID를 생성하고 객체를 생성한다.

  * 생성자를 이용해서 Event Handler에 TextView 객체를 넣어준다.

* `onClick()` 메소드의 내용에서 TextView의 내용을 바꾸는 `setText()`를 사용한다.

* 실제 구현에서는 Handler로 외부 Class를 사용하지 않고 Anonymous Inner Class로 사용한다.

  * Event Handler 객체를 생성하며 Source에 부착하는 과정을 한번에 진행한다.

    ```java
    myBtn.setOnClickListener(new View.OnClickListener(){
        @Override
        public void onClick(View v) {
            // myTV가 Member Variable이기 때문에 Error
            myTV.setText("버튼이 클릭됐다!!!");
        }
    });
    ```

    * myTV에서 Error가 발생할 수 있는데 이는 해당 변수가 onCreate() 등의 특정 메소드 안에서 정의 되었기 때문이다. 이를 전역변수(Class내부, Method외부) 혹은 상수(final 선언)로 변경하면 된다.

### Mipmap

> Launcher Icon과 같은 이미지 자원을 저장하는 위치

* 일반적으로 Launcher Icon이 들어간다.

### Values

> 문자열이나 컬러와 같은 다양한 자원에 대한 정보를 저장하는 위치

* 훨씬 쉽게 문자열, 이미지, 컬러와 같은 자원을 특정 name을 통해 사용할 수 있도록 한다.
  * 유지보수가 더욱 용이해진다.
* Color.xml에 다음의 코드하나를 `<resources>`내부에 추가한다.
  * `<color name="colorRed">#ff0000</color>`

## Life Cycle

> Activity는 사용자에 의해서 Event가 발생되면 상태가 변한다.
>
> 그에 따라 Callback Method가 호출되는데 그 Callback에 대해서 알아둬야 한다.

1. Activity는 Class상태로 존재

2. Activity가 화면에 나타나려면 객체화가 되어야 한다. (instance화)

   * Android System에 의해서 자동적으로 객체화된다.

3. onCreate() 메소드가 Callback된다.

   * 화면구성을 주로 한다.

4. onStart() 메소드가 Callback된다.

   * Activity의 초기화 작업들을 진행한다.
   * onCreate()와 onStart()는 상위 Class인 AppCompatActivity에서 상속받는 Method이다.
     * Alt + Insert에서 나오는 Override를 선택하여 onStart()를 자동생성할 수 있다.
     * 혹은 onstart를 입력하면 자동생성으로 표시되는 상속 Method를 선택한다.

   ```java
   @Override
   protected void onStart() {
       super.onStart();
       Log.i("MYTEST", "onStart() 호출");
   }
   ```

5. Activity가 foreground로 나타나면서 사용자와 interaction이 가능

6. onResume() 메소드가 Callback된다.

   ```java
   @Override
   protected void onResume() {
       super.onResume();
       Log.i("MYTEST", "onResum() 호출");
   }
   ```

7. Activity의 상태가 Running 상태가 된다.

8. Activity의 일부분이 보이지 않는 상태가 될 수 있다. (Pause 상태)

   * 예를 들어, 여러 앱을 살펴보는 기능을 사용한 경우

9. Pause 상태가 되면 onPause() 메소드가 Callback 된다.

   ```java
   @Override
   protected void onPause() {
       super.onPause();
       Log.i("MYTEST", "onPause() 호출");
   }
   ```

10. Activity의 전체가 완전히 가려져서 보이지 않는 상태가 될 수 있다. (Stop 상태)

11. Stop 상태가 되면 onStop() 메소드가 Callback 된다.

    ```java
    @Override
    protected void onStop() {
        super.onStop();
        Log.i("MYTEST", "onStop() 호출");
    }
    ```

12. Stop상태에서 다시 Running 상태가 될 수 있다.

13. onReStart() -> onStart() -> onResume() 순서로 다시 Callback 된다.

    ```java
    @Override
    protected void onRestart() {
        super.onRestart();
        Log.i("MYTEST", "onRestart() 호출");
    }
    ```

14. 사용하고 있는 Activity를 종료하게 되면 Killed 상태가 된다.

15. 진입하기 전에 onDestroy() 메소드가 Callback 된다.

    ```java
    @Override
    protected void onDestroy() {
        super.onDestroy();
        Log.i("MYTEST", "onDestroy() 호출");
    }
    ```