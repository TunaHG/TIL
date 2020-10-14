# Node.JS Lecture

> SWM, 2020/10/14에 진행된 손영수멘토님의 Node.js 특강

## Node.js

* 좋은 활용
  * Rest + JSON API
  * SIngle-page Web app
  * Real-time web app
  * 빠른 Prototyping
  * 많은 I/O 처리
  * techempower
    * 1년에 한번정도 framework들 모아서 성능 비교분석 하는 사이트
    * Restful API를 설계하면 Django << Spring <<<< Node.js정도의 성능차이
    * Node.js를 쓰더라도 MySQL, Postgres처럼 맞지않는 DB를 사용하면 성능은 좋지 않다.
* 나쁜 활용
  * CPU 부하 걸리는 작업
    * 동시성 관련된 작업들 (Go-lang이 가장 활용하기 좋음)
  * 멀티쓰레드 App
    * Java, C++
  * 큰 데이터 연산
    * 빅데이터는 파이썬으로 귀결됨
  * 복잡한 비즈니스 로직
    * 객체지향적 설계 등 복잡한 비즈니스 로직에는 Java가 좋음
    * 국가 표준 프레임워크가 Java를 사용

## Node.js의 철학

* Server side Javascript
* Event Driven
* Asynchronous
  * 동기랑 비동기의 대상은 서버와 클라이언트
    * https://has3ong.github.io/syncasync-nonblock/
  * 비동기의 Non-blocking으로 진행 (서버는 이렇게 만들어야 가장 좋다!)
* Non-Blocking I/O
  * Blocking, Non-Blocking은 유저레벨과 커널레벨관의 관계
  * Reactor / Proactor 패턴
    * Reactor는 요청이 유제레벨로 먼저 들어오고 커널로 내려갔다가 다시 올라오는 패턴
    * Proactor는 요청이 유저레벨로 들어오지않고 바로 커널레벨로 들어가서 처리후 올라오는 패턴
    * https://www.javacodegeeks.com/2012/08/io-demystified.html
  * 동기/비동기 + Blocking/Non-Blocking + Reactor/Proactor 세가지 종류로 구성된 서버
* Single Threaded
* Lightweight

## Architecture

