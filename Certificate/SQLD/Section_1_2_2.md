# 정규화와 성능

## 정규화를 통한 성능 향상 전략

* 기본적으로 데이터에 대한 중복성을 제거하여 주고 데이터가 관심사별로 처리되는 경우가 많기 때문에 성능이 향상
* 엔터티가 계속 발생되므로 SQL문장에서 조인이 많이 발생하여 이로 인한 성능저하가 나타나는 경우도 있음
  * 사례별로 유의하여 반정규화를 적용
* 데이터베이스에서 데이터를 처리할 때 성능은 조회성능과 입력/수정/삭제 성능으로 구분
  * 정규화 수행 모델은 데이터를 입력/수정/삭제할 때 일반적으로 반정규화된 테이블에 비해 처리 성능이 향상
  * 데이터를 조회할 때에는 처리 조건에 따라 조회 성능이 향상될 수도 있고 저하될 수도 있음
    * 반정규화만이 조회 성능을 향상시킨다는 고정관념은 탈피해야함

## 반정규화된 테이블의 성능저하 사례

### 2차 정규화를 적용한 테이블의 경우

* PK가 걸려있는 방향으로 조인이 걸려 Unique Index를 곧바로 찾아서 데이터를 조회
  * 하나의 테이블에서 조회하는 작업과 비교했을 때 미미한 성능 차이

### 2개의 엔터티가 통합되어 반정규화된 경우

* 정규화를 진행하면 드라이빙 되는 대상 테이블의 데이터가 줄어들어 조회 처리가 빨라질 수 있음

### 동일한 속성 형식을 두 개 이상의 속성으로 나열하여 반 정규화한 경우

* 인덱스가 많아지면 조회 성능은 향상되지만 입력/수정/삭제 성능은 저하됨
  * 가급적 7~8개를 넘지 않도록 하는 것이 좋음
* 인덱스가 많은 모델은 1차 정규화를 진행하여 중복속성에 대한 분리를 진행

## 함수적 종속성에 근거한 정규화 수행 필요

* **함수의 종속성**은 데이터들이 어떤 기준값에 의해 종속되는 현상을 지칭
  * 기준값을 **결정자**, 종속되는 값을 **종속자**라고 함
* 함수의 종속성은 데이터가 가지고 있는 근본적인 속성으로 인식
* 기본적으로 데이터는 속성간의 함수종속성에 근거하여 정규화되어야 함