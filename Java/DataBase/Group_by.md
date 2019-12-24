# Group by

## 집계 함수

* `round()` : 반올림하는 함수
* `avg()` : 평균값을 구하는 함수

## Group by

> 특정 Column에 대하여 Group화하여 집계함수에 적용하는 방법

### Usage

```sql
select deptno, round(avg(sal)) from emp group by deptno;
```

## 주의할 점

* `Group by`된 `Column`이 아닌 다른 `Column`은 `select`에서 집계함수와 같이 쓸 수 없다.
  * [ORA-00979 Error](./Error/ORA-00979.md)

* `Group by`가 선언되지 않았을 때, `select`에서 `Column`과 집계함수가 같이 쓰일 수 없다.
  * [ORA-00937 Error](./Error/ORA-00937.md)

