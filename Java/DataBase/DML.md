# DML

> Data Manipulation Language

* `auto commit`이 아니기 때문에 실행해도 바로 다른 위치에서 확인이 불가능하다.
  * `Eclipse`에서 `SQL`을 사용하면 `auto commit`이 활성화 되어있는 상태이다.

## INSERT

> TABLE에 VALUE를 넣을 때 사용하는 DML

### Usage

```sql
SQL> insert into book (bookno, title, author, pubdate)
  2  values(1, 'java', '홍길동', sysdate);

1 row created.
```

* `into`를 사용하여 어떤 `table`에 `insert`를 진행할 것인지 명시한다.

* `values`를 사용하여 `table`에 어떤 `data`를 넣을 것인지 명시한다.

  * 이 때 명시되는 순서는 `into`에 명시된 순서로 명시한다.

* `into`에서 `Column`을 명시할 때 모든 `Column`을 명시하지 않아도 된다.

  ```sql
  insert into book (bookno, title) values(4, 'html5');
  insert into book values(1, 'java', '홍길동', sysdate);
  ```

  * 전체를 명시하지 않고 일부분만 명시하면 명시되지 않은 부분은 `null`값이 들어간다.
  * `into`에서 `Column`을 명시하지 않으면 `table`이 만들어질 때 선언된 순서대로 들어간다.

* `PK`에 해당하는 `Column`값을 기존에 존재하는 값과 동일한 값으로 추가하면 `Error`가 발생

  ```sql
  SQL> insert into dept (deptno, dname, loc) values (10, 'EDU', 'SEOUL');
  insert into dept (deptno, dname, loc) values (10, 'EDU', 'SEOUL')
  *
  ERROR at line 1:
  ORA-00001: unique constraint (SCOTT.PK_DEPT) violated
  ```

* `PK`에 해당하는 `Column`값을 `null`로 추가하면 `Error`가 발생

  ```sql
  SQL> insert into dept (deptno, dname, loc) values (null, 'EDU', 'SEOUL');
  insert into dept (deptno, dname, loc) values (null, 'EDU', 'SEOUL')
                                                *
  ERROR at line 1:
  ORA-01400: cannot insert NULL into ("SCOTT"."DEPT"."DEPTNO")
  ```

* `FK`에 해당하는 `Column`값에 특정 값을 추가할 때 다른 `Table`의 `PK`에 해당 값이 존재하지 않는 경우 `Error` 발생

  ```sql
  SQL> insert into emp(empno, ename, sal, deptno) values (999, '홍', 2100, 90);
  insert into emp(empno, ename, sal, deptno) values (999, '홍', 2100, 90)
  *
  ERROR at line 1:
  ORA-02291: integrity constraint (SCOTT.FK_DEPTNO) violated - parent key not found
  ```

## COMMIT

> Commit되지 않은 항목들을 Commit해준다.

### Usage

```sql
SQL> commit;

Commit complete.
```

## Rollback

> Commit되지 않은 항목들에 대하여 취소한다.

### Usage

```sql
SQL> rollback;

Rollback complete.
```

## Delete

> Row를 삭제할 때 사용하는 DML

### Usage

```sql
SQL> delete from book;

3 rows deleted.
```

* `where`절이 포함되어 있지 않다면, 모든 `Row`를 삭제한다.

* `where`절을 선언하여 조건식을 이용하여 특정 `Row`를 삭제한다.

  ```sql
  SQL> delete from book where bookno=4;
  
  1 row deleted.
  ```

  * 만약 `where`절에 선언한 조건문에 해당하는 `Row`가 없다면 `0 row deleted.`가 표시된다.

## Update

> `Row`의 특정 `Column`을 수정할 때 사용하는 DML

### Usage

```sql
SQL> update book set title='~~~~~';

3 rows updated.
```

* `delete`와 마찬가지로 `where`절이 포함되어 있지 않다면 모든 `Row`를 수정한다.

* `where`절을 선언하여 조건식을 이용하여 특정 `Row`를 수정한다.

  ```sql
  SQL> update book set title='~~~~~' where bookno=3;
  
  1 row updated.
  ```

* 또한 여러 개의 `Column`에 대해서도 한번에 수정할 수 있다.

  ```sql
  SQL> update book set title='~~~~~~', author='kim' where bookno=1;
  
  1 row updated.
  ```


# Codes

* [DML Codes](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/SQL/08_DML.sql)