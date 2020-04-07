# DB

## SQLite

* 안드로이드에는 이미 SQLite라는 DB가 들어가있다.
* Table이 각 앱마다 만들어진다.
  * 위치도 Data라는 Table밑에 개별적으로 가지고 있다.
* [Download Site](https://sqlitebrowser.org/dl/)에서 운영체제에 맞는 `.zip(no installer)`버전을 다운로드 받는다.
  * Android에서 생성하는 `*.db`파일을 살펴보기위한 프로그램이다.

## Basic Example

> Android에서 DB를 사용하는 방법에 대해 알아본다.

* 새로운 Activity의 Layout은 다음과 같이 구성
  * Vertical LinearLayout을 기본으로 구성
  * Horizontal LinearLayout을 Vertical 내부에 추가
  * EditText, Button을 Horizontal 내부에 추가
  * [Example 22 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example22_sqlite_basic.xml)

### Database 생성

* EditText 객체를 생성한다.

  * 전역변수로 설정한다.

    ```java
    private EditText dbNameET;
    ```

    ```java
    dbNameET = findViewById(R.id.dbNameET);
    ```

* Button에 대한 Event를 처리한다.

  * 해당 Button은 EditText에 입력한 내용으로 DB를 만드는 기능을 수행한다.

  * 객체를 생성한다.

    ```java
    Button dbCreateBtn = findViewById(R.id.dbCreateBtn);
    ```

  * Click Event를 처리한다.

    ```java
    dbCreateBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
    
        }
    });
    ```

  * EditText에 입력한 내용을 가져온다.

    ```java
    String dbName = dbNameET.getText().toString();
    ```

    * `"dbName.db"`라는 이름의 Database파일이 생성된다.

  * SQLiteDatabase 객체를 생성한다.

    * 해당 객체는 전역변수로 먼저 선언한다.

      ```java
      SQLiteDatabase sqLiteDatabase;
      ```

      ```java
      sqLiteDatabase = openOrCreateDatabase(dbName, MODE_PRIVATE, null);
      ```

  * DataBase를 생성한다.

    ```java
    sqLiteDatabase = openOrCreateDatabase(dbName, MODE_PRIVATE, null);
    ```

    * MODE_PRIVATE은 0값을 의미한다.
    * 해당 Code는 일반적인 형태(읽고쓰기가 가능한)의 DB를 생성하거나 Open하는 Code이다.

* Android Studio에서 검색창을 띄운다.

  * 검색창은 프로그램의 우측상단 돋보기 표시를 누르거나 Shift키를 두번눌러서 진입할 수 있다.
  * Device File Explorer를 탐색하여 실행한다.
  * Android Studio에서 지원하는 에뮬레이터로 위의 Activity를 실행하여 Database를 생성한다.
    * data > data > 해당 앱 > databases로 진입하면 생성된 `.db`파일이 보인다.
    * 해당 db파일을 SQLiteBrowser프로그램으로 실행해본다.
  * 에뮬레이터가 아닌 실제폰으로 진행했을 경우, 보안의 문제로 에뮬레이터처럼 db파일을 꺼내올 수 없다.

### Table 생성

* Layout을 추가한다.

  * Horizontal LinearLayout을 그대로 복사하여 붙여넣는다.
    * 안에 포함된 EditText, Button까지도 복사되도록 한다.

* 새로이 추가된 EditText와 Button에 대한 처리를 진행한다.

  * 새로 추가한 항목은 Table을 생성하기 위한 Widget이다.

  * EditText의 객체를 생성하여 Reference를 설정한다.

    ```java
    private EditText tableNameET;
    ```

    ```java
    tableNameET = findViewById(R.id.tableNameET);
    ```

  * Button의 객체를 생성하고 onClick 메소드를 생성한다.

    ```java
    Button tableCreateBtn = findViewById(R.id.tableCreateBtn);
    ```

    ```java
    tableCreateBtn.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View v) {
    
        }
    });
    ```

* onClick() 내부에 Table을 생성하는 로직을 처리한다.

  * EditText로부터 입력된 tableName을 가져온다.

    ```java
    String tableName = tableNameET.getText().toString();
    ```

  * Database가 생성되어 있는지 체크한다.

    ```java
    if(sqLiteDatabase == null) {
        Log.i("DBTest", "Database부터 생성해야함");
        return;
    }
    ```

    * 생성되어 있지 않다면 return으로 Method를 벗어난다.

  * SQL을 이용해서 Database안에 Table을 생성한다.

    * Table을 생성하는 SQL문을 먼저 만든다.

      ```java
      String sql = "CREATE TABLE IF NOT EXISTS " + tableName +
              "(_id INTEGER PRIMARY KEY AUTOINCREMENT, " +
              "name TEXT, age INTEGER, mobile TEXT)";
      ```

    * 완성된 SQL문을 어떤 Database에서 실행시킬건지 정하여 실행

      ```java
      sqLiteDatabase.execSQL(sql);
      ```

### Record 추가

* Layout에 Widget을 추가한다.

  * Horizontal Linear를 Vertical Linear 내부에 새로 생성한다
  * Horizontal Linear에 4개의 Widget을 추가한다.
  * EditText 3개, Button 1개를 추가한다.

* 3개의 EditText Reference를 가져온다.

  * 전역변수로 선언해준다.

    ```java
    private EditText empNameET, empAgeET, empMobileET;
    ```

    ```java
    empNameET = findViewById(R.id.empNameET);
    empAgeET = findViewById(R.id.empAgeET);
    empMobileET = findViewById(R.id.empMobileET);
    ```

* Button에 대한 Click Event를 처리한다.

  * Button을 클릭하면 EditText에서 가져온 데이터를 Table에 Record로 추가한다

  * EditText에서 값들을 가져온다.

    ```java
    String name = empNameET.getText().toString();
    int age = new Integer(empAgeET.getText().toString()).intValue();
    String mobile = empMobileET.getText().toString();
    ```

    * age의 경우 int값으로 가져와야하기 때문에 Integer객체를 사용하였다.

  * Database가 열려있는지 확인한다.

    ```java
    if(sqLiteDatabase == null) {
        Log.i("DBTest", "Database부터 생성해야함");
        return;
    }
    ```

  * Record를 추가하는 Insert SQL문을 작성한다.

    ```java
    String sql = "INSERT INTO emp(name, age, mobile) VALUES" +
            "('" + name + "', " + age + ", '" + mobile + "')";
    ```

  * SQL문을 실행한다.

    ```java
    sqLiteDatabase.execSQL(sql);
    ```

  * Button을 눌렀을 때 EditText 3개에 입력한 값을 없애고 초기화한다.
    ```java
    empNameET.setText("");
    empAgeET.setText("");
    empMobileET.setText("");
    ```

### Record 출력

* Layout을 추가한다.

  * Vertical Linear에 Button을 하나 생성한다.
    * Record를 출력하기위한 Button
  * ScrollView를 만들고 내부에 TextView를 생성한다.
    * Record를 출력할 TextView

* Button에 대한 Click Event를 처리한다.

  * Select SQL문을 작성한다.

    ```java
    String sql = "SELECT _id, name, age, mobile FROM emp";
    ```

  * Database가 열려있는지 확인한다.

    ```java
    if(sqLiteDatabase == null) {
        Log.i("DBTest", "Database부터 생성해야함");
        return;
    }
    ```

  * Select문을 실행한다.

    ```java
    Cursor cursor = sqLiteDatabase.rawQuery(sql, null);
    ```

    * Select문은 execSQL이 아닌 rawQuery를 사용한다.
    * 결과값은 Cursor객체로 받아온다.

  * Cursor에서 데이터를 읽어와서 TextView에 전달한다

    ```java
    private TextView resultTV;
    ```

    ```java
    resultTV = findViewById(R.id.resultTV);
    ```

    ```java
    while(cursor.moveToNext()){
        int id = cursor.getInt(0);
        String name = cursor.getString(1);
        int age = cursor.getInt(2);
        String mobile = cursor.getString(3);
    
        String result = "Record : " + id + ", " + name + ", " + age + ", " + mobile;
        resultTV.append(result + "\n");
    }
    ```

  * [Example 22 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example22_SQLiteBasicActivity.java)

## Helper Example

> SQLite를 사용할 때는 Helper를 사용하면 편리하다.

* 새로운 Activity에서 진행한다.

* Layout은 Basic Example과 동일하다.

  * 각 Widget의 ID값은 변경해줘야한다.
  * [Example 23 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example23_sqlite_helper.xml)

* DataBase Open Helper를 사용하기위해 외부 Class를 정의한다.

  * SQLiteOpenHelper를 상속받는다

  * 생성자를 만들어줘야한다.

    * SQLiteOpenHelper에는 기본생성자가 존재하지않는다.

    * 인자 4개를 받는 생성자를 만들어줘야 한다.

      ```java
      MyDBHelper(Context context, String dbName, int version) {
          super(context, dbName, null, version);
      }
      ```

  * 객체를 생성하여 생성자가 사용될 때 여러가지 방식으로 동작한다

    * dbName이라는 데이터베이스가 없으면 
      * `onCreate()`를 호출하며 인자로 받은 Version값을 같이 명시하여 데이터베이스를 생성한다.
      * 이후 `onOpen()`을 호출한다.
    * dbName이라는 데이터베이스가 있으면
      * `onOpen()`을 호출한다.
      * 인자로 받은 Version값과 생성되있는 데이터베이스의 Version값이 다르면 `onUpgrade()`를 호출한다.

  * 3개의 Method를 Overriding한다.

    * `onOpen()`, `onCreate()`, `onUpgrade()`

  * `onOpen()`

    * 데이터베이스가 Open될 때 자동으로 호출된다.

  * `onCreate()`

    * 데이터베이스가 존재하지 않아서 생성할 때 호출된다.

    * 데이터 베이스를 생성하는 코드를 포함한다.

      ```java
      String sql = "CREATE TABLE IF NOT EXISTS " +
              "person( _id INTEGER PRIMARY KEY AUTOINCREMENT, " +
              "name TEXT, age INTEGER, mobile TEXT)";
      
      db.execSQL(sql);
      ```

      * `db`는 `onCreate()`에서 인자로 받는 SQLiteDatabase객체이다.

  * `onUpgrdae()`

    * 데이터베이스 버전이 바뀌어서 데이터베이스를 수정할 때 호출된다.
    * 초창기에 앱을 만들어서 배포할 때 DB 스키마를 생성하는데, 이후에 앱을 업그레이드해서 다시 배포할 때 DB스키마를 다시 생성하기 위해 사용된다.
    * 이전 DB를 Drop시키고 새로운 DB를 만드는과정을 진행한다.

* Database를 생성하는 Button의 Click Event를 처리한다.

  * EditText에 입력된 값을 String으로 가져온다.

    ```java
    String dbName = helperDBNameET.getText().toString();
    ```

  * Helper Class를 이용하여 DB를 생성한다.

    ```java
    MyDBHelper helper = new MyDBHelper(Example23_SQLiteHelperActivity.this,
            dbName, 1);
    ```

  * Helper를 통해서 DB Reference를 획득한다.

    ```java
    database = helper.getWritableDatabase();
    ```

* [Example 23 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example23_SQLiteHelperActivity.java)

## Content Provider Example

> Content Provider를 사용하여 DB작업을 진행한다.

### Content Provider

* 하나의 App에서 관리하는 Data를 다른 App에서 접근할 수 있게 해주는 기능
* Android App에서는 자신의 App에서 생성된 Data만 사용할 수 있다.
  * 다른 App에서 생성된 Data에는 접근권한이 없다.
  * 하지만 CP를 사용하면 일반적으로 Database에 접근하는 방식을 이용하여 다른 App의 Data에 접근할 수 있다.
    * CP가 CRUD를 기반으로 하고 있기 때문에
* AndroidManifest.xml 파일에 등록해서 사용한다.

### Example

* 새로운 Activity를 생성하여 진행한다.

* Layout은 Helper Example 또는 Basic Example의 Layout을 복사해서 붙여넣고 구성을 시작한다.

  * DB와 Table을 생성하는 LinearLayout은 삭제한다.
  * 나머지는 각 ID를 변경한다.
  * [Example 24 Layout](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/res/layout/activity_example24_content_provider.xml)

* Database를 이용하기 때문에 SQLiteOpenHelper Class를 만들어야한다.

  ```java
  class PersonDBHelper extends SQLiteOpenHelper {
      PersonDBHelper(Context context) {
          super(context, "person.db", null, 1);
      }
  
      @Override
      public void onCreate(SQLiteDatabase db) {
          // 초기에 데이터베이스가 생성되는 시점에 Table도 같이 생성
          String sql = "CREATE TABLE IF NOT EXISTS " +
                  "person( _id INTEGER PRIMARY KEY AUTOINCREMENT, " +
                  "name TEXT, age INTEGER, mobile TEXT)";
          db.execSQL(sql);
      }
  
      @Override
      public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
  
      }
  }
  ```

* Content Provider를 생성한다.

  * New > Other > Content Provider를 생성한다.

    * Uri Authorities를 다음과 같이 설정한다.
    * `com.exam.person.provider` => 특정 Class에 부착된 Provider임을 의미

  * 생성해보면 CRUD에 대한 기본메소드가 자동으로 Overriding되서 생성된다.

  * Provider를 사용할 때는 URI형식을 사용한다.

    * `content://Authority/BASE_PATH(테이블이름)/숫자(Record번호)`의 양식으로 사용한다.
    * 예시 : `content://com.exam.person.provider/person/1`

  * `onCreate()` 메소드를 수정한다.

    ```java
    @Override
    public boolean onCreate() {
        Log.i("DBTest", "CP onCreate() Callback");
        return true;
    }
    ```

    * Log를 찍어서 확인해보기 위함이다.

    * 앱을 실행시켜보면, 앱이 실행되자마자 해당 Log가 출력된다.

      * 앱에 CP가 있는것을 확인하고 Android System에 의해서 자동적으로 만들어진다.

    * Log를 찍어서 확인해봤으니 Helper를 이용하여 DB, Table 생성에 대한 코드를 작성한다.

      ```java
      PersonDBHelper helper = new PersonDBHelper(getContext());
      database = helper.getWritableDatabase();
      ```

  * DB가 생성되는 것을 확인했으니 `insert()` 를 수정한다.

    ```java
    database.insert("person", null, values);
    ```

  * [Example 24 Sub Content Provider](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example24Sub_PersonContentProvider.java)

* AndroidManifest.xml파일을 확인해본다

  * `<provider>`태그가 생긴것을 확인한다.

  * 해당 태그에 몇가지 인자를 추가한다.

    ```java
    android:readPermission="com.exam.person.provider.READ_DATABASE"
    android:writePermission="com.exam.person.provider.WRITE_DATABASE"
    ```

  * 태그 내부가 아닌 외부에 permission을 허용해야 한다.

    ```java
    <permission android:name="com.exam.person.provider.READ_DATABASE"
        android:protectionLevel="normal"/>
    <permission android:name="com.exam.person.provider.WRITE_DATABASE"
        android:protectionLevel="normal"/>
    ```

    * `<application>`태그 외부에 작성한다.

* Example24 Activity로 돌아와서 Button의 Event처리를 진행한다.

  * 같은 앱이므로 CP를 이용할 필요는 없지만, 실습을 위해 CP를 이용해 insert처리를 진행한다.

  * CP의 URI를 가져온다.

    ```java
    String uriString = "content://com.exam.person.provider/person";
    ```

  * CP의 URI를 URI객체로 변경한다.

    ```java
    Uri uri = new Uri.Builder().build().parse(uriString);
    ```

  * Insert에 사용할 ContentValues객체를 생성한다.

    ```java
    ContentValues values = new ContentValues();
    values.put("name", "홍길동");
    values.put("age", 20);
    values.put("mobile", "010-1111-5555");
    ```

    * SQL문을 사용하지 않기위해 사용하는 것이다.

  * CP를 찾아서 insert를 진행한다.

    ```java
    getContentResolver().insert(uri, values);
    ```

    * ContentResolver를 사용하여 CP를 탐색한다.

  * [Example 24 Java](https://github.com/TunaHG/Android_Workspace/blob/master/AndroidLectureExample/app/src/main/java/com/example/androidlectureexample/Example24_ContentProviderActivity.java)