# Node.JS

## Node.js란?

* 웹 브라우저에서 쓰이는 자바스크립트를 서버에서 사용가능

## Node.js 환경 구축

> WIndows에서 작업을 진행하는 환경을 구축하나, WSL을 사용하여 Linux환경에서 진행

* WSL 환경 구축

  * [WSL Docs](https://docs.microsoft.com/ko-kr/windows/wsl/install-win10)
    * 마이크로소프트에서 지원하는 WSL을 설치하는 가이드문서
  * 2020/07/14 현재 내 노트북에서는 WSL 2를 위한 Windows 10 버전 2004로 업그레이드가 아직 지원하지 않음
  * WSL 2로 업데이트하지않고 WSL 1로 진행

* WSL을 사용한 Node.js 개발 환경 구축

  * [WSL 2에 Node.js 설치 Docs](https://docs.microsoft.com/ko-kr/windows/nodejs/setup-on-wsl2)
  * 문서를 그대로 따라하며 WSL에 Node.js를 설치
  * WSL과 연동하여 사용하는 VS Code 환경 설정

  ```bash
  # curl 설치
  sudo apt-get install curl
  # curl을 활용한 nvm 설치
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
  # nvm 설치확인
  command -v nvm # nvm이 출력되면 정상설치 완료
  
  # 현재 설치된 Node버전 확인
  nvm ls # iojs, node, unstable이 N/A인 것을 확인
  
  # Node 설치 (둘 중 한가지 진행)
  # Node.js LTS 릴리스 설치
  nvm install --lts # 권장
  # Node.js 최신 릴리스 설치
  nvm install node # 최신 기능 개선사항 테스트하는것이 목적, 이슈가 있을 가능성이 높음
  
  # 현재 설치된 Node버전 확인
  nvm ls # default, node, stable이 Node버전으로 변경된 것을 확인
  node --version
  npm --version
  
  # Node를 최신, LTS를 전부 설치했을 경우 버전이 두 개가 보임
  nvm use --lts # 프로젝트에 사용할 Node버전을 LTS버전으로 전환
  nvm use node # 프로젝트에 사용할 Node버전을 최신버전으로 전환
  ```

## 초보자를 위한 Node.js 시작

### Node.js Application

* SPA(단일 페이지 앱)
  * 브라우저 내에서 작동하는 웹앱
  * 새 데이터를 가져오는 데 사용할 때마다 페이지를 다시 로드할 필요가 없음
  * 소셜 네트워킹 앱, 메일 또는 지도 앱, 온라인 텍스트 또는 그리기 도구 등
* RTA(실시간 앱)
  * 사용자가 정기적으로 업데이트가 있는지 소스를 확인하도록 요구하는 대신,
    작성자가 게시하는 즉시 정보를 받을 수 있도록 하는 웹앱
  * 인스턴트 메시징 앱, 온라인 멀티플레이 게임, 온라인 공동작업 문서, 화상 회의 앱 등
* 데이터 스트리밍 앱
  * 필요에 따라 추가 데이터, 콘텐츠 또는 구성요소를 계속 다운로드하며 데이터/콘텐츠를 전송하는 앱
  * 비디오 및 오디오 스트리밍 앱
* REST API
  * 다른 사람의 웹앱이 상호 작용할 데이터를 제공하는 인터페이스
* SSRP(서버 쪽 렌더링 앱)
  * 클라이언트와 서버 둘 다에서 실행될 수 있음
  * 동적 페이지에서 알려진 콘텐츠는 표시하고 알려지지 않은 콘텐츠는 사용할 수 있께 될 때 가져옴
  * 동일구조 또는 유니버설 앱
  * SSR은 사용할 때마다 다시 로드하지 않아도 되는 SPA 방법을 활용
  * Node.js 서버를 지속적으로 실행해야 한다는 단점
* 명령줄 도구
  * 반복적인 작업을 자동화하고 방대한 Node.js 에코시스템에 도구를 배포 가능
  * 클라이언트 URL을 나타내는 cURL이 예시
* 하드웨어 프로그래밍
  * 센서, 비콘, 송신기 등 대량의 데이터를 생성하는 장치에서 데이터를 수집하는 IoT용도로 사용
  * 디바이스와 서버 간 통신, 분석에 따른 작업 수행 지원
  * NPM에는 다양한 센서 및 디바이스를 위한 80가지 이상의 패키지가 포함

### 사용해보기

```bash
# 새 디렉토리 생성 및 이동
mkdir HelloNode
cd HelloNode

# var msg라는 코드를 가진 app.js파일 생성
echo var msg > app.js

# VS Code에서 해당 파일 Open
code .

# app.js의 내용을 다음과 같이 수정
var msg = 'Hello World';
console.log(msg);

# Ctrl + `를 이용하여 VS Code내에서 바로 터미널 Open후 app.js 실행
node app.js
```

### Express를 사용한 웹앱 프레임워크 설정

* Express
  * GET, PUT, POST 및 DELETE와 같은 여러 유형의 요청을 처리 가능
  * 웹앱을 보다 쉽게 개발할 수 있게 해 주는 유연하고 간소화된 소형 Node.js 프레임워크

* Express 사용하여 프로젝트 생성

  ```bash
  # Express 프로젝트 디렉토리 생성 및 이동
  mkdir ExpressProjects
  cd ExpressProjects
  
  # Express를 사용한 프로젝트 템플릿 생성
  npx express-generator HelloWorld --view=pug
  # npx 명령을 사용하여 실제로 설치하지 않고 Express.js Node 패키지를 실행
  # express --version을 사용해보면 express가 설치되어 있지 않은 것을 확인할 수 있음
  # express를 설치하려면 다음의 코드 실행
  npm install -g express-generator
  
  # VS Code를 열어 Express가 포함한 파일 및 폴더 확인
  code .
  ```

* Express에서 생성하는 파일은 처음에는 별로 과도하지 않을 수 있는 아키텍처를 사용하는 웹앱 생성

  * `bin`은 앱을 시작하는 실행파일을 포함
    * 서버를 실행(대안이 없는 경우 포트 3000)하고 기본 오류처리를 설정
  * `public`은 JS, CSS, 글꼴, 이미지 등의 공개적으로 액세스되는 모든 파일을 포함
  * `routes`는 앱에 대한 모든 경로 처리기를 포함
    * 앱의 경로 구성을 분리하는 방법의 예로 index.js, users.js가 자동 생성
  * `views`는 템플릿 엔진에서 사용되는 파일을 포함
    * Express는 render 메소드가 호출될 때 일치하는 뷰를 찾도록 구성
    * 기본 템플릿 엔진은 Jade지만 Pug용으로 더 이상 사용되지 않음
  * `app.js`는 앱의 시작점
    * 모든 항목을 로드하고 사용자 요청을 처리하기 시작
    * 기본적으로 모든 부분을 함께 연결
  * `pacakge.json`은 프로젝트 설명, 스크립트 관리자 및 앱 매니페스트를 포함
    * 앱의 종속성 및 해당 버전을 추적하는 목적

* 생성된 프로젝트의 빌드 및 실행

  ```bash
  # Express에서 사용하는 종속성 설치
  npm install
  
  # 가상 서버에서 Express 앱 시작
  npx cross-env DEBUG=HelloWorld:* npm start
  ```

  * 브라우저를 열고 `localhost:3000`으로 이동하여 실행 중인 앱 확인
  * views > index.pug 파일선택
    * `h1= title`을 `h1= "Hello World!"`로 수정
  * `localhost:3000`이 열려있는 브라우저를 새로고침하여 변경된 것 확인

* `Ctrl + C`를 통해 Express 앱 실행 중지

### Node.js Module 사용해보기

* Module

  * gm, sharp
    * JS 코드에서 직접 편집, 크기 조정, 압축 등을 비롯한 이미지 조작
  * PDFKit
    * PDF 생성
  * validator.js
    * 문자열 유효성 검사
  * imagemin, UglifyJS2
    * 축소
  * spritesmith
    * 스프라이트 시트 생성
  * winston
    * 로깅
  * commander.js
    * 명령중 애플리케이션 만들기

* 기본 제공 OS모듈을 사용하여 현재 운영체제에 대한 정보 확인

  * `node`를 입력하면 `>` 프롬프트에 Node.js를 사용하고 있다고 표시
  * `os.platform()`을 입력하면 현재 운영체제 확인
  * `os.arch()`를 입력하면 CPU의 아키텍처 확인
  * `os.cpus()`를 입력하면 사용할 수 있는 CPU 확인
  * `.exit`를 입력하거나 Ctrl + C를 두 번 선택하여 node CLi에서 벗어남

* Module을 내보낼 때

  ```js
  module.exports.b = "hello b";
  
  function Myvar(){
      this.name = "my instance";
  }
  module.exports = Myvar;
  ```

* Module을 가져올 때

  ```js
  const myvar = require('./myvar');
  console.log(myvar);
  ```

  