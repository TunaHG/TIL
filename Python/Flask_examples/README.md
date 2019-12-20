# Flask

## 1. flask server

* Flask서버의 이름을 app을 선언한다.

  ```python
  from flask import Flask
  
  app = Flask(__name__)
  
  if __name__ == "__main__":
      app.run(debug=True)
  ```

  * `__name__`은 현재 어디서 실행되고 있는지를 의미한다. `__name__`이 선언된 현재 `app.py`파일에서 직접 코드가 실행되면 이는 `__main__`이 된다. 이 `app.py`파일을 다른 파일에서 `import`해서 사용한다면 이 때의 `__name__`은 `__main__`이 아닌 다른 값이 된다.
  * `debug=True`는 `app.py`파일이 변경될 때마다 `Flask`를 `Restart`하며 적용해준다. 이를 적용하지 않으면 파일이 변경될 때마다 `Flask`를 다시 껏다켜줘야한다.

* `@app.route("/")`을 이용하여 `url`을 관리한다.

  ```python
  @app.route("/")
  def hello():
      return "안녕!!"
  ```

  * `route()`의 `()`안의 `String`이 `Flask`를 실행시켰을 때 뒤에 붙는 `url`을 의미한다.

* D-day를 확인하는 `url`을 만들어본다.

  ```python
  import datetime
  
  @app.route("/dday")
  def dday():
      today = datetime.datetime.now()
      print(today)
      final = datetime.datetime(2020, 6, 9)
      result = final - today
      print(result)
      return f"수료까지 {result.days}일 남았습니다."
  ```

  * `@app.route("/dday")`로 시작함으로써 `url`의 뒤에 `dday`가 붙으면 해당 함수가 실행된다.
  * `datetime`을 이용하여 현재 날짜를 가져오고, 목표 날짜를 설정한다.
  * `return`값이 `Web`창에 표시된다.

* Template을 활용하는 방법을 알아본다.

  * 영화 목록을 설정한 후 이를 출력하는 `html`파일을 만든다.

  * 이 때 `html`파일은 `app.py`파일이 존재하는 경로에 `templates`라는 폴더를 생성한 후 그 안에 만들어놔야한다.

    ```html
    <!DOCTYPE html>
    <html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>{{ text }}</title>
    </head>
    <body>
        <h1>{{ text }}</h1>
        <ul>
            {% for movie in movies %}
                <li>{{ movie }}</li>
            {% endfor %}
        </ul>
    </body>
    </html>
    ```
    * 이 때 `{{ text }}`와 `{{ movie }}`는 해당 `html`이 사용할 때 같이 받는 인자를 활용한다.
    * `Jinja2` 의 기능으로`{{ }}`로 묶인 부분은 데이터를 의미하며 `{% %}`로 묶인 부분을 활용하여 반복문을 구현할 수 있다.
    * [Codes](./templates/movies.html)

  * `templates`를 사용하기 위하여 `flask`패키지의 `render_template`을 가져온다.

    ```python
    from flask import Flask, render_template
    ```

  * `url`에 `movies`를 붙이면 작동하도록 한다.

    ```python
    @app.route("/movies")
    def movies():
        movies = ["겨울왕국2", "클라우스", "어바웃타임", "나홀로집에 1", "러브 액츄얼리"]
        return render_template("movie.html", movies=movies, text="영화 목록")
    ```

* `url` 뒤에 붙이는 값을 받아올 수도 있다.

  ```python
  @app.route("/greeting/<name>")
  def greeting(name):
      print(name)
      return f"안녕하세요! {name}님!"
  ```

  * `< >`내부에 입력된 것을 `def`에서 `parameter`로 받아서 사용할 수 있다.

  * `< >` 내부에 입력되는 값은 기본적으로 `String`으로 인식하며 이를 다른 값으로 바꿔주기 위해선 다음과 같이 사용해야 한다.

    ```python
    @app.route("/cube/<int:num>")
    ```

* 이외의 Code들은 `random`을 활용하여 진행해본 실습이다.

* [Codes](./app.py)