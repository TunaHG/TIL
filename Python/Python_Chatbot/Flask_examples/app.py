from flask import Flask, render_template, request
import datetime
import random

# 지금부터 flask 서버의 이름이 app
app = Flask(__name__)

# url를 관리해주는 친구 > @app.route("/")
@app.route("/")
def hello():
    return "안녕!!"


@app.route("/dday")
def dday():
    today = datetime.datetime.now()
    print(today)
    final = datetime.datetime(2020, 6, 9)
    result = final - today
    print(result)
    return f"수료까지 {result.days}일 남았습니다."

# is it christmas 실습
# "/christmas"
@app.route('/christmas')
def christmas():
    today = datetime.datetime.now()
    month = today.date().month
    day = today.date().day
    print(today.date().strftime("%Y년 %m월 %d일"))
    if month == 12 and day == 25:
        return "<h1>YES</h1>"
    else:
        return "<h1>NO</h1>"
'''
def render_template(str, **args):


'''
@app.route("/movies")
def movies():
    movies = ["겨울왕국2", "클라우스", "어바웃타임", "나홀로집에 1", "러브 액츄얼리"]
    return render_template("movie.html", movies=movies, text="영화 목록")


@app.route("/greeting/<string:name>")
def greeting(name):
    print(name)
    return f"안녕하세요! {name}님!"

@app.route("/cube/<int:num>")
def cube(num):
    result = num ** 3
    return str(result)

# 식사 메뉴 추천
# 1. random
# 2. DR_url : @app.route("/lunch/1 2 3 4")
#   - List : ["자장면", "짬뽕", "오므라이스", "볶음밥", "고추잡채밥"]
#   - <int:num> 숫자 만큼 뽑기
# 3. print(선택된 메뉴들)
# 4. return ""

@app.route("/lunch/<int:num>")
def lunch(num):
    menu = ["자장면", "짬뽕", "오므라이스", "볶음밥", "고추잡채밥", "고르곤졸라피자"]
    c_menu = random.sample(menu, num)
    return render_template("movie.html", movies=c_menu, text="점심 메뉴")

@app.route("/vonvon")
def vonvon():
    return render_template("vonvon.html")


@app.route("/godmademe")
def godmademe():
    name = request.args.get("name")
    
    first_list = ["못생김", "어중간함", "착하게생김", "공부잘하게생김"]
    second_list = ["애교", "잘난척", "쑥스러움", "자신감"]
    third_list = ["허세", "식욕", "찌질", "돈복"]
    
    first = random.choice(first_list)
    second = random.choice(second_list)
    third = random.choice(third_list)

    return render_template("godmademe.html", name=name, first=first, second=second, third=third)


# flask run
# Debug Mode > python app.py
if __name__ == "__main__":
    app.run(debug=True)
