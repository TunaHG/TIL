# Security Setting

> 새로운 앱을 시작하면 갤러리 접근권한, 전화걸기 접근권한 등 권한을 허용해달라는 앱들이 있다.
>
> 이런 권한들을 사용, 설정할 수 있는 방법에 대해 알아본다.

* AndroidManifest.xml에 Permission을 추가한다.
* 안드로이드 6.0(마쉬멜로우) 버전 이상에서는 manifest파일에 기술하는거 이외에 사용자에게 권한을 요청하게 되었다.
* 권한 자체는 2가지로 분류된다.
  * 일반 권한(Normal Permission)
  * 위험 권한(Dangerous Permission)
    * 개인정보에 해당하는 정보들에 접근하는 권한을 의미한다.
    * 위치, 전화걸기, 카메라, 마이크, 문자, 일정, 주소록, 센서 등
* 특정 앱을 사용할 때, 앱이 사용자에게 권한을 요구하고 사용자가 권한을 허용하면 그 기능을 이용할 수 있다.
  * 한번 허용한 권한은 앱이 계속 사용할 수 있다.
  * 허용한 권한을 해제하기 위해서는 **설정 > 애플리케이션 > 특정 앱 > 권한**으로 진입하여 해제할 수 있다.

## Call

> 전화 걸기 기능에 대해 알아본다.

* Button을 누르면 전화를 걸어본다.

* 먼저 mainfest에서 permission을 추가해야한다.

  * 전화걸기에 대한 permisson은 CALL_PHONE이다.

  ```xml
  <uses-permission android:name="android.permission.CALL_PHONE"/>
  ```

  * 해당 태그의 위치는 `<manifest>`태그 내부, `<application>`태그 외부이다.

