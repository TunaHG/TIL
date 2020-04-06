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
  * [Example 19 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example19_broadcast_receiver.xml)

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

  * [Example 19 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example19_BroadcastReceiverActivity.java)

## SMS Example

> 문자메시지(SMS)를 수신했을 때 해당 메시지의 정보를 출력하는 Example

* 새로운 Activity의 Layout구성은 다음과 같다.

  * Vertical LinearLayout으로 구성
  * TextView 세 개로 구성
    * 송신자를 표시할 TextView
    * 메시지 내용을 표시할 TextView
    * 일자를 표시할 TextView
  * [Example 20 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example20_br_sms.xml)

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

* Broadcast Receiver에서 Activity로 데이터를 전달하는 기능을 구성한다.

  * 전달받은 Intent안에 포함되어 있는 정보를 Bundle로 추출

    ```java
    Bundle bundle = intent.getExtras();
    ```

  * Object배열로 Bundle에서 값을 가져옴

    ```java
    Object[] obj = (Object[])bundle.get("pdus");
    ```

    * Bundle안에 SMS의 정보는 `"pdus"`라는 키값으로 저장되어 있음
    * 시간당 동시에 여러 개의 SMS가 도착할 수 있으므로 배열로 처리

  * SMS 정보를 제대로 사용하기 위해 SmsMessage객체로 변경

    ```java
    SmsMessage[] message = new SmsMessage[obj.length];
    ```

  * 마쉬멜로우 버전 이상이면,

    ```java
    if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        String format = bundle.getString("format");
        message[0] = SmsMessage.createFromPdu((byte[])obj[0], format);
    }
    ```

    * bundle에서 `"format"`이라는 키값을 가진 String을 추출
    * Object 객체로 가져온 SMS 정보를 `SmsMessage.createFromPdu()`를 사용하여 변환

  * 마쉬멜로우 버전 미만이라면,

    ```java
    else {
        message[0] = SmsMessage.createFromPdu((byte[])obj[0]);
    }
    ```

    * format을 사용할 필요없이 바로 변환

  * SmsMessage객체에서 원하는 정보를 추출

    ```java
    // 보낸사람 전화번호를 SmsMessage객체에서 추출
    String sender = message[0].getOriginatingAddress();
    // SMS 문자내용 추출
    String msg = message[0].getMessageBody();
    // SMS 받은 시간 추출
    String reDate = new Date(message[0].getTimestampMillis()).toString();
    ```

  * Intent를 활용하여 Activity에 데이터 전달

    ```java
    Intent i = new Intent(context,
            Example20_BRSMSActivity.class);
    ```

    * 기존에 이미 생성되어 있는 Activity에 전달해야 하므로 Flag 설정

      ```java
      i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
      i.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
      i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      ```

    * intent에 데이터를 저장해서 전달

      ```java
      i.putExtra("sender", sender);
      i.putExtra("msg", msg);
      i.putExtra("reDate", reDate);
      ```

    * startActivity

      ```java
      context.startActivity(i);
      ```

      * Activity로 전달해야 하기 때문에 context를 사용한다.
      * 이는 `onReceive()`에서 주어지는 인자다.

  * [Example 20 Sub Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example20Sub_SMSBroadcastReceiver.java)

* Broadcast Receiver에서 전달한 데이터를 Activity에서 화면에 출력한다.

  * TextView객체를 선언한다.

    ```java
    private TextView smsSenderTV;
    private TextView smsMessageTV;
    private TextView smsDateTV;
    
        
    smsSenderTV = findViewById(R.id.smsSenderTV);
    smsMessageTV = findViewById(R.id.smsMessageTV);
    smsDateTV = findViewById(R.id.smsDateTV);
    ```

  * 새로운 intent를 받아오는 `onNewIntent()`를 사용

    ```java
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        // Broadcast Receiver가 전달한 Intent를 받음
        // Intent안에 들어있는 정보를 화면에 출력
        Bundle bundle = intent.getExtras();
    
        smsSenderTV.setText(bundle.getString("sender"));
        smsMessageTV.setText(bundle.getString("msg"));
        smsDateTV.setText(bundle.getString("reDate"));
    }
    ```

* [Example 20 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example20_BRSMSActivity.java)

## Notification Example

> 알림메시지로 출력하는 Example

* 새로운 Layout의 구성은 다음과 같다

  * Vertical LinearLayout으로 구성
  * Button 세 개로 구성
    * Broadcast Receiver를 등록하는 Button
    * Broadcast Receiver 등록을 해제하는 Button
    * Broadcast를 발생시키는 Button
  * [Example 21 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example21_br_noti.xml)

