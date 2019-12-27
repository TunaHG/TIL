# Group by

## 집계 함수

* `round()` : 반올림하는 함수
* `avg()` : 평균값을 구하는 함수
* `count()` : `row`의 개수를 세는 함수
* `min()` : 최소값을 찾는 함수
* `max()` : 최대값을 찾는 함수

## Group by

> 특정 Column에 대하여 Group화하여 집계함수에 적용하는 방법

### Usage

```sql
select deptno, round(avg(sal)) from emp group by deptno;
```

* 두 Group에 대하여 `Group by`를 진행할 수 있다.

  ```sql
  select e.deptno, dname, avg(sal), count(*), min(sal), max(sal)
  from emp e, dept d
  where e.deptno = d.deptno
  group by e.deptno, dname;
  ```

### Distinct와의 차이점

* `DISTINCT`를 사용하는 것과 `GROUP BY`를 사용하는 것이 같은 동작을 진행할 때가 있다

  ```sql
  select distinct deptno from emp;
  select deptno from emp group by deptno;
  ```

* 하지만 그렇다고 같은 기능을 수행하는 것이 아니라 각자의 기능이 있기 때문에 조심해야한다.

  * 집계함수를 사용하여 특정 그룹을 구분할 때는 `GROUP BY`
  * 특정 그룹 구분없이 중복된 데이터를 제거할 경우에 `DISTINCT`

## Having

> Where절에서는 집계함수를 사용할 수 없기 때문에 집계함수를 이용하여 조건비교를 할 때 사용한다.
>
> GROUP BY절과 함께 사용한다

* `avg(salary)`를 이용하여 비교할 때 사용한다.

  ```sql
  select e.deptno, dname, round(avg(sal)) AverageSalary
  from emp e, dept d
  where e.deptno = d.deptno
  group by e.deptno, dname
  having avg(sal) > 2000;
  ```

## 주의할 점

* `Group by`된 `Column`이 아닌 다른 `Column`은 `select`에서 집계함수로만 사용할 수 있다.
  * [ORA-00979 Error](./Error/ORA-00979.md)

* `Group by`가 선언되지 않았을 때, `select`에서 `Column`과 집계함수가 같이 쓰일 수 없다.
  * [ORA-00937 Error](./Error/ORA-00937.md)

# Codes

* [Group By](https://github.com/TunaHG/Database/blob/master/SQL/5_Groupby.sql)