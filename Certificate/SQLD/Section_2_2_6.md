# 윈도우 함수(WINDOW FUNCTION)

## WINDOW FUNCTION 개요

* 행과 행간의 관계를 쉽게 정의하기 위해 만든 함수
* 분석 함수(ANALYTIC FUNCTION)나 순위 함수(RANK FUNCTION)로도 알려져 있음
* 데이터 웨어하우스에서 발전한 기능
* 다른 함수와는 달리 중첩(NEST)해서 사용하지는 못하지만, 서브쿼리에서는 사용 가능

### WINDOW FUNCTION 종류

* 크게 다섯 그룹으로 분류할 수 있는데 벤더별로 지원하는 함수에는 차이가 있음
* 그룹 내 순위(RANK) 관련 함수
  * RANK, DENSE_RANK, ROW_NUMBER
  * 대부분의 DBMS에서 지원
* 그룹 내 집계(AGGREGATE) 관련 함수
  * SUM, MAX, MIN, AVG, COUNT
  * 대부분의 DBMS에서 지원
    * SQL Server의 경우 집계 함수는 뒤에서 설명할 OVER 절 내의 ORDER BY 구문을 지원하지 않음
* 그룹 내 행 순서 관련 함수
  * FIRST_VALUE, LAST_VALUE, LAG, LEAD
  * Oracle에서만 지원되는 함수
    * FIRST_VALUE, LAST_VALUE 함수는 MAX, MIN함수와 비슷한 결과를 얻을 수 있음
    * LAG, LEAD 함수는 DW에서 유용하게 사용되는 기능
* 그룹 내 비율 관련 함수
  * CUME_DIST, PERCENT_RANK, NTILE, RATIO_TO_REPORT
  * CUME_DIST, PERCENT_RANK 함수는 ANSI/ISO SQL 표준과 Oracle DBMS에서 지원
  * NTILE 함수는 ANSI/ISO SQL 표준에는 없지만 Oracle, SQL Server에서 지원
  * RATIO_TO_REPORT 함수는 Oracle에서만 지원되지만 현업에서 유용한 기능을 구현하는데 참조
* 선형 분석을 포함한 통계 분석 관련 함수
  * 통계에 특화된 기능
  * Oracle의 통계 관련 함수
    * CORR, COVAR_POP, COVAR_SAMP, STDDEV, STDDEV_POP, STDDEV_SAMP, VARIANCE, VAR_POP, VAR_SAMP, REGR_(LINEAR REGRESSION), REGR_SLOPE, REGR_INTERCEPT, REGR_COUNT, REGR_R2, REGR_AVGX, REGR_AVGY, REGR_SXX, REGR_SYY, REGR_SXY

### WINDOW FUNCTION SYNTAX

* WINDOW 함수에는 OVER 문구가 키워드로 필수 포함

  ```SQL
  SELECT WINDOW_FUNCTION (ARGUMENTS) OVER 
  ( [PARTITION BY 칼럼] [ORDER BY 절] [WINDOWING 절] ) 
  FROM 테이블 명;
  ```

* WINDOW_FUNCTION

  * 기존에 사용하던 함수도 있고, 새롭게 WINDOW 함수용으로 추가된 함수도 존재

* ARGUMENTS (인수)

  * 함수에 따라 0 ~ N개의 인수가 지정될 수 있음

* PARTITION BY 절

  * 전체 집합을 기준에 의해 소그룹으로 나뉨

* ORDER BY 절

  * 어떤 항목에 대해 순위를 지정할 지 ORDER BY 절을 기술

* WINDOWING 절

  * 함수의 대상이 되는 행 기준의 범위를 강력하게 지정
  * ROWS는 물리적인 결과 행의 수를 RANGE는 논리적인 값에 의한 범위를 나타냄
    * 둘 중의 하나를 선택해서 사용 가능
  * SQL Server에서는 지원하지 않음

  ```SQL
  BETWEEN 사용 타입 
  ROWS | RANGE BETWEEN 
  	UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING 
  AND
  	UNBOUNDED FOLLOWING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
  
  BETWEEN 미사용 타입 
  ROWS | RANGE 
  	UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING
  ```

