# Activity

## Manifest

* manifests 폴더에 AndroidManifest.xml을 살펴보면 activity가 하나있다.
  * name을 살펴보면 MainActivity라 나와있다.
  * 이는 MainActivitiy Class를 의미한다.
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

* activity_main.xml을 살펴본다.
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

#### View & ViewGroup

##### View

* View는 통상적으로 눈에 보이는 Component
  * Button, TextView(lable), ImageView(그림), etc
* TextView
  * `android:layout_width="wrap_parent"`
    * wrap_parent는 Content영역에 해당하는 부분을 의미한다.

##### ViewGroup

* ViewGroup은 View의 크기와 위치를 조절해서 설정해주는 것
  * Layout
* Layout
  * `android:layout_width="match_parent"`
    * parent는 Activity를 의미한다.
    * 이는 Activity의 가로길이만큼 Layout의 가로길이를 지정한다는 것이다.

### Mipmap

> Launcher Icon과 같은 이미지 자원을 저장하는 위치

* 일반적으로 Launcher Icon이 들어간다.

### Values

> 문자열이나 컬러와 같은 다양한 자원에 대한 정보를 저장하는 위치

* 훨씬 쉽게 문자열, 이미지, 컬러와 같은 자원을 특정 name을 통해 사용할 수 있도록 한다.
  * 유지보수가 더욱 용이해진다.
* Color.xml에 다음의 코드하나를 `<resources>`내부에 추가한다.
  * `<color name="colorRed">#ff0000</color>`