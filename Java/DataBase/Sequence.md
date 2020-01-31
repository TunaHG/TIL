# Sequence

> 유일(Unique)한 값을 생성해주는 오라클 객체

## Usage

```sql
create sequence dept_seq;
```

* `Sequence`를 생성한다.

```sql
select dept_seq.currval from dual;
```

* `currval`은 현재 `Sequence`가 어떤 값인지를 볼 수 있다.

```sql
select dept_seq.nextval from dual;
```

* `nextval`은 `Sequence`의 다음 값을 의미한다.

## Parameter

- `START WITH` : 시퀀스의 시작 값을 지정한다. 
- `INCREMENT BY` : 시퀀스의 증가 값을 지정한다
- `MAXVALUE` : 시퀀스 최대값
- `MINVALUE` : 시퀀스 최소값
- `CYCLE|NOCYCLE` : 최대값 도달시 순환 여부
- `CACHE|NOCACHE` : `CACHE` 여부, 원하는 숫자만큼 미리 만들어 `Shared Pool`의 `Library Cache`에 상주시킨다.

## Feature

* 시퀀스를 생성하면 기본키와 같이 순차적으로 증가하는 컬럼을 자동적으로 생성 할 수 있다. 
* 보통 `PRIMARY KEY` 값을 생성하기 위해 사용 한다.
* 메모리에 `Cache`되었을 때 시퀀스값의 액세스 효율이 증가한다.
* 시퀀스는 테이블과는 독립적으로 저장되고 생성된다.

# Codes

* [Sequence](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/SQL/10_Sequence.sql)