## 그룹 내 순위 함수

### RANK 함수

* ORDER BY를 포함한 QUERY 문에서 특정 항목(칼럼)에 대한 순위를 구하는 함수

  * 특정 범위(PARTITION) 내에서 순위를 구할 수도 있고 전체 데이터에 대한 순위를 구할 수도 있음
  * 동일한 값에 대해서는 동일한 순위를 부여

* 예제

  ```SQL
  SELECT JOB, ENAME, SAL, 
  	RANK( ) OVER (ORDER BY SAL DESC) ALL_RANK, 
  	RANK( ) OVER (PARTITION BY JOB ORDER BY SAL DESC) JOB_RANK 
  FROM EMP;
  ```

  * ALL_RANK에서 동일한 SALARY는 같은 순위를 부여
  * 업무를PARTITION으로 구분한 JOB_RANK의 경우 같은 업무 내 범위에서만 순위를 부여
  * 하나의 SQL 문장에 ORDER BY SAL DESC 조건과 PARTITION BY JOB 조건이 충돌이 났기 때문에
    JOB 별로는 정렬이 되지 않고 ORDER BY SAL DESC 조건으로 정렬됨

### DENSE_RANK 함수

* RANK 함수와 흡사하나, 동일한 순위를 하나의 건수로 취급하는 것이 다른 점

* 예제

  ```SQL
  SELECT JOB, ENAME, SAL, 
  	RANK( ) OVER (ORDER BY SAL DESC) RANK, 
  	DENSE_RANK( ) OVER (ORDER BY SAL DESC) DENSE_RANK 
  FROM EMP;
  ```

  * 동일한 SALARY에는 RANK, DENSE_RANK 칼럼 모두 같은 순위를 부여

### ROW_NUMBER 함수

* 동일한 값이라도 고유한 순위를 부여

* 예제

  ```SQL
  SELECT JOB, ENAME, SAL, 
  	RANK( ) OVER (ORDER BY SAL DESC) RANK, 
  	ROW_NUMBER() OVER (ORDER BY SAL DESC) ROW_NUMBER 
  FROM EMP;
  ```

  * 동일한 SALARY에서 RANK는 같은 순위를 부여하지만 ROW_NUMBER의 경우 유니크한 순위를 정함

    * 같은 SALARY에서는 어떤 순서가 정해질지 알수 없음
    * Oracle의 경우 rowid가 적은 행이 먼저 나옴

  * 동일 값에 대한 순서까지 관리하고 싶다면

    `ROW_NUMBER() OVER (ORDER BY SAL DESC, ENAME)`같이 ORDER BY 절을 이용해 추가적인 정렬 기준을 정의

## 일반 집계 함수

### SUM 함수

* 파티션별 윈도우의 합을 구할 수 있음

* 예제

  ```SQL
  SELECT MGR, ENAME, SAL, SUM(SAL) OVER (PARTITION BY MGR) MGR_SUM
  FROM EMP;
  ```

### MAX 함수

* 파티션별 윈도우의 최대값을 구할 수 있음

* 예제

  ```SQL
  SELECT MGR, ENAME, SAL, MAX(SAL) OVER (PARTITION BY MGR) AS MGR_MAX
  FROM EMP;
  ```

  * 파티션 내의 최대값을 파티션 내의 모든 행에서 MGR_MAX라는 칼럼 값으로 가짐

### MIN 함수

* 파티션별 윈도우의 최소값을 구할 수 있음

* 예제

  ```SQL
  SELECT MGR, ENAME, HIREDATE, SAL,
  	MIN(SAL) OVER (PARTITION BY MGR ORDER BY HIREDATE) AS MGR_MIN
  FROM EMP;
  ```