* Button의 Event처리를 진행해본다.

  ```java
  Button callBtn = findViewById(R.id.callBtn);
  callBtn.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
  
      }
  });
  ```

  * 사용자의 안드로이드 버전이 "M" 버전 이상인지 확인한다. ("M"은 6.0 마쉬멜로우를 의미한다.)

    ```java
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M){
        // 사용자의 Android Version이 6.0 이상인 경우
    } else {
        // 사용자의 Android Version이 6.0 미만인 경우
    }
    ```

  * Version이 6.0미만인 경우는 Implicit Intent를 바로 사용하면 된다.

    ```java
    Intent i = new Intent();
    i.setAction(Intent.ACTION_CALL);
    i.setData(Uri.parse("tel:{phoneNumber}"));
    startActivity(i);
    ```

  * Version이 6.0 이상인 경우에 대해 알아본다.

    * 전화 걸기 권한이 설정되어 있는지 확인해야 한다.

    * 권한을 변수에 할당하여 설정되었는지 체크해본다.

      ```java
      int permissionResult =
              ActivityCompat.checkSelfPermission(getApplicationContext(),
                      Manifest.permission.CALL_PHONE);
      ```

    * 다시 if문으로 분기하여 권한이 있을때와 없을때로 구분한다.

      ```java
      if(permissionResult == PackageManager.PERMISSION_DENIED){
          // 권한이 없는 경우
      } else {
          // 권한이 있는 경우
      }
      ```

      * PackageManager의 PERMISSION_DENIED 혹은 PERMISSION_GRANTED가 거부됬을때, 허용됬을때의 상수값을 가지고 있다.
        * 코드의 Readablity를 위하여 -1 혹은 0같은 상수보단 위의 코드를 이용하는 것이 추천된다.

    * 권한이 있는 경우에는 Implicit Intent를 바로 사용하면 된다.

      ```java
      Intent i = new Intent();
      i.setAction(Intent.ACTION_CALL);
      i.setData(Uri.parse("tel:{phoneNumber}"));
      startActivity(i);
      ```

    * 권한이 없는 경우에 대해 알아본다

      * 권한 설정을 거부한적이 있는지 없는지를 확인한다.

        ```java
        if(shouldShowRequestPermissionRationale(Manifest.permission.CALL_PHONE)){
            // 권한을 거부한 적이 있는 경우
        } else {
            // 권한을 거부한 적이 없는 경우 (처음 접속한 경우)
        }
        ```

        * `shouldShowRequestPermissionRationale()`를 사용하여 체크한다.
        * 해당 Method의 괄호안에는 확인하고자 하는 권한이 들어가야 한다.
        * 해당 Method의 결과값은 boolean으로 true혹은 false가 출력된다.

      * 권한을 거부한 적이 없는 경우 권한을 허용받는 설정창을 띄우게한다.

        ```java
        requestPermissions(new String[]{Manifest.permission.CALL_PHONE}, 1000);
        ```

        * 첫 번째 인자는 String[]이며 전화, 카메라 등 받고자 하는 권한을 한번에 설정창에 띄울 수 있다.
        * 두 번째 인자는 requestCode로 Permission의 결과를 확인하기 위한 방법으로 프로그래머가 임의적으로 설정한다.

      * requestCode를 사용하여 Permission의 결과를 확인한다.

        * `onCreate()` 외부, Activity Class 내에서 다음의 메소드를 Overriding한다.

        * `onRequestPermissionsResult()`, Ctrl + O를 눌러서 검색하면 빠르다.

          ```java
          @Override
          public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
              super.onRequestPermissionsResult(requestCode, permissions, grantResults);
          
          }
          ```

        * 위에서 설정한 requestCode == 1000을 확인한다.

          ```java
          // onCreate() 내에서 수행한 권한요청에 대한 응답인지를 확인
          if(requestCode == 1000){
              
          }
          ```

        * 결과가 인자로 주어지는 grantResults에 담겨있다.

          * int[] 형태이며, 권한을 여러 개 받을 수 있으니 배열형태이다.

        * 권한 요청의 응답개수가 1개 이상이고, 지금 상황에서는 전화걸기 권한 1개만 요청했으므로 배열의 첫번째에 그 결과가 담겨서 도착한다.

          ```java
          if(grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
              Intent i = new Intent();
              i.setAction(Intent.ACTION_CALL);
              i.setData(Uri.parse("tel:{phoneNumber}"));
              startActivity(i);
          }
          ```

          * 권한 허용을 눌렀다면 Implicit Intent를 사용하여 전화를 건다.

      * 권한을 거부한 적이 있는 경우

        * 임의로 App의 권한을 끄거나 권한 요청 화면에서 거절을 클릭했을 경우

        * 경고창을 띄워 정말로 거절할 것인지 물어본다.

        * 경고창을 띄우기 위해 AlertDialog.Builder 객체를 사용한다.

          ```java
          AlertDialog.Builder dialog =
                  new AlertDialog.Builder(getApplicationContext());
          ```

        * Title과 Message를 설정한다.

          ```java
          dialog.setTitle("권한 요청에 대한 Dialog");
          dialog.setMessage("전화걸기 기능 필요");
          ```

        * 네, 아니오 버튼이 클릭되었을 때의 동작을 설정한다.

          ```java
          dialog.setPositiveButton("네",
                  new DialogInterface.OnClickListener() {
                      @Override
                      public void onClick(DialogInterface dialog, int which) {
                          requestPermissions(new String[]{Manifest.permission.CALL_PHONE}, 1000);
                      }
                  });
          dialog.setNegativeButton("아니오",
                  new DialogInterface.OnClickListener() {
                      @Override
                      public void onClick(DialogInterface dialog, int which) {
                          // 할일이 없다
                      }
                  });
          ```

          * '네'를 클릭하면 이전에 진행해봤던 requestPermissions로 권한을 다시 설정

* [Android Manifest XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/AndroidManifest.xml)

* [Example 15 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example15_implicit_intent.xml), [Example 15 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example15_ImplicitIntentActivity.java)

* [Example 15 Sub XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example15_sub_implicit_intent.xml), [Example 15 Sub Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example15Sub_ImplicitIntentActivity.java)