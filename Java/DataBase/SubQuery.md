# SubQuery

> Query내부에 또 하나의 Query가 포함되어 있는 형태

## Usage

```sql
select * from emp where sal > (select sal from emp where ename='FORD');
```

* `'FORD'`의 `salary`보다 많은 `salary`를 받는 직원들의 데이터

* `Subquery`는 `Main query`이전에 한 번 실행된다.
* `Subquery`는 괄호로 묶여있어야 한다.
* 주로 단일 행 연산자(`=`, `>`, `>=`, `<`, `<=`, `<>`, `!=`)와 다중 행 연산자(`IN`, `ANY`, `ALL`, `EXIST`)들과 같이 사용된다.
  * 다중행 연산자를 사용해야 하는 위치에 단일 행 연산자를 사용하면 Error발생([참고](./Error/ORA-01427))

## Rownum

> SELECT절에서 COLUMN처럼 사용하며, ROW에 번호를 부여해주는 기능

* `Paging`처리에 많은 도움이 되는 기능이다.

### Usage

```sql
select rownum, ename, job, sal from emp;
```

* 출력되는 `Row`순서마다 1씩 증가하는 `ROWNUM`이 붙는다.

* `ORDER BY`를 `ROWNUM`이 아닌 다른 `COLUMN`에 적용하면 그에 따라 `ROWNUM`도 섞인다.

  ```sql
  select rownum, ename, job, sal from emp order by sal;
  ```

  * 정렬을 진행한 뒤에 `ROWNUM`을 붙이면 된다.

    ```sql
    select rownum, ename, job, sal from (select * from emp order by sal);
    ```


* `FROM`절에도 `Subquery`가 사용가능하다.

### Paging

* `ROWNUM`을 이용하여 `Paging`을 구현할 수 있다.

* 하지만 `ROWNUM`이 결과에서 1부터 순서대로 증가하여 붙기 때문에 `ROWNUM=2`나 `ROWNUM BETWEEN 6 and 10`과 같은 방식으로는 원하는 결과를 얻을 수 없다.

  * 그래서 `ROWNUM`이 포함된 `query`를 `from`절에 `subquery`로 넣고 `Column Name`을 변경해줌으로 써 사용할 수 있다.

    ```sql
    select *
    from (
    	select rownum row#, ename, job, sal
    	from (select * from emp order by sal desc)
    )
    where row# between 6 and 10;
    ```


# Codes

* [Sub Query](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/SQL/06_SubQuery.sql)