# Service

> 화면이 없는 Activity

* App이 실행되었다고 해서 항상 Activity가 보이는 것은 아님
  * 대표적인 경우 : 카톡, 멜론
  * Activity가 보이지 않아도 기능이 수행되는 경우가 있음
* 눈에 보이지 않기 때문에 Background에서 로직처리하는데 이용

## Life Cycle

* Service와 비교되는 Activity의 Lifecycle은 다음과 같다

  ```
  onCreate() -> onStart() -> onResume() -> onPause() -> onStop() -> onDestroy()
  ```

* Service의 Lifecycle은 다음과 같다.

  ```
  onCreate() -> onStartCommand() -> onDestroy()
  ```

  * Activity보다 짧다.

* 새로운 Activity에서 Service에 관련된 작업을 진행한다.

  * Example 16 Activity를 생성한다.

  * Button 두 개를 구성한다.

    * 하나는 Service를 시작하는 버튼
    * 다른 하나는 Service를 종료하는 버튼

  * Service 시작버튼에 onClick()에는 Intent 객체를 생성하여 Service를 호출한다.

    ```java
    Intent i = new Intent(getApplicationContext(),
            Example16Sub_LifecycleService.class);
    ```

    * Intent에 데이터를 추가한다.

    ```java
    i.putExtra("MSG", "Hello I'm Message!");
    ```

    * Service를 시작한다

      ```java
      startService(i);
      ```

      * Activity를 시작하는 `startActivity()`, Service를 시작하는 `startService()`

* Service를 생해서 작업한다.

  * Java에서 우클릭 > New > Service > Service (Service(IntentService) 가 아님)
    * Exported 체크는 해당 Service를 다른 App에게 제공해주겠다는 의미
    * Enabled 체크는 해당 Service를 사용가능한 형태로 생성할 것이라는 의미
  * 미리 Overriding되어 있는 `IBinder()`는 Bind Service로 지금은 사용하지 않는다.
  * Ctrl + O로 Overriding하는 Method들을 찾아서 추가한다.
    * `onCreate()`, `onStartCommand()`, `onDestroy()`

### onCreate()

> 객체가 생성될 때 호출되는 Method

### onStartCommand()

> 실제 Service 동작을 수행하는 Method
>
> onCreate()가 호출된 이후 바로 호출된다.

* 만약 Service 객체가 존재하고 있으면 `onCreate()` 호출없이 바로 `onStartCommand()`가 호출된다.

* 1초간격으로 1부터 시작해서 10까지 숫자를 Log로 출력해본다.

  * Activity에서 수행했던 것과 같이 Thread를 사용하는데, 이번엔 외부 Class로 선언하지 않는다.

  * Service Class내에 전역변수로 Thread를 선언하며 바로 Runnable, run() Overriding까지 진행한다.

    ```java
    private Thread myThread = new Thread(new Runnable() {
        @Override
        public void run() {
            for(int i = 1; i <= 10; i++){
                try {
                    Thread.sleep(1000); // 1초
                    Log.i("ServiceExam", "현재 숫자는 : " + i);
                } catch (Exception e){
                    Log.i("ServiceExam", e.toString());
                }
            }
        }
    });
    ```

  * Thread를 생성했으면 `onStartCommand()`로 돌아와서 Thread를 `start()`한다.

    ```java
    myThread.start();
    ```

* `onStartCommand()`를 한번 호출하고 Service가 종료되지 않은 상태에서 Service 시작 Button을 한번 더 눌러본다

  * 위에서 `onStartCommand()`가 다시 호출되니 Thread가 다시 동작해서 1부터 10까지 다시 호출해야 될 것 같지만 동작하지 않는다.

    * 이는 Thread가 `run()`을 실행시킨 이후 `run()`이 종료되면 DEAD상태가 되기 때문이다.
    * DEAD상태가 된 Thread를 다시 실행을 시킬 수 있는 방법은 없다.
    * 유일하게 다시 실행시키는 방법은 Thread를 다시 생성해서 실행하는 것이다.

  * 이를 해결하기 위해서 전역변수로 선언한 Thread 객체의 값을 선언함과 동시에 주어지는 것이 아니라 `onStartCommand()`에서 객체의 값을 선언하면 된다.

    ```java
    private Thread myThread;
    
    ...
        
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
    	Log.i("ServiceExam", "Call onStartCommand()");
    	myThread = new Thread(new Runnable() {
    		@Override
    		public void run() {
    			for(int i = 1; i <= 10; i++){
    				try {
    					Thread.sleep(1000); // 1초
    					Log.i("ServiceExam", "현재 숫자는 : " + i);
    				} catch (Exception e){
    					Log.i("ServiceExam", e.toString());
    				}
    			}
    		}
    	});
    	myThread.start();
    	return super.onStartCommand(intent, flags, startId);
    }
    ```

