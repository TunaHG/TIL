# 그룹 함수(GROUP FUNCTION)

## 데이터 분석 개요

* ANSI/ISO SQL 표준은 데이터 분석을 위해 세 가지 함수를 정의
  * AGGREGATE FUNCTION
  * GROUP FUNCTION
  * WINDOW FUNCTION
* **AGGREGATE FUNCTION**
  * GROUP AGGREGATE FUNCTION이라고도 부르며, GROUP FUNCTION의 한 부분으로 분류 가능
* **GROUP FUNCTION**
  * 하나의 SQL로 테이블을 한 번만 읽어서 빠르게 원하는 리포트를 작성할 수 있음
  * ROLLUP 함수
    * 소그룹 간의 소계를 계산
    * GROUP BY의 확장된 형태
    * 사용하기가 쉬움
    * 병렬로 수행이 가능
    * 시간 및 지역처럼 계층적 분류를 포함하고 있는 데이터의 집계에 적합
  * CUBE 함수
    * GROUP BY 항목들 간 다차원적인 소계를 계산
    * 결합 가능한 모든 값에 대하여 다차원적인 집계를 생성
    * ROLLUP에 비해 다양한 데이터를 얻는 장점
    * 시스템에 부하를 많이 주는 단점
  * GROUPING SETS
    * 특정 항목에 대한 소계를 계산
    * 원하는 부분의 소계만 손쉽게 추출할 수 있는 장점
  * 결과에 대한 정렬이 필요한 경우는 ORDER BY 절에 정렬 칼럼을 명시해야 함
* **WINDOW FUNCTION**
  * 분석 함수(ANALYTIC FUNCTION)나 순위 함수(RANK FUNCTION)로도 알려져 있는 함수
  * 데이터 웨어하우스에서 발전한 기능

## ROLLUP 함수

* ROLLUP에 지정된 Grouping Columns의 List는 Subtotal을 생성하기 위해 사용

  * Grouping Columns의 수를 N이라고 했을 때 N+1 Level의 Subtotal이 생성

* ROLLUP의 인수는 계층 구조이므로 인수 순서가 바뀌면 수행 결과도 바뀌므로 인수의 순서에 주의

* 효과를 알아보기 위해 단계별로 데이터 출력

  1. 일반적인 GROUP BY 절 사용

     ```SQL
     SELECT DNAME, JOB, COUNT(*) "Total Empl", SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO
     GROUP BY DNAME, JOB;
     ```

     * 정렬이 필요한 경우는 ORDER BY 절에 명시적으로 정렬칼럼을 표시

  2. ROLLUP 함수 사용

     ```SQL
     SELECT DNAME, JOB, COUNT(*) "Total Empl", SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO 
     GROUP BY ROLLUP (DNAME, JOB);
     ```

     * 실행 결과 2개의 GROUPING COLUMNS (DNAME, JOB)에 대하여 추가 LEVEL의 집계가 생성되었음
       * L1 : GROUP BY 수행시 생성되는 표준 집계(9건)
       * L2 : DNAME 별 모든 JOB의 SUBTOTAL(3건)
       * L3 : GRAND TOTAL (마지막 행, 1건)
     * ROLLUP의 경우 계층 간 집계에 대해서는 LEVEL 별 순서(L1 -> L2 -> L3)를 정렬
     * 계층 내 GROUP BY 수행시 생성되는 표준 집계에는 별도의 정렬을 지원하지 않음
     * L1, L2, L3 계층 내 정렬을 위해서는 별도의 ORDER BY 절을 사용해야 함

  3. GROUPING 함수 사용

     ```SQL
     SELECT DNAME, GROUPING(DNAME), JOB, GROUPING(JOB), COUNT(*) "Total Empl", SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO 
     GROUP BY ROLLUP (DNAME, JOB);
     ```

     * ROLLUP, CUBE, GROUPING SETS 등 새로운 그룹 함수를 지원하기 위해 추가
     * ROLLUP이나 CUBE에 의한 소계가 계산된 결과에는 `GROUPING(EXPR) = 1`이 표시
     * 그 외의 결과에는 `GROUPING(EXPR) = 0`이 표시

  4. GROUPING 함수 + CASE 사용

     ```SQL
     SELECT 
     	CASE GROUPING(DNAME) WHEN 1 THEN 'All Departments' ELSE DNAME END AS DNAME, 
     	CASE GROUPING(JOB) WHEN 1 THEN 'All Jobs' ELSE JOB END AS JOB, 
     	COUNT(*) "Total Empl", 
     	SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO 
     GROUP BY ROLLUP (DNAME, JOB);
     ```

     * 'All Jobs'와 'All Departments'라는 사용자 정의 텍스트를 확인 가능

  5. ROLLUP 함수 일부 사용

     ```sql
     SELECT 
     	CASE GROUPING(DNAME) WHEN 1 THEN 'All Departments' ELSE DNAME END AS DNAME, 
     	CASE GROUPING(JOB) WHEN 1 THEN 'All Jobs' ELSE JOB END AS JOB, 
     	COUNT(*) "Total Empl", 
     	SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO 
     GROUP BY DNAME, ROLLUP(JOB)
     ```

     * ROLLUP이 JOB에만 사용되었기 때문에 DNAME에 대한 집계는 필요하지 않아서 계산되지 않음

  6. ROLLUP 함수 결합 칼럼 사용

     ```SQL
     SELECT DNAME, JOB, MGR, SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO 
     GROUP BY ROLLUP (DNAME, (JOB, MGR));
     ```

     * 괄호로 묶은 JOB과 MGR의경우 하나의 집합 칼럼으로 간주하여 괄호 내 각 칼럼별 집계를 구하지 않음

