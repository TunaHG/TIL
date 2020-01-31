# Join

> Select로 보여주고 싶은 Column이 다른 Table에 존재할 때, 
>
> Table 여러 개를 결합하여 하나의 큰 Table로 만드는 방법

## 필요성

* 관계형 모델에서는 데이터의 일관성이나 효율을 위하여 데이터의 중복을 최소화
* 외래키(Foreign Key)를 이용하여 참조
* 정규화된 테이블로부터 결합된 형태의 정보를 추출할 필요가 있음

## Cartesian Product

> 두 개 이상의 테이블이 Join될 때, Where절에 공통되는 Column에 의한 Join조건이 선언되지 않아 모든 데이터가 검색 결과로 나타나는 경우

### Usage

```sql
select * from emp, dept;
```

* `Table`에 존재하는 모든 데이터가 검색 결과로 나타난다.
* `emp Column` 8개 + `dept Column` 4개 - `deptno` 공통 `Column` 1개로 총 11개의 `Column`
* `emp Row` 14개 * `dept Row` 4개로 총 56개의 `Row`
* 아무런 의미를 갖지 못한다.

## Equi Join

* `Where`조건문이 필요함
  * 두 테이블에서 그냥 결과를 선택하면 두 테이블의 행들의 가능한 모든 쌍이 추출됨. (Cartesian Product)

### Usage

```sql
select ename, emp.deptno, dname, loc
from emp, dept 
where emp.deptno = dept.deptno;
```

* `from`에 필요로 하는 테이블을 `,`로 구분하여 모두 적는다.
* `Column`명만 사용하면 어느 `Table`에 속하는지 알 수 없기 때문에 모호하다.
  * 이를 막기 위해 `Table.Column`을 사용하여 어떤 `Table`에 속한 `Column`인지 명시한다.
  * [Column이 여러 Table에 존재할 때 발생할 수 있는 Error](./Error/ORA-00918.md)
* 적절한 `join` 조건을 `where`절에 부여(일반적으로 (테이블 개수 -1)개의 조건이 필요)
* 일반적으로 `PK`와 `FK`간의 `=`조건이 붙는 경우가 많음

### ANSI Join

> DB를 가리지 않는 표준 Join

#### Usage

> Cartitoin Product에서 `,`를 `join`으로, `where`을 `on`으로 변경하여 사용한다.
>
> Oracle Join과 ANSI Join을 비교해보며 공부한다.

### Inner Join

> 동일 Column을 기준으로 두 Table을 Join하는 방법

* Oracle Join (= Equi Join)

  ```sql
  select ename, e.deptno, dname, loc
  from emp e, dept d
  where e.deptno = d.deptno;
  ```

* ANSI Join

  ```sql
  select ename, e.deptno, dname, loc
  from emp e join dept d
  on e.deptno = d.deptno;
  
  select ename, e.deptno, dname, loc
  from emp e inner join dept d
  on e.deptno = d.deptno;
  ```

  * `outer`등이 앞에 선언되지 않은 기본 `join`은 `inner join`과 동일하다.

## Outer Join

> Left, Right 둘 중 하나의 Table을 기준으로 하여 다른 Table을 Join하는 방법.

* Oracle Join

  ```sql
  select ename, d.deptno, dname, loc
  from emp e, dept d
  where e.deptno(+) = d.deptno;
  ```

  * `NULL`값이 표시되길 바라는 쪽의 `where`절에 `(+)`를 추가한다.

* ANSI Join

  ```sql
  select ename, e.deptno, dname, loc
  from emp e right outer join dept d
  on e.deptno = d.deptno;
  ```

  * 기준이 되길 원하는 `Table`쪽으로 `from`절에 `left` 혹은 `right`를 추가한다.

## Non Equi Join

> 동일 Column 없이 다른 조건을 사용하여 Join하는 방법

* Oracle Join

  ```sql
  select ename, sal, grade
  from emp, salgrade
  where sal between losal and hisal;
  ```

* ANSI Join

  ```sql
  select ename, sal, grade
  from emp join salgrade
  on sal between losal and hisal;
  ```


## Multiple Join

> n개의 table을 join하는 방법

* Oracle Join

  ```sql
  select ename, sal, dname, grade
  from emp e, salgrade s, dept d
  where e.deptno = d.deptno 
  and sal between losal and hisal;
  ```

* ANSI Join

  ```sql
  select ename, sal, dname, grade
  from emp e join dept d on e.deptno = d.deptno
  		   join salgrade on sal between losal and hisal
  where sal > 1500;
  ```

  * `join`을 한번에 진행하고 `on`을 하는 것이 아닌, 한번의 `join`에 한번의 `on`을 진행하고 다음 `join`을 진행한다.

## Self Join

> 자기 자신 Table을 Join하는 방법.

* Oracle Join

  ```sql
  select e.ename as "Employee Name", m.ename as "Manager Name"
  from emp e, emp m
  where e.mgr = m.empno;
  
  select e.ename as "Employee Name", m.ename as "Manager Name"
  from emp e, emp m
  where e.mgr = m.empno(+);
  ```

* ANSI Join

  ```sql
  select e.ename as "Employee Name", m.ename as "Manager Name"
  from emp e join emp m
  on e.mgr = m.empno;
  
  select e.ename as "Employee Name", m.ename as "Manager Name"
  from emp e left join emp m
  on e.mgr = m.empno;
  ```

* 위의 두 코드처럼 `Self Join`은 `from`절에서 서로 다른 명칭만을 가지고 사용하면 된다.

# Codes

* [Join](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/SQL/04_Join.sql)