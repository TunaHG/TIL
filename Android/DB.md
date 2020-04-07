# DB

## SQLite

* 안드로이드에는 이미 SQLite라는 DB가 들어가있다.
* Table이 각 앱마다 만들어진다.
  * 위치도 Data라는 Table밑에 개별적으로 가지고 있다.
* [Download Site](https://sqlitebrowser.org/dl/)에서 운영체제에 맞는 `.zip(no installer)`버전을 다운로드 받는다.

## Basic Example

* 새로운 Activity의 Layout은 다음과 같이 구성

  * Vertical LinearLayout을 기본으로 구성
  * Horizontal LinearLayout을 Vertical 내부에 추가
  * EditText, Button을 Horizontal 내부에 추가

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
            // Database 생성
            // "dbName.db"라는 파일로 생성
            String dbName = dbNameET.getText().toString();
    
            // MODE_PRIVATE : 0값, 일반적인 형태(읽고쓰기가 가능한)의 DB를 생성하거나 Open
            sqLiteDatabase = openOrCreateDatabase(dbName, MODE_PRIVATE, null);
            Log.i("DBTest", "Database Created");
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