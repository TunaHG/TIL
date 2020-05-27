# DML

> Data Manipulation Language

* 만들어진 테이블에 관리하기를 원하는 자료들을 입력, 수정, 삭제, 조회하는 명령어
* 조작하려는 테이블을 메모리 버퍼에 올려놓고 작업을 하기 때문에 실시간으로 테이블에 영향을 미치지 않음
  * 버퍼에서 처리한 DML명령어가 실제 테이블에 반영되기 위해서는 COMMIT명령어를 입력하여 TRANSACTION을 종료해야 함
  * DDL은 명령어를 입력하는 순간 명령어에 해당하는 작업이 즉시 완료됨(Auto Commit)
  * SQL Server의 경우에는 DML도 Auto Commit으로 처리됨

## INSERT

```sql
INSERT INTO {테이블명} (COLUMN_LIST)
VALUES (COLUMN_LIST에 넣을 VALUE_LIST);

INSERT INTO {테이블명}
VALUES (전체 COLUMN에 넣을 VALUE_LIST);
```

* 해당 칼럼명과 입력되어야 하는 값을 서로 1:1로 매핑해서 입력
* CHAR, VARCHAR등 문자 유형일 경우 `' '`로 입력할 값을 입력
  * 숫자의 경우에는 붙이지 말아야 함
* 값을 입력할 칼럼을 정의하는 경우
  * 칼럼의 순서는 테이블의 칼럼 순서와 매치할 필요 없음
  * 정의하지 않은 칼럼은 DEFAULT로 NULL값이 입력
  * 단 Primary Key, NOT NULL로 지정된 칼럼은 NULL이 허용되지 않음
* 모든 칼럼에 데이터를 입력하는 경우
  * 칼럼의 순서대로 빠짐없이 데이터 입력

## UPDATE

```sql
UPDATE {테이블명}
SET {수정되어야 하 칼럼명} = {수정되기를 원하는 새로운 값};
```

* 입력한 정보 중에 잘못 입력되거나 변경이 발생하여 정보를 수정해야 하는 경우

## DELETE

```SQL
DELETE [FROM] {삭제를 원하는 정보가 들어있는 테이블명};
```

* 테이블의 정보가 필요 없게 되었을 경우 데이터 삭제를 수행하는 명령
* WHERE절을 사용하지 않는다면 테이블의 전체 데이터가 삭제됨

## SELECT

```SQL
SELECT [ALL/DISTINCT] {보고싶은 칼럼명1}, {보고싶은 칼럼명2}, ...
FROM {해당 칼럼들이 있는 테이블명};
```

* 사용자가 입력한 데이터를 조회하는 명령

* ALL : DEFAULT옵션, 중복된 데이터가 있어도 모두 출력

  * DISTINCT : 중복된 데이터가 있는 경우 1건으로 처리해서 출력

* WILDCARD

  ```SQL
  SELECT * FROM {테이블명};
  ```

  * 해당 테이블에 존재하는 모든 칼럼들을 선택하여 조회하는 명령어

* 문자 및 날짜 데이터는 좌측 정렬된 상태로 보여지며 숫자 데이터는 우측 정렬된 상태로 보여짐

* ALIAS

  ```SQL
  SELECT PLAYER_NAME AS 선수명, POSITION "그라운드 포지션"
  FROM PLAYER;
  ```

  * 일종의 별명을 부여해서 칼럼레이블을 변경할 수 있음
  * 칼럼명 바로뒤에 옴
  * 칼럼 명과 ALIAS 사이에 AS, as 키워드를 사용 (OPTION)
  * 이중 인용부호는 ALIAS가 공백, 특수문자를 포함할 경우와 대소문자 구분이 필요할 경우 사용

## 산술 연산자와 합성 연산자

### 산술 연산자

```SQL
SELECT HEIGHT - WEIGHT "키-몸무게"
FROM PLAYER;
```

* NUMBER와 DATE 자료형에 대해 적용되며 일반적으로 수학에서의 4칙 연산과 동일
  * 우선순위를 위한 괄호 적용이 가능
* 적절한 ALIAS를 새롭게 부여하는 것이 좋음
  * 칼럼의 LABEL이 길어지기 때문

### 합성 연산자

```sql
[ORACLE]
SELECT PLAYER_NAME || '선수, ' || HEIGHT || 'CM'
FROM PLAYER;

[SQL SERVER]
SELECT PLAYER_NAME + '선수, ' + HEIGHT + 'CM'
FROM PLAYER;
```

* 문자와 문자를 연결하는 연산자
* 특징
  * 문자와 문자를 연결하는 경우 2개의 수직 바`||`에 의해 이루어짐 (Oracle)
    * SQL Server에서는 `+`표시에 의해 이루어짐
  * 두 벤더 모두 공통적으로 CONCAT(string1, string2) 함수를 사용 가능
  * 칼럼과 문자 또는 다른 칼럼과 연결
  * 문자 표현식의 결과에 의해 새로운 칼럼을 생성