### AVG 함수

* AVG 함수와 파티션별 ROWS 윈도우를 이용해 원하는 조건에 맞는 데이터에 대한 통계값을 구할 수 있음

* 예제

  ```SQL
  SELECT MGR, ENAME, HIREDATE, SAL, 
  	ROUND (AVG(SAL) OVER (PARTITION BY MGR ORDER BY HIREDATE ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)) as MGR_AVG 
  FROM EMP; 
  
  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING :
  ```

  * 현재 행을 기준으로 파티션 내에서 앞의 한건, 현재 행, 뒤의 한 건을 범위로 지정
    * ROWS는 현재 행의 앞뒤 건수를 말하는 것
  * 첫 번째 데이터의 경우 본인의 데이터와 뒤의 한 건으로 평균값을 구함
  * 마지막 데이터의 경우 앞의 한 건과 본인의 데이터로 평균값을 구함

### COUNT 함수

* COUNT 함수와 파티션별 ROWS 윈도우를 이용해 원하는 조건에 맞는 데이터에 대한 통계값을 구할 수 있음

* 예제

  ```SQL
  SELECT ENAME, SAL, 
  	COUNT(*) OVER (ORDER BY SAL RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING) as SIM_CNT 
  FROM EMP; 
  
  RANGE BETWEEN 50 PRECEDING AND 150 FOLLOWING 
  ```

  * 현재 행의 급여값을 기준으로 급여가 -50에서 +150의 범위 내에 포함된 모든 행이 대상
    * RANGE는 현재 행의 데이터 값을 기준으로 앞뒤 데이터 값의 범위를 표시하는 것
  * 위의 예제에서는 파티션이 지정되지 않았으므로 모든 건수를 대상으로 기준에 맞는지 검사함
  * ORDER BY SAL로 정렬이 되어 있으므로 비교 연산이 쉬워짐

## 그룹 내 행 순서 함수

### FIRST_VALUE 함수

* 파티션별 윈도우에서 가장 먼저 나온 값을 구함

* SQL Server에서는 지원하지 않는 함수

  * MIN 함수를 활용하여 같은 결과를 얻을 수 있음

* 예제

  ```SQL
  SELECT DEPTNO, ENAME, SAL, 
  	FIRST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) as DEPT_RICH 
  FROM EMP; 
  
  RANGE UNBOUNDED PRECEDING
  ```

  * 현재 행을 기준으로 파티션 내의 첫 번째 행까지의 범위를 지정
  * 공동 등수를 인정하지 않고 처음 나온 행만을 처리함
    * 의도적으로 세부 항목을 정렬하고 싶다면 별도의 정렬 조건을 가진 INLINE VIEW를 사용하거나 OVER () 내의 ORDER BY 절에 칼럼을 추가

### LAST_VALUE 함수

* 파티션별 윈도우에서 가장 나중에 나온 값을 구함

* SQL Server에서는 지원하지 않는 함수

  * MAX 함수를 활용하여 같은 결과를 얻을 수 있음

* 예제

  ```SQL
  SELECT DEPTNO, ENAME, SAL, 
  	LAST_VALUE(ENAME) OVER (PARTITION BY DEPTNO ORDER BY SAL DESC 
                              ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) as DEPT_POOR 
  FROM EMP; 
  
  ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING:
  ```

  * 현재 행을 포함해서 파티션 내의 마지막 행까지의 범위를 지정
  * 공동 등수를 인정하지 않고 가장 나중에 나온 행만을 처리
    * 의도적으로 세부 항목을 정렬하고 싶다면 별도의 정렬 조건을 가진 INLINE VIEW를 사용하거나 OVER () 내의 ORDER BY 절에 칼럼을 추가

### LAG 함수

* 파티션별 윈도우에서 이전 몇 번째의 행의 값을 가져올 수 있음

* SQL Server에서는 지원하지 않는 함수

