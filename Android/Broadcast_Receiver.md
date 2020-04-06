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