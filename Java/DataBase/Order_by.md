# Order by

> 특정 COLUMN에 대하여 정렬을 진행하는 기능

## Usage

```sql
select ename, sal from emp order by sal;
```

* `sal`을 오름차순으로 정렬한다.

* 내림차순으로 정렬하고 싶다면 뒤에 `desc`만 추가해주면 된다.

  ```sql
  select ename, sal from emp order by sal desc;
  ```

* `order by`로 정렬되는 기준은 여러가지가 될 수 있다.

  ```sql
  select ename, sal, comm from emp order by sal desc, comm desc;
  ```

  * 앞에 있는 기준이 먼저 적용되어 `sal`을 기준으로 정렬한 후 `sal`이 같은 값들을 정렬할 때 `comm`을 사용한다.

* 꼭 정렬되는 기준을 출력하지 않아도 괜찮다.

  ```sql
  select ename from emp order by sal;
  ```

* `Select`로 호출하는 `{Column}`에 대하여 순서로 `order by`를 진행할 수 있다.

  ```sql
  select ename, sal, sal + nvl(comm, 0) from emp order by 2;
  ```

  * 2번째 `{Column}`인 `sal`을 기준으로 정렬한다.

# Codes

* [Order By](https://github.com/TunaHG/Database/blob/master/SQL/3_Orderby.sql)