# Broadcast Receiver

> Broadcast : 일련의 신호

## Test Example

> 실습을 통해 사용방법을 알아본다.

* 새로운 Activity를 만들어서 진행한다.

  * MainActivity에 새로운 Activity로 넘어갈 Button을 생성한다.
  * Button의 OnClick이벤트로 Intent를 사용하여 새로운 Activity로 넘어가도록 만든다.

* 새로운 Activity의 Layout구성은 다음과 같다.

  * Vertical LinearLayout으로 구성되어 있다.
  * Vertical LinearLayout내에 Horizontal LinearLayout을 구성한다.
  * Horizontal LinearLayout내에 Button을 하나 생성한다.
    * 해당 Button은 Broadcast Receiver를 등록하는 Register Button이다.
  * 같은 위치에 Button을 하나 더 생성한다.
    * 해당 Button은 Broadcast Receiver의 등록을 해제하는 Unregister Button이다.
  * Horizontal 외부에, Vertical내부에 Button을 하나 생성한다.
    * 해당 Button은 Broadcast를 발생시키는 Button이다.
  * [Example 19 XML]

* Android에서는 Broadcast라는 Signal이 존재한다.

  * 이 Signal은 Android System 자체에서 발생하거나, 사용자 App에서 임의로 발생시킬 수 있다.
  * 일반적으로 정해져있는 Broadcast Message를 받기 위해서 Broadcast Receiver를 등록해야한다.
  * 등록하려면 크게 다음의 2가지 방식을 사용한다.
    1. AndroidManifest.xml File에 명시
    2. 코드상에서 Receiver를 만들어서 등록
  * 이 Example에서는 2번째 방법을 사용해본다.

* 새로운 Activity의 Java파일을 구성한다.

  * Broadcast Receiver를 등록하는 Button의 Event처리를 진행한다.

    ```java
    Button registerBtn = findViewById(R.id.registerBtn);
    registerBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            
        }
    });
    ```

    * Broadcast Receiver 객체를 만들어서 IntentFilter와 함께 System에 등록

    1. IntentFilter 생성

       ``` java
       IntentFilter intentFilter = new IntentFilter();
       intentFilter.addAction("MY_BROADCAST_SIGNAL");
       ```

    2. Broadcast Receiver 객체 생성

       * onCreate()내에 구성하면 해제할때 문제가 발생하니 전역변수로 선언한다.

         ```java
         private BroadcastReceiver bReceiver;
         ```

       ```java
       bReceiver = new BroadcastReceiver() {
           @Override
           public void onReceive(Context context, Intent intent) {
               
           }
       };
       ```

       * `new BroadcastReceiver()`를 진행할 때 자동으로 Overriding이 된다.

       * Receiver가 신호를 받게되면 `onReceive()`가 호출되며 해당 Method에서 로직처리를 진행

       * 받은 신호가 위에서 설정한 `"MY_BROADCAST_SIGNAL"`이라면 Tosat의 Message를 출력한다.

         ```java
         if(intent.getAction().equals("MY_BROADCAST_SIGNAL")) {
             Toast.makeText(getApplicationContext(),
                     "Receive Signal", Toast.LENGTH_SHORT).show();
         }
         ```

    3. Filter와 함께 Broadcast Receiver를 등록

       ```java
       registerReceiver(bReceiver, intentFilter);
       ```

  * 등록을 해제하는 Button의 Click Event를 처리한다.

    ```java
    Button unRegisterBtn = findViewById(R.id.unRegisterBtn);
    unRegisterBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            unregisterReceiver(bReceiver);
        }
    });
    ```

  * 임의의 Broadcast를 발생시키는 Button의 Click Event를 처리한다.

    ```java
    Button sendBroadcastBtn = findViewById(R.id.sendBroadcastBtn);
    sendBroadcastBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            
        }
    });
    ```

    * Intent를 이용한다.

      ```java
      Intent i = new Intent("MY_BROADCAST_SIGNAL");
      sendBroadcast(i);
      ```

      * `"MY_BROADCAST_SIGNAL"`이라는 Action을 가진 Intent를 생성
      * Intent를 활용하여 Broadcast를 발생

  * [Example 19 Java]

## SMS Example

> 문자메시지(SMS)를 수신했을 때 해당 메시지의 정보를 출력하는 Example

* 새로운 Activity의 Layout구성은 다음과 같다.

  * Vertical LinearLayout으로 구성
  * TextView 세 개로 구성
    * 송신자를 표시할 TextView
    * 메시지 내용을 표시할 TextView
    * 일자를 표시할 TextView
  * [Example 20 Layout]

