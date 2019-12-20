from flask import Flask, render_template, request
from decouple import config
import requests
import random

app = Flask(__name__)

token = config('TELEGRAM_TUNA_KR_BOT_TOKEN')
chat_id = config('TELEGRAM_MY_CHAT_ID')

app_url = f"https://api.telegram.org/bot{token}"


# root
@app.route('/')
def hello():
    return "Hello!"

@app.route('/write')
def write():
    # HTML file
    return render_template("write.html")

@app.route('/send')
def send():
    message = request.args.get("message")
    message_url = app_url + f"/sendMessage?chat_id={chat_id}&text={message}"
    # message 받아서 telegram 메시지 보내는 요청
    requests.get(message_url)
    return "Complete send message"

# Webhook
@app.route(f"/{token}", methods=['POST'])
def telegram():
    print(request.get_json())

    # 실습 1 : 사용자의 아이디랑 텍스트
    response = request.get_json()
    from_chat_id = response['message']['chat']['id']
    text = response['message']['text']
    print(f"ID : {from_chat_id}, Message : {text}")
    # 앵무새
    # 실습 2 : 텔레그램 메시지 보내기 요청
    message = f"Your ID is '{from_chat_id}' and Your message is '{text}'"

    # Lotto
    # 실습 3 : '/Lotto' 입력이 되면 text > 6개 숫자를 추천
    if(text == "/Lotto"):
        # lottoNumber = random.sample(range(1, 46), 6)
        # lottoNumber.sort()
        result = []
        [result.append(sorted(random.sample(range(1, 46), 6))) for _ in range(5)]
        
        message = f"Recommend is {result}"

    # 점심
    if(text == "/lunch"):
        lunch = ["20층", "샐러드", "고기", "해산물"]
        # random_number = random.randint(1, len(lunch) + 1)
        # message = f"Recommend is {lunch[random_number]}"
        message = random.choice(lunch)

    message_url = app_url + f"/sendMessage?chat_id={chat_id}&text={message}"
    requests.get(message_url)
    # return body, status_code
    return '', 200

# debug mode
if __name__ == "__main__":
    app.run(debug=True)