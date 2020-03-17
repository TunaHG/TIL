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

## XML

> res 폴더 내의 4가지 폴더에 대해 먼저 설명한다.

* res폴더 내의 4가지 폴더에 들어가는 xml파일들의 이름은 무조건 소문자가 되어야 한다.

### Drawable

> Application 내에서 사용하는 그림 파일을 저장하는 위치

* XML파일이 보이겠지만 더블클릭해서 열어보면 이미지가 보인다.

### Layout

> Activity에서 사용할 화면구성을 위한 XML파일을 저장하는 위치

### Mipmap

> Launcher Icon과 같은 이미지 자원을 저장하는 위치

* 일반적으로 Launcher Icon이 들어간다.

### Values

> 문자열이나 컬러와 같은 다양한 자원에 대한 정보를 저장하는 위치

* 훨씬 쉽게 문자열, 이미지, 컬러와 같은 자원을 특정 name을 통해 사용할 수 있도록 한다.
  * 유지보수가 더욱 용이해진다.