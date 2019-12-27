# View

>  하나의 가상 테이블

## Usage

```sql
create or replace view max_dept
as
select * from emp 
where (deptno, sal) in (select deptno, max(sal) from emp group by deptno)
order by deptno;
```

* `create or replace`는 생성하거나 이미 생성되어 있다면 대체하도록 하는 키워드다.
* `view`를 선언해 줌으로써 `max_dept`라는 `view`에 대한 명령을 실행한다.
* `as`이후에 `Query`문을 선언함으로써 `Query`문으로 나오는 결과를 `view`로 만든다.

## Feature

* 실제 데이터가 저장 되는 것은 아니지만 `View`를 통해 데이터를 관리 할수 있다. 
* 복잡한 `Query`를 통해 얻을 수 있는 결과를 간단한 `Query`로 얻을 수 있게 한다. 
* 한 개의 뷰로 여러 테이블에 대한 데이터를 검색 할 수 있다. 
* 특정 평가 기준에 따른 사용자 별로 다른 데이터를 액세스할 수 있도록 한다. 

# Codes

* [View](https://github.com/TunaHG/Database/blob/master/SQL/09_view.sql)