* 예제

  ```SQL
  SELECT ENAME, HIREDATE, SAL,
  	LAG(SAL) OVER (ORDER BY HIREDATE) as PREV_SAL 
  FROM EMP 
  WHERE JOB = 'SALESMAN';
  ```

  * LAG 함수는 3개의 ARGUMENTS를 사용 가능
    * 두 번째 인자는 몇 번째 앞의 행을 가져올지 결정하는 숫자 (DEFAULT 1)
    * 세 번째 인자는 NULL값이 들어오는 경우 어떤 값으로 변경할지 결정하는 값 (NVL, ISNULL과 같음)

### LEAD 함수

* 파티션별 윈도우에서 이후 몇 번째 행의 값을 가져올 수 있음

* SQL Server에서는 지원하지 않는 함수

* 예제

  ```SQL
  SELECT ENAME, HIREDATE, 
  	LEAD(HIREDATE, 1) OVER (ORDER BY HIREDATE) as "NEXTHIRED" 
  FROM EMP;
  ```

  * LEAD 함수는 3개의 ARGUMENTS를 사용 가능
    * 두 번째 인자는 몇 번째 후의 행을 가져올지 결정하는 숫자 (DEFAULT 1)
    * 세 번째 인자는 NULL값이 들어오는 경우 어떤 값으로 변경할지 결정하는 값 (NVL, ISNULL과 같음)

## 그룹 내 비율 함수

### RATIO_TO_REPORT 함수

* 파티션 내 전체 SUM(칼럼)값이 대한 행별 칼럼 값의 백분율을 소수점으로 구할 수 있음

  * 결과 값은 `> 0 & <= 1`의 범위를 가짐
  * 개별 RATIO의 합을 구하면 1

* SQL Server에서는 지원하지 않는 함수

* 예제

  ```SQL
  SELECT ENAME, SAL, 
  	ROUND(RATIO_TO_REPORT(SAL) OVER (), 2) as R_R 
  FROM EMP 
  WHERE JOB = 'SALESMAN';
  ```

### PERCENT_RANK 함수

* 파티션별 윈도우에서 제일 먼저 나오는 것을 0으로, 제일 늦게 나오는 것을 1로 하여, 값이 아닌 행의 순서별 백분율을 구함

  * 결과 값은 `> 0 & <= 1`의 범위를 가짐

* SQL Server에서는 지원하지 않는 함수

* 예제

  ```SQL
  SELECT DEPTNO, ENAME, SAL, 
  	PERCENT_RANK() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) as P_R 
  FROM EMP;
  ```

  * N건이라면 구간은 N-1개가 됨, 0과 1사이를 N - 1개의 구간으로 나눔

### CUME_DIST

* 파티션별 윈도우의 전체 건수에서 현재 행보다 작거나 같은 건수에 대한 누적백분율을 구함

  * 결과 값은 `> 0 & <= 1`의 범위를 가짐

* SQL Server에서는 지원하지 않는 함수

* 예제

  ```SQL
  SELECT DEPTNO, ENAME, SAL, 
  	CUME_DIST() OVER (PARTITION BY DEPTNO ORDER BY SAL DESC) as CUME_DIST 
  FROM EMP;
  ```

  * N건이라면 1을 N으로 나눈 값으로 누적 백분율을 구함

### NTILE 함수

* 파티션별 전체 건수를 ARGUMENT 값으로 N 등분한 결과를 구함

* 예제

  ```SQL
  SELECT ENAME, SAL, 
  	NTILE(4) OVER (ORDER BY SAL DESC) as QUAR_TILE 
  FROM EMP
  ```

  * `NTILE(4)`의 의미는 14명의 팀원을 4개 조로 나눈다는 의미
    * 몫이 3명, 나머지가 2명이 되는데 나머지 두명은 앞의 조부터 할당하여 4명 + 4명 + 3명 + 3명으로 조를 나눔