* Broadcast Receiver를 등록하는 Button의 Click Event처리

  * Broadcast Receiver를 생성하는 작업은 Incode작업으로 진행한다.

  ```java
  Button registerNotiBtn = findViewById(R.id.registerNotiBtn);
  
  registerNotiBtn.setOnClickListener(new View.OnClickListener() {
      @Override
      public void onClick(View v) {
          
      }
  });
  ```

  * IntentFilter를 먼저 생성한다.

    ```java
    IntentFilter filter = new IntentFilter();
    ```

    * Action을 설정한다.

      ```java
      filter.addAction("MY_NOTI_SIGNAL");
      ```

  * Broadcast를 받는 Receiver를 생성한다.

    * 해당 객체를 전역변수로 먼저 선언한다.

      ```java
      private BroadcastReceiver br;
      ```

    ```java
    br = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
    
        }
    };
    ```

  * Receiver에 Notification을 띄우는 작업을 진행한다.

    1. Notification을 띄우려면  Notification Manager가 필요하다.

       * Android System에서 이미 가지고 있는 Manager를 가져온다.

       ```java
       NotificationManager nManager = (NotificationManager)context.getSystemService(context.NOTIFICATION_SERVICE);
       ```

    2. Android Version Oreo(8)를 기준으로 코드의 차이가 발생

       * Oreo 이후에는 Channel을 사용한다.

       * Channel을 사용할 때 필요한 ID, Name, Importance 세개를 먼저 생성한다.

         ```java
         String channelID = "MY_CHANNEL";
         String channelName = "MY_CHANNEL_NAME";
         int importance = NotificationManager.IMPORTANCE_HIGH;
         ```

       * 사용하는 버전이 Oreo이후의 버전이라면,

         ```java
         if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
         
         }
         ```

         * Channel을 생성한다.

           ```java
           NotificationChannel nChannel =
                   new NotificationChannel(channelID, channelName, importance);
           ```

         * Channel을 생성한 후 설정을 추가한다.

           ```java
           nChannel.enableVibration(true);
           ```

           * 진동기능을 추가

           ```java
           nChannel.setVibrationPattern(new long[]{100, 200, 100, 200});
           ```

           * 진동이 어떻게 울리는지 패턴을 설정

           ```java
           nChannel.enableLights(true);
           ```

           * 불빛을 표시하는 기능을 추가

           ```java
           nChannel.setLockscreenVisibility(Notification.VISIBILITY_PRIVATE);
           ```

           * 잠금화면일 때 표시하는 기능 추가

         * Manager에 Channel을 부착한다.

           ```java
           nManager.createNotificationChannel(nChannel);
           ```

    3. Builder를 이용해서 Notification 생성

       ```java
       NotificationCompat.Builder builder =
               new NotificationCompat.Builder(
                       context.getApplicationContext(), channelID
               );
       ```

    4. Intent를 사용하여 Notification 전달

       * Intent 객체를 생성할 때 어떤 Activity에 Notification이 표시될 것인지 명시해야함

         ```java
         Intent nIntent = new Intent(getApplicationContext(),
                 Example21_BRNotiActivity.class);
         ```

       * Notification이 Activity위에 표시되야 하기 때문에 설정 추가

         ```java
         nIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
         nIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
         ```

       * 중복되지 않는 상수값 추출 (requestID가 중복되지 않아야 한다.)

         ```java
         int requestID = (int)System.currentTimeMillis();
         ```

       * 생성한 Intent를 이용한 PendingIntent 생성

         ```java
         PendingIntent pIntent =
                 PendingIntent.getActivity(getApplicationContext(),
                         requestID, nIntent, PendingIntent.FLAG_UPDATE_CURRENT);
         ```

       * builder를 이용해서 최종적으로 Notification 생성

         ```java
         builder.setContentTitle("Noti Title");
         builder.setContentText("Noti Text");
         ```

         * 알림의 기본사운드, 기본진동 설정

           ```java
           builder.setDefaults(Notification.DEFAULT_ALL);
           ```

         * 알림 터치시 반응 후 삭제

           ```java
           builder.setAutoCancel(true);
           ```

         * 알림의 사운드 설정

           * 기본사운드로 설정했으나 다른 사운드로 변경하고자 할때 사용

           ```java
           builder.setSound(RingtoneManager.getDefaultUri(
                   RingtoneManager.TYPE_NOTIFICATION
           ));
           ```

           * RingtoneManager를 활용하여 알림의 기본음으로 설정
           * TYPE_NOTIFICATION을 변경하면 사운드 변경

         * 작은아이콘으로 변경

           ```java
           builder.setSmallIcon(android.R.drawable.btn_star);
           ```

         * builder에 PendingIntent를 부착

           ```java
           builder.setContentIntent(pIntent);
           ```

       * 최종적으로 Notification을 띄운다.

         ```java
         nManager.notify(0, builder.build());
         ```

  * Broadcast를 발생시키는 Button의 Click Event처리

    * Action을 지정한 Intent를 생성

      ```java
      Intent i = new Intent("MY_NOTI_SIGNAL");
      ```

    * Broadcast 발생

      ```java
      sendBroadcast(i);
      ```

  * [Example 21 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example21_BRNotiActivity.java)