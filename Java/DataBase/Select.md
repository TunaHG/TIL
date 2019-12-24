# Select

> 데이터베이스에서 원하는 데이터를 행단위로 검색, 추출

## Usage

```sql
select {Column} from {Table};
```

* `select`와 `from`은 항상 같이 온다.

* `{Column}`은 여러 개가 올 수 있으며, 산술 연산을 진행할 수 있다.

  ```sql
  select ename, sal, sal * 12 as "연봉" from emp;
  ```

  * `sal`에 12를 곱하는 `Column`을 출력할 수 있다. 또한 `as`를 이용하여 `sal * 12`의 `Column name`을 지정해줄 수 있다. 이 때 `" "`를 이용한다. (이외의 Oracle에서 문자열은 전부 `''`를 사용한다.)

## Select Function

* `distinct` : 중복된 데이터 제외

  ```sql
  select distinct job from emp;
  ```

* `nvl({Column}, {Data})` : `{Column}`이 `Null`이라면 `{Data}`값으로 변경한다.

  ```sql
  select ename, sal, comm, nvl(comm, -1) from emp;
  select ename, sal, comm, sal+nvl(comm, 0) as "총급여" from emp;
  ```

  * 이 때 주의할 점은 `{Data}`의 데이터타입이 해당 `{Column}`의 데이터타입과 일치해야 한다.

* `as` : 해당 `{Column Name}`을 다른 것으로 표시해주는 기능

  * 하지만 `where`절에서 사용할 땐 기존의 `{Column Name}`을 사용해야 한다. `as`로 표시된 이름은 표시만 해주는 것일뿐 `Column Name`이 아니기 때문이다.

* `||` : 문자열 연결 연산자

  ```sql
  select ename || job from emp;
  select ename || ' ' || job from emp;
  ```

  * [Usage](#oracle에서-문자열)에 언급했듯이 `' '`를 이용하여 문자열을 표현한다. `" "`은 Error가 발생한다.

* `Count()` : 개수를 세주는 기능

  ```sql
  select count(ename) from emp;
  ```

## From Function

* `dual` : 가상의 `table`

  ```sql
  select 20*20*4 from dual;
  select sysdate from dual;
  ```

  * 특정 `table`을 입력하면 해당 `table`의 `row`수만큼 값이 출력된다. 해당 값을 단행출력하고 싶을 경우 `dual`이라는 가상의 `table`을 이용하여 출력한다.
  
* `계정명.table` : 다른 계정의 `table`

  ```sql
  select * from SCOTT.emp;
  ```

  * `system`계정에서 `계정명.table`을 사용하여 다른 계정의 `table`에 접근이 가능하며, `system`이 아닌 다른 계정에서는 이런 방식의 접근이 불가능하다.

## Where Function

```sql
select {Column} from {Table} where {Condition}
```

* `where`을 추가하여 `{Table}`내에서 주어진 조건 `{Condition}`에 해당하는 `row`만을 출력할 수 있다.

* `{Condition}`으로 비교할 때 `' '`내의 문자열이 대소문자를 구분하며 `==`이 아닌 `=`을 이용하여 비교를 진행한다.

* `{Condition}`으로 비교할 때 `<`, `>`, `=`, `!=`와 같은 비교연산자 외에도 `<>`가 있으며 이는 `!=`와 같다.

* `between and`를 이용하여 두 값 사이의 값들을 탐색할 수 있다.

  ```sql
  select ename, sal from emp where sal between 2450 and 3000;
  ```

  * `between A and B`는 `A`와 `B` 값을 모두 포함한다.
  * `A`는 항상 `B`보다 작은값이어야 한다.

* `or` 혹은 `and`를 사용하여 해당 연산을 진행한다.

  ```sql
  select ename, job, deptno from emp where deptno = 10 or deptno = 20;
  ```

* `lower()`, `upper()` : 소문자, 대문자로 값을 변경해주는 기능

  ```sql
  select ename, job, deptno from emp where upper(job) = upper('manager');
  ```

* `in()` : `or`연산과 비슷한 연산으로 `{Column}`이 `in()`내부의 값에 포함되는지를 확인하는 기능

  ```sql
  select ename, job, deptno from emp where deptno in(10, 20);
  ```

  * `in()`앞에 오는 `{Column}`은 여러개가 올 수 있다.

    ```sql
    select * from dept where (deptno, loc) in((20, 'DALLAS'), (30, 'CHICAGO'));
    ```

    * `(deptno, loc)`의 두 `Column`은 `and`연산으로 묶여있다.
    * `in()`내부의 `(20, 'DALLAS')`와 `(30, 'CHICAGO')`는 `or`연산으로 묶여있다.

* `like` : 특정 `pattern`이 포함된 `Column`을 가려내는 기능

  ```sql
  select * from emp where ename like '%A%';
  ```

  * `'A%'` : `A`로 시작하는 `Column` 값
  * `'%A'` : `A`로 끝나는 `Column` 값
  * `'%A%'` : A가 문자열 내에 포함된 `Column` 값
  * `'%A__'` : A뒤에 문자열 두 글자가 오는 `Column` 값
  * `'%'` : 어떤 문자열이 몇개든 올 수 있다.
  * `'_'` : 어떤 문자열이 하나만 올 수 있다.
  
* `is null` : 특정 `Column`의 값이 `null`인 `row`를 선택하는 기능

  * `is not null` : 반대로, 값이 `null`이 아닌 `row`를 선택하는 기능

## Order by

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

* [Select](https://github.com/TunaHG/Database/blob/master/SQL/2_Select.sql)