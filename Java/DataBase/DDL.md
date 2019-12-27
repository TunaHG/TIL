# DDL

> Data Definition Language

* `auto commit`이기 때문에 실행 취소가 되지 않고 실행시 바로 `Server`에 적용된다.

## CREATE TABLE

> TABLE을 생성하는 DDL

### Data Type

#### VARCHAR2

> 가변길이 문자형 데이터 타입

* 최대 길이 : 2000 Byte (반드시 길이 지정)
* 다른 타입에 비해 제한이 적다 
* 일부만 입력시 뒷부분은 `NULL `
* 입력한 값의 뒷부분에 있는 `BLANK`도 같이 입력 
* 전혀 값을 주지 않으면 `NULL` 상태 입력 
* 지정된 길이보다 길면 입력시 에러 발생 
* 컬럼 길이의 편차가 심한 경우, `NULL`로 입력되는 경우가 많은 경우 `VARCHAR2` 사용
* 한글로 작성하면 20Byte일 경우 10글자보다 적게 들어감

#### NUMBER

> 숫자형 데이타 타입, 음수, ZERO, 양수 저장 

- 전체 자리수는 38자리를 넘을 수 없다 
- 소수점이 지정되지 않았을 때 소수점이 입력되거나, 지정된 소수점자리 이상 입력되면 반올림되어 저장 
- 지정한 정수 자리수 이상 입력시 에러 발생 
- 연산이 필요한 컬럼은 `NUMBER`타입으로 지정한다. 
- `NUMBER(p,s)` 로 지정시 `p`는 `s`의 자리수를 포함한 길이므로 감안하여 P의 자리수를 결정 
- `NUMBER` 타입은 항상 가변길이므로 충분하게 지정할 것 

#### DATE

> 일자와 시간을 저장하는 날짜형 타입 

- 일자나 시간의 연산이 빈번한 경우 사용 
- 포함정보 : 세기, 년도, 월, 일, 시간, 분, 초 
- `NLS_DATE_FORMAT`을 이용하여 국가별 특수성을 해결 
- 특별히 시간을 지정하지 않으면 `00:00:00`로 입력 됨 
- 특별히 일자를 지정하지 않았다면 현재월의 1일로 지정 됨 
- `SYSDATE`는 현재일과 시간을 제공 

### Usage

```sql
create table book(
	bookno	number(5) primary key,
	title	varchar2(40) unique,
	author	varchar2(20),
    price	number(7, 2) check(price>0),
	pubdate	date default sysdate
);
```

* `bookno`에 `primary key`를 선언함으로써 이 `Table`의 `PK`가 되도록 한다.
* `title`에 `unique`를 선언함으로써 중복된 값이 없도록 한다.
* `price`에 `check`를 선언함으로써 조건에 충족하는 값만 입력되도록 한다.
* `pubdate`에 `default sysdate`를 선언함으로써 아무것도 입력되지 않으면 `null`값이 아닌 `sysdate`를 입력하도록 한다.

### COPY TABLE

> 기존에 존재하는 table을 그대로 복사하는 방법

```sql
create table emp2 as select * from emp;
```

* `as`를 사용한 후 뒤에 `query`를 작성하여 `query`에서 출력되는 `table` 그대로 새로운 `table`을 만든다.
* `emp Table`이 그대로 복사되어 입력되지만 `PK`와 `FK`등의 설정은 복사되지 않는다.

## DROP TABLE

> TABLE을 삭제하는 DDL

## Usage

```sql
drop table book;
```

## ALTER TABLE

> TABLE을 변경하는 DDL

### Add

> Column을 추가하는 기능

```sql
SQL> alter table book add(price number(7));

Table altered.
```

### Modify

> Column의 Data Type을 수정하는 기능

```sql
SQL> alter table book modify(price number(7, 2));

Table altered.
```

### Drop

> Column을 삭제하는 기능

```sql
SQL> alter table book drop column price;

Table altered.
```

### Constraint

> 제약조건을 만들고, 삭제하는 기능

#### Add

```sql
SQL> alter table book add constraint book_pk primary key(bookno);

Table altered.
```

* `constraint` 키워드를 사용함으로써 제약조건을 설정할 수 있다.

* `book_pk`는 제약조건의 이름이며 제약 조건은 `bookno`를 `primary key`로 만드는 것이다.

* `foreign key`는 `primary key`와 다르게 `references`를 추가해줘야 한다.

  ```sql
  alter table emp2 add constraint emp2_fk_deptno 
  foreign key(deptno) references dept2;
  ```

#### Drop

```sql
SQL> alter table book drop constraint book_pk;

Table altered.
```

* 선언된 제약조건의 이름을 이용하여 제약조건을 삭제한다.

## RENAME

> Table의 이름을 변경하는 DDL

### Usage

```sql
SQL> rename book to book2;

Table renamed.
```

## TRUNCATE

> Table 구조는 보존하고 data(내용)을 삭제하는 DDL

### Usage

```sql
SQL> truncate table book2;

Table truncated.
```

# Codes

* [DDL Codes](https://github.com/TunaHG/Database/blob/master/SQL/7_DDL.sql)