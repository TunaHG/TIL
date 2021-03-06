# 대량 데이터에 따른 성능

## 대량 데이터 발생에 따른 테이블 분할 개요

* 대량의 데이터가 하나의 테이블에 집약되어 있고 하나의 하드웨어 공간에 저장되어 있으면 성능저하를 피하기 어려움
* 대량의 데이터가 존재하는 테이블에 많은 트랜잭션이 발생하여 성능이 저하되는 테이블 구조에 대해 수평/수직 분할 설계를 통해 성능저하를 예방
* 하나의 테이블에 대량의 데이터가 존재하는 경우
  * 인덱스의 Tree구조가 너무 커져서 효율성이 떨어져 데이터를 처리할 때 디스크 I/O를 많이 유발
  * SQL문장에서 데이터를 처리하기 위한 I/O의 양이 증가하기 때문에 성능 저하
  * 인덱스를 생성할 때 인덱스의 크기가 커지게 되고 그렇게 되면 인덱스를 찾아가는 단계가 깊어지게 되어 조회의 성능에도 영향을 미침
* 한 테이블에 많은 수의 칼럼이 존재하는 경우
  * 데이터가 디스크의 여러 블록에 존재하므로 인해 디스크에서 데이터를 읽는 I/O양이 많아지게 되어 성능 저하
  * 물리적인 디스크의 여러 블록에 데이터가 저장됨
    * 여러 블록에서 데이터를 I/O해야 하는 SQL 문장의 성능이 저하될 수 있음
  * 많은 수의 칼럼은 로우체이닝과 로우마이그레이션이 많아지게 되어 성능이 저하됨
    * 데이터 블록 하나에 데이터가 모두 저장되지 않고 두 개 이상의 블록에 걸쳐 하나의 로우가 저장되는 형태인 **로우 체이닝**
    * 데이터 블록에서 수정이 발생하면 수정된 데이터를 해당 데이터 블록에서 저장하지 못하고 다른 블록의 빈 공간을 찾아 저장하는 방식인 **로우마이그레이션**

## 한 테이블에 많은 수의 칼럼을 가지고 있는 경우

* 물리적으로 칼럼의 값이 블록에 넓게 산재되어 있어 디스크 I/O가 많이 발생
* 트랜잭션이 발생될 때 어떤 칼럼에 대해 집중적으로 발생하는지 분석하여 테이블을 분리하면 디스크 I/O가 감소하게 되어 성능이 개선
  * 분리된 테이블은 디스크에 적어진 칼럼이 저장이 되므로 로우마이그레이션과 로우체이닝이 많이 줄어듬

## 대량 데이터 저장 및 처리로 인한 성능

* 테이블에 많은 양의 데이터가 예상될 경우 파티셔닝을 적용하거나 PK에 의해 테이블을 분할하는 방법을 적용
* 논리적으로는 하나의 테이블로 보이지만 물리적으로 여러 개의 테이블 스페이스에 쪼개어 저장될 수 있는 구조의 파티셔닝을 적용
* 데이터의 양이 대용량이 되면 파티셔닝의 적용은 필수적

### RANGE PARTITION

* 가장 많이 사용하는 파티셔닝의 기준
* 대상 테이블이 날짜 또는 숫자값으로 분리가 가능하고 각 영역별로 트랜잭션이 분리된다면 적용
  * 월 단위로 데이터 처리를 진행하는 요금테이블 등
* 데이터 보관주기에 따라 테이블에 데이터를 쉽게 지우는 것이 가능하므로 관리가 용이
  * 파티션 테이블을 Drop하면 되므로

### LIST PARTITION

* 핵심적인 코드값으로 PK가 구성되어 있다면 값 각각에 의해 파티셔닝이 되는 LIST PARTITION을 적용
* 대용량 데이터를 특정값에 따라 분리 저장

### HASG PARTITION

* 지정된 HASH 조건에 따라 해슁 알고리즘이 적용되어 테이블이 분리
* 설계자는 테이블에 데이터가 정확하게 어떻게 들어갔는지 알 수 없음

## 테이블에 대한 수평분할/수직분할의 절차

* 데이터 모델링을 완성
* 데이터베이스 용량산정
  * 어느 테이블에 데이터의 양이 대용량이 되는지 분석하는 것
* 대량 데이터가 처리되는 테이블에 대해서 트랜잭션 처리패턴 분석
* 집중화된 처리가 칼럼 단위 혹은 로우 단위로 발생되는지 분석하여 해당 단위로 테이블을 분리하는 것을 검토
  * 칼럼의 수가 많은 경우 트랜잭션의 특성에 따라 테이블을 분리할 수 있는지 검증
  * 칼럼의 수가 적지만 데이터 용량이 많아 성능저하가 예상되는 경우 파티셔닝 전략을 고려