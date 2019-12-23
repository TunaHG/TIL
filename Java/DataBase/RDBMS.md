# RDBMS

> Relational Database Management System

## 구성요소

* 테이블(Table)

  ![image-20191223172804494](image/image-20191223172804494.png)

* 특별한 의미를 가진 Column, Key

  * 기본키(PK : Primary Key)

    ![image-20191223172913987](image/image-20191223172913987.png)

    * 다른 `Row`들과 구분되는 중복되지 않는 값을 가진 `Column`

  * 후보키 & 보조키(Alternate Key)

    ![image-20191223173021054](image/image-20191223173021054.png)

  * 외래키(FK : Foreign Key)

    ![image-20191223173104476](image/image-20191223173104476.png)

    * 다른 `Table`을 참조하는 `Key`, 다른 `Table`에서 `PK`역할을 진행하는 `Key`여야 한다.

  * 복합키

    ![image-20191223173152540](image/image-20191223173152540.png)