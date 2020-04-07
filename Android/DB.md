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

## Helper Example

> SQLite를 사용할 때는 Helper를 사용하면 편리하다.

* 새로운 Activity에서 진행한다.

* Layout은 Basic Example과 동일하다.

  * 각 Widget의 ID값은 변경해줘야한다.

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