* 문자메시지 처리는 상당히 개인적인 정보이므로 보안처리가 필요하다.

  * AndroidManifest.xml 파일에 기본 보안에 대한 설정이 필요하다.

    ```xml
    <uses-permission android:name="android.permission.RECEIVE_SMS" />
    ```

    * `<manifest` 내부, `<application` 외부에 작성한다.

  * Android가 마쉬멜로우(6) 이후의 버전이라면 강화된 보안정책을 따라야 한다.

    * 코드가 복잡하기 때문에 설명 후 하나의 코드로 한번에 표시한다.

  * 사용자의 Android Version이 마쉬멜로우 이후의 버전인지 Check한다.

  * 마쉬멜로우 이후의 버전이라면,

    * 사용자 권한 중 SMS 받기 권한이 설정되어 있는지 Check한다.
    * 권한이 없으면,
      * 앱을 처음실행한 경우와 이전에 거절했던 경우로 나뉜다.
      * 권한을 거부한적이 있다면,
        * 일반적으로 dialog같은걸 사용해서 다시 요청
      * 권한을 거부한적이 없다면,
        * `requestPermission`을 사용하여 권한 요청
    * 권한이 있으면,
      * 다른 동작이 필요없다.

  * 마쉬멜로우 이전의 버전이라면,

    * 이전의 버전에서는 Manifest파일을 수정하는 것만으로도 가능했으니 다른 동작이 필요없다.

  * 위의 과정을 따른 보안처리 Code는 다음과 같다.

    ```java
    // 1. 사용자의 단말기 OS(Android Version)가 마쉬멜로우(6) 이후의 버전인지 check
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        // 사용하는 기기의 버전이 M 이상이면
        // 사용자 권한 중 SMS 받기 권한이 설정되어 있는지 Check
        int permissionResult = ActivityCompat.checkSelfPermission(getApplicationContext(),
                Manifest.permission.RECEIVE_SMS);
        if(permissionResult == PackageManager.PERMISSION_DENIED) {
            // 권한이 없으면
            // 1. App을 처음 실행해서 물어본적이 없는 경우
            // 2. 권한 허용에 대해서 사용자에게 물어봤지만 사용자가 거절한 경우
            if(shouldShowRequestPermissionRationale(
                    Manifest.permission.RECEIVE_SMS)) {
                // true => 권한을 거부한적이 있는 경우
                // 일반적으로 dialog같은걸 이용해서 다시 요청
                AlertDialog.Builder dialog = new AlertDialog.Builder(Example20_BRSMSActivity.this);
                dialog.setTitle("Need Permission");
                dialog.setMessage("Need Receive SMS Permssion, Grant?");
                dialog.setPositiveButton("YES", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        requestPermissions(new String[]{Manifest.permission.RECEIVE_SMS}, 100);
                    }
                });
                dialog.setNegativeButton("NO", new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // 권한설정을 하지 않는다는 의미이므로
                        // 아무런 작업도 할 필요없음
                    }
                });
            } else {
                // false => 한번도 물어본적이 없는 경우
                requestPermissions(new String[]{Manifest.permission.RECEIVE_SMS}, 100);
            }
        } else {
            // 권한이 있으면
            Log.i("SMSTest", "보안설정 통과");
        }
    } else {
        // 사용하는 기기의 버전이 M 미만이면
        Log.i("SMSTest", "보안설정 통과");
    }
    ```

  * 추가로, 권한설정이후의 Callback Method를 설정한다.

    ```java
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        // 사용자가 권한을 설정하게 되면 이 부분이 마지막으로 호출됨
        // 사용자가 권한설정을 하거나 그렇지 않은 두가지 경우 모두 이 Callback Method가 호출
        if(requestCode == 100) {
            if(grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                // 사용자가 권한 허용을 눌렀을 경우
                Log.i("SMSTest", "보안설정 통과");
            }
        }
    }
    ```

* AndroidManifest.xml을 사용하여 Broadcast Receiver를 등록해본다.

  * New > Other > Broadcast Receiver 생성

  * AndroidManifest.xml File의 `<application`태그 내에 `<receiver` 태그 생긴것 확인

    ```xml
    <receiver
        android:name=".Example20Sub_SMSBroadcastReceiver"
        android:enabled="true"
        android:exported="true">
    </receiver>
    ```

  * `<receiver`태그 내에 `<intent-filter`생성

    ```xml
    <receiver
        android:name=".Example20Sub_SMSBroadcastReceiver"
        android:enabled="true"
        android:exported="true">
        <intent-filter>
            
        </intent-filter>
    </receiver>
    ```

  * `<intent-filter`내에 `<action` 생성

    ```xml
    <receiver
        android:name=".Example20Sub_SMSBroadcastReceiver"
        android:enabled="true"
        android:exported="true">
        <intent-filter>
            <action android:name="android.provider.Telephony.SMS_RECEIVED"/>
        </intent-filter>
    </receiver>
    ```

  * 이제 이 Broadcast Receiver가 SMS문자가 오면 이를 수신한다.

* 