* 그렇다고 Thread를 생성하지 않고 로직Code를 `onStartCommand()`안에 넣으면 해당 로직을 진행하는 동안 Service가 Block되서 Activity UI가 멈추게된다.

* 그렇다면 Activity에서 Thread를 생성해서 처리하면 되는데 **왜 Service를 생성하는가?**

  * 의도치 않은 강제 종료로 앱이 종료되었을 때, Activity는 죽어서 다시 실행시킬 수 없지만 Service는 특정 처리를 진행하면 죽어도 다시 살아나서 실행될 수 있다.

### onDestroy()

> Service 객체가 메모리에서 사라질 때 호출되는 Method

* `stopService()`가 호출되면 해당 Method가 호출된다.

  * stop Button을 누르면 Intent 객체 어떤 Service인지를 생성한다.
  * 이후 `stopService(intent)`를 통하여 Service를 종료하는 `onDestroy()`를 호출한다.

* `stopService()`로 Service를 종료했는데, `onStartCommand()`에서 생성된 Thread는 종료되지 않는다.

  * 이를 종료시키기 위해서 `interrupt()` Method를 사용한다.

    ```java
    myThread.interrupt();
    ```

  * `stop()` Method도 존재하는데 이는 과거에 사용하던 Method로 deprecated되었으니 이젠 사용하지 않는다.

    * 사용하지 말라고 경고표시도 나오고, Method자체에 취소선도 그어져있다.

  * 여기서 문제는 Thread가 실행중 sleep상태로 들어가는데 interrupt가 걸려있으면 Exception이 발생한다.

    * 그래서 catch문으로 진입하여 에러코드를 추출하고 다음 반복문이 실행된다.
    * 이를 방지하기 위하여 catch문 내부 구현부에 `break;`를 추가하여 Exception이 발생하면 반복문이 종료하도록 만들어야한다.

* [Example 16 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example16_service_lifecycle.xml), [Example 16 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example16_ServiceLifecycleActivity.java)
* [Example 16 Sub Service](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example16Sub_LifecycleService.java)

## Data Transfer

* 새로운 Activity를 생성하여 해당 Activity에서 Service로 데이터를 전달한다.

  * LinearLayout으로 구성하며 TextView, EditText, Button으로 구성한다.

    * 받아온 데이터를 출력할 TextView
    * 데이터를 전달할 EditText
    * Service를 시작할 Button

    ```java
    TextView dataFromServiceTV = findViewById(R.id.dataFromServiceTV);
    final EditText datatToServiceET = findViewById(R.id.dataToServiceET);
    Button dataToServiceBtn = findViewById(R.id.dataToServiceBtn);
    ```

  * 각 Component에 대한 Reference를 획득한다.

  * Button에 대한 Event 처리를 진행한다.

    * Intent를 이용해서 Service를 호출한다.

    ```java
    dataToServiceBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            Intent intent = new Intent(getApplicationContext(),
                    Example17Sub_DataTransferService.class);
            intent.putExtra("DATA", datatToServiceET.getText().toString());
            startService(intent);
        }
    });
    ```

* Service를 생성한다.

  * `onCreate()`, `onStartCommand()`, `onDestroy()`를 Overriding한다.

  * 진행할 로직이 길지 않으므로 Thread를 이용하지않고 `onStartCommand()`내에 로직처리를 진행한다.

  * 받아온 데이터를 변환하여 결과데이터로 생성

    ```java
    String data = intent.getExtras().getString("DATA");
    String resultData = data + " 를 받음";
    ```

    * Activity로부터 전달된 intent가 `onStartCommand()`의 인자로 주어진다.

  * Intent를 이용하여 이전 Activity를 호출

    ```java
    Intent resultIntent = new Intent(getApplicationContext(),
            Example17_ServiceDataTransferActivity.class);
    ```

    * 결과데이터를 Intent에 부착

      ```java
      resultIntent.putExtra("RESULT", resultData);
      ```

    * 화면이 없는 Service가 화면이 있는 Activity를 호출하기 위해 TASK가 필요

      ```java
      resultIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      ```

    * 메모리에 존재하는 이전 Activity를 찾아서 실행

      ```java
      resultIntent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
      resultIntent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP);
      ```

    * Activity 실행

      ```java
      startActivity(resultIntent);
      ```

* 다시 Activity로 돌아와서 데이터를 받는다.

  * Service로부터 Intent를 받기위해 `onNewIntent()`를 Overriding한다.

    ```java
    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
    }
    ```

  * `onNewIntent()`안에서 Service에서 보낸 결과데이터를 받아서 TextView에 세팅

    ```java
    String result = intent.getExtras().getString("RESULT");
    dataFromServiceTV.setText(result);
    ```

* [Example 17 XML](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example17_service_data_transfer.xml), [Example 17 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example17_ServiceDataTransferActivity.java), [Example 17 Sub Service](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example17Sub_DataTransferService.java)