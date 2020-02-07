# ROWNUM

## Usage

* Column처럼 취급하여 사용한다.

  ```sql
  select rownum, first_name, hire_date from employees;
  ```

  * hr/hr계정에 존재하는 employees Table을 사용하였으며, 해당 table에는 rownum이란 column은 없다.

* 1을 제외한 나머지 숫자와 >, >=연산이 불가능하다.

  ```sql
  select rownum, first_name, hire_date from employees where rownum>=1 and rownum<=10;
  ```

  * 1과 함께라면 사용이 가능하다.
  * 첫 번째부터 열 번째까지의 행이 출력된다.

  ```sql
  select rownum, first_name, hire_date from employees where rownum>=11 and rownum<=20;
  ```

  * 1과 함께 사용하지 않기때문에 출력이 안된다.

* subquery를 from절에서 사용하여 rownum이 포함된 table에서 rownum의 column명을 r로 변경하여 가져온 후 select절에서 r을 호출하며 where절에서 r의 범위를 지정해주면 된다.

  ```sql
  select r, first_name, hire_date
  from (select rownum r, first_name, hire_date from employees)
  where r >= 11 and r <= 20;
  ```

  * 11번째부터 20번째까지 출력된다.

* hire_date가 가장 최근인 사람부터 조회

  ```sql
  select r, first_name, hire_date
  from (select rownum r, first_name, hire_date
       from (select * from employees order by hire_date desc))
  where r >= 11 and r <= 20;
  ```

  * order by 정렬은 rownum과 같이 사용될 경우 rownum이 생성되고 정렬되기 때문에 원하는대로 안나옴
  * rownum을 사용하기 전에 subquery를 사용하여 정렬을 진행하고 가져온 table에 rownum을 사용한다.