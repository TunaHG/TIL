# API

> DB대신 OPEN API를 활용하여 데이터를 가져오는 방식에 대해 알아본다.

## KAKAO API

> KAKAO Developers에서 지원하는 책 검색 데이터를 가져온다.

* [KAKAO Developers](https://developers.kakao.com/)에 접속

  * 우측 상단의 로그인을 진행한다. 카카오톡계정을 사용한다.

* 이전에 사용한적이 없다면 바로 앱 만들기 창이 떠있을 것이며, 앱을 만든적이 있다면 좌측의 앱이 표시되는 검은색 Block을 클릭하여 Dropdown list에서 새로운 앱 만들기를 클릭한다.

  * 앱이름과 회사명을 원하는대로 입력한다.
    * BookSearch / multicampus로 지정했다.

* 앱이 만들어졌다면, 4개의 앱 키가 표시될 것이다.

  * 우린 REST API를 사용할 예정이므로, 해당 앱 키를 복사하여 개인공간에 저장한다.

* API를 어떻게 사용하는지 알아본다.

  * 좌측 상단의 개발가이드로 진입한다.
    * 좌측의 REST API 개발가이드 > 검색 > 책 검색으로 이동한다
    * GET, HOST 주어지는 것을 보고 아래의 예시를 확인하여 사용

* 간단하게 API 사용법을 알아보고 Android Studio로 돌아와서 작업을 시작한다.

  * 이전에 작업했던 [Simple Book Search]와 비슷하게 작업할 예정이다.

* 새로운 Activity를 생성한다

  * Layout에는 LinearLayout과 그에 포함된 EditText, Button, ListView로 구성한다.

    * 검색할 단어를 입력할 EditText
    * 검색을 시작할 Button
    * 검색결과를 보여줄 ListView

  * Activity Java파일에서는 각 Widget의 처리를 진행한다.

    * 각 Widget의 Reference를 획득한다.

      ```java
      kakaoET = findViewById(R.id.kakaoET);
      kakaoSearchBtn = findViewById(R.id.kakaoSearchBtn);
      kakaoBookList = findViewById(R.id.kakaoBookList);
      ```

      * `onCreate()`외부에서 전부 전역변수로 선언해주었기 떄문에, 여기서는 값만을 준다.

    * Button에 대한 Event를 처리한다.

      ```java
      kakaoSearchBtn.setOnClickListener(new View.OnClickListener() {
          @Override
          public void onClick(View v) {
              Intent intent = new Intent(getApplicationContext(),
                      Example18Sub_KakaoBookSearchService.class);
              intent.putExtra("KEYWORD", kakaoET.getText().toString());
              startService(intent);
          }
      });
      ```

      * 검색은 Service에서 담당할 예정이므로 해당 Service를 호출한다.
      * 이 때, 어떤 단어로 검색할 것인지 EditText에 입력된 문자열을 keyword로 넘겨준다.

* 이제 검색을 담당할 Service를 구성해본다.

  * 새로운 Service를 생성하고, 3개의 기본 Method를 생성한다

    * `onCreate()`, `onStartCommand()`, `onDestroy()`를 의미한다.

  * `onStartCommand()`에서 로직을 처리한다.

    * Activity에서 전달받은 Intent가 인자로 주어진다.

    * 해당 Intent에서 getExtras를 통해 keyword값을 가져온다.

      ```java
      String keyword = intent.getExtras().getString("KEYWORD");
      ```

    * API와 Network통신을 해야하는데, 이는 Thread로 진행해야한다.

      ```java
      KaKaoBookSearchRunnable runnable = new KaKaoBookSearchRunnable(keyword);
      Thread thread = new Thread(runnable);
      thread.start();
      ```

* Service에서 Network통신을 담당할 Thread Class를 작성한다.

  * keyword가 필요하므로, 전역변수로 선언한다.

  * 생성자로 keyword를 받아와야 하므로 해당 생성자를 만들어준다.

  * `run()` Method를 Overriding해서 해당 Method에서 Network통신을 진행한다.

    * KAKAO API를 호출해야 한다.

    * 개발가이드와 사용예시를 참고하여 URL을 구성한다.

      ```java
      String url = "https://dapi.kakao.com/v3/search/book?target=title";
      url += ("&query=" + keyword);
      ```

    * API와 통신할 URL을 구성했으니 Network통신을 진행한다.

      * Java에서 Network 연결은 예외상황이 발생할 수 있으니 try-catch문으로 작업해야한다.

      1. HTTP 접속을 위한 URL 객체를 생성한다.

         ```java
         URL obj = new URL(url);
         ```

      2. URL Connection을 열어야 한다.

         ```java
         HttpURLConnection con = (HttpURLConnection)obj.openConnection();
         ```

      3. 연결에 대한 방식을 설정해야 한다.

         * 이 부분 또한 API 개발가이드에 명시된 부분을 따라야 한다.

         * 해당 부분이 GET방식을 사용한다고 명시했고, 인증에 대한 처리가 필요하다고 명시했다.

         * 호출방식을 GET방식으로 정해준다.

           ```java
           con.setRequestMethod("GET");
           ```

         * 인증에 대한 처리를 진행한다.

           * 개발가이드를 살펴보면 `Authorization: KakaoAK {app_key}`와 같이 구성되어 있다

             ```java
             con.setRequestProperty("Authorization", "KakaoAK 729499a1427f59d0c93717569b90ead1");
             ```

           * 앞의 인자 Authorization이 항목 이름이며, 뒤의 인자가 해당 값이다.

           * 이 때 app_key는 KAKAO API에서 앱을 생성할 때 복사해두었던 REST API를 입력한다.

      4. 