## CUBE 함수

* 결합 가능한 모든 값에 대하여 다차원 집계를 생성

* 내부적으로는 Grouping Columns의 순서를 바꾸어서 또 한 번의 Query를 추가 수행해야 함

  * 뿐만 아니라 Grand Total은 양쪽의 Query에서 모두 생성되므로 한 번의 Query에서는 제거되어야만 함
  * ROLLUP에 비해 시스템의 연산 대상이 많음 

* 표시된 인수들에 대한 계층별 집계를 구할 수 있음

  * 표시된 인수들 간에는 계층 구조인 ROLLUP과는 달리 평등한 관계이므로
    인수의 순서가 바뀌는 경우 행간에 정렬 순서는 바뀔 수 있어도 데이터 결과는 같음

* 정렬이 필요한 경우는 ORDER BY 절에 명시적으로 정렬 칼럼이 표시되어야 함

* 예제

  1. CUBE 함수 이용

     ```SQL
     SELECT 
     	CASE GROUPING(DNAME) WHEN 1 THEN 'All Departments' ELSE DNAME END AS DNAME, 
     	CASE GROUPING(JOB) WHEN 1 THEN 'All Jobs' ELSE JOB END AS JOB, 
     	COUNT(*) "Total Empl", 
     	SUM(SAL) "Total Sal" 
     FROM EMP, DEPT 
     WHERE DEPT.DEPTNO = EMP.DEPTNO
     GROUP BY CUBE (DNAME, JOB) ;
     ```

     * CUBE는 Grouping Columns가 가질 수 있는 모든 경우의 수에 대하여 Subtotal을 생성
       * Grouping Columns의 수가 N이라고 가정하면, 2의 N승 Level의 Subtotal을 생성

* CUBE 함수를 사용하며 가장 크게 개선되는 부분

  * EMP, DEPT 테이블을 네번이나 반복 액세스 하는 부분을 CUBE 사용 SQL에서는 한번으로 줄임
  * 업무별 소계와 총계 부분을 CUBE 함수를 사용함으로써 한 번의 액세스만으로 구현
  * 수행 속도 및 자원 사용율을 개선
  * SQL 문장이 더 짧아졌으므로 가독성도 높아짐

## GROUPING SETS

* 더욱 다양한 소계 집합 생성 가능

* GROUP BY SQL 문장을 여러 번 반복하지 않아도 원하는 결과를 쉽게 얻음

* GROUPING SETS에 표시된 인수들에 대한 개별 집계를 구할 수 있음

  * 표시된 인수들 간에는 계층 구조인 ROLLUP과 달리 평등한 관계이므로 인수의 순서가 바뀌어도 결과는 같음

* 정렬이 필요한 경우는 ORDER BY 절에 명시적으로 정렬 칼럼을 표시

* 일반 그룹함수를 이용한 SQL

  ```SQL
  SELECT DNAME, 'All Jobs' JOB, COUNT(*) "Total Empl", SUM(SAL) "Total Sal" 
  FROM EMP, DEPT 
  WHERE DEPT.DEPTNO = EMP.DEPTNO 
  GROUP BY DNAME 
  UNION ALL 
  SELECT 'All Departments' DNAME, JOB, COUNT(*) "Total Empl", SUM(SAL) "Total Sal" 
  FROM EMP, DEPT 
  WHERE DEPT.DEPTNO = EMP.DEPTNO 
  GROUP BY JOB ;
  ```

* GROUPING SETS 사용 SQL

  ```SQL
  SELECT 
  	DECODE(GROUPING(DNAME), 1, 'All Departments', DNAME) AS DNAME, 
  	DECODE(GROUPING(JOB), 1, 'All Jobs', JOB) AS JOB, 
  	COUNT(*) "Total Empl", 
  	SUM(SAL) "Total Sal" 
  FROM EMP, DEPT 
  WHERE DEPT.DEPTNO = EMP.DEPTNO 
  GROUP BY GROUPING SETS (DNAME, JOB);
  ```

  * 위의 일반 그룹함수를 사용한 SQL과 동일한 결과를 얻음
    * 행들의 정렬 순서는 다를 수 있음
  * 괄호로 묶은 집합 별로 집계를 구할 수 있음
    * 괄호 내는 계층 구조가 아닌 하나의 데이터로 간주
    * 괄호 내의 순서가 바뀌어도 결과는 동일함

* 3개의 인수를 이용한 GROUPING SETS 이용

  ```SQL
  SELECT DNAME, JOB, MGR, SUM(SAL) "Total Sal" 
  FROM EMP, DEPT 
  WHERE DEPT.DEPTNO = EMP.DEPTNO 
  GROUP BY GROUPING SETS ((DNAME, JOB, MGR), (DNAME, JOB), (JOB, MGR));
  ```

  * 괄호로 묶은 집합별로 집계를 구함
    * 괄호 내는 계층구조가 아닌 하나의 데이터로 간주