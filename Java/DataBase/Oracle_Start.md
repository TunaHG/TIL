# Oracle 11g

## Download

1. Database Download (19/12/23 기준)

   * [Database Express Edition Download](https://www.oracle.com/database/technologies/xe-downloads.html) 이 링크에서 최신 버전을 다운받을 수 있다. 하지만 Eclipse를 받을 때처럼 이전 버전을 다운로드 받는다.
* [Prior Release Archieve](https://www.oracle.com/database/technologies/xe-prior-releases.html) 이 링크를 이용하여 이전 버전을 받을 수 있다.
   * 다운받은 파일을 압축해제한 후 `setup.exe`파일을 통해 다운로드를 진행하면 된다.
* 주의할 점은 여기서 **관리자 비밀번호를 설정**하는데 이를 꼭 기억해둬야 한다는 것이다.
   * 설치가 완료되면, 명령프롬프트창에서 `sqlplus system/{Password}`를 입력하면 다음의 결과가 나타난다.
  * 위와 같이 입력하는 이유는 명령프롬프트 창의 상단에 어떤 계정으로 사용하는지를 표시하기 위함이다. `sqlplus`명령어만 사용한 후 계정과 비밀번호를 입력하여도 로그인이 가능하다.
   
```
   SQL*Plus: Release 11.2.0.2.0 Production on 월 12월 23 10:09:32 2019

   Copyright (c) 1982, 2014, Oracle.  All rights reserved.
   
   
   Connected to:
   Oracle Database 11g Express Edition Release 11.2.0.2.0 - 64bit Production
   
   SQL>
   ```
   

## Account

```
SQL> conn hr/hr
ERROR:
ORA-28000: the account is locked

Warning: You are no longer conntected to ORACLE.
```

* `conn`은 다른 계정으로 로그인하는 명령어 (`connect`와 동일하다)

* `hr/hr`이 현재는 막혀있는 상태라 해제해 준 뒤에 다시 시도해야한다.

* `conn hr/hr`을 진행함으로써 연결되어 있던 `system`과의 연결도 해제되었다.

* `system`과의 연결을 다시 진행한 후 막혀있는 `hr/hr`의 lock을 해제해준다.

  ```
  SQL> alter user hr identified by hr account unlock;
  SP2-0640: Not connected
  
  SQL> conn system/1234
  Connected.
  
  SQL> alter user hr identified by hr account unlock;
  
  User altered.
  
  SQL> conn hr/hr
  Connected.
  ```

* `hr`계정에 존재하는 `tab` 테이블에 대하여 알아본다.

  ```
  SQL> select * from tab;
  ```

  * 이 때 `tab`테이블은 `hr`계정에 존재하는 테이블이기 때문에 `system`계정에 로그인된 상태라면 해당 테이블은 없다는 결과가 나타난다.

* 새로운 계정을 생성하기 전에 `DBF`에 대해 먼저 알아본다.

  * `C:\oraclexe\app\oracle\oradata\XE`경로로 진입해보면, 여러 `.DBF`파일들이 존재한다. 이 파일들은 데이터테이블을 저장하는 파일들인데, 따로 설정해주지 않으면 `SYSTEM.DBF`에 저장된다.  새로운 `.DBF`파일을 만들어 그 파일에 공부하는 데이터를 저장하고, `SYSTEM.DBF`는 변경사항이 없도록 한다.

    ```
    SQL> create TABLESPACE mc
      2  datafile 'C:\oraclexe\app\oracle\oradata\XE\mc.dbf'
      3  size 10M
      4  autoextend on next 1M maxsize UNLIMITED;
    
    Tablespace created.
    ```

    * `TABLESPACE`를 만드는데 `mc`라는 이름을 가지도록 만든다.
    * `datafile`은 경로를 선언해줌으로써 해당 경로에 파일을 생성한다.
    * 첫 `size`는 `10M`으로 선언하나, `maxsize`를 넘어갈때마다 `1M`씩 확장하도록 만든다.

  * 만약 해당 DBF파일을 잘못 생성했다면 다음 명령어를 통해 지울 수 있다.

    ```
    drop TABLESPACE mc INCLUDING CONTENTS AND Datafiles;
    ```

* `system`계정으로 돌아가서 새로운 계정을 생성한다.

  ```
  SQL> create user test01 identified by 1234
    2  default TABLESPACE mc;
  
  User created.
  ```

  * `create user`를 사용하여 계정을 생성한다.

  * `identified by`를 사용하여 비밀번호를 설정한다.

  * `default`를 사용하여 `SYSTEM.DBF`가 아닌 `MC.DBF`를 사용하도록 변경해준다.

  * 계정이 생성됬으니 로그인을 진행해보면 다음과 같이 나타난다

    ```
    SQL> conn test01/1234
    ERROR:
    ORA-01045: user TEST01 lacks CREATE SESSION privilege; logon denied
    
    
    Warning: You are no longer connected to ORACLE.
    ```

    * 연결할 수 있는 권한이 없기 때문에 로그인이 거부당한다. 권한을 부여한다.

      ```
      SQL> grant connect, resource, dba to test01;
      
      Grant succeeded.
      
      SQL>
      ```

  * 권한을 부여해줬으니 다시 로그인을 시도한다.

    ```
    SQL> conn test01/1234
    Connected.
    SQL>
    ```

    * 권한이 존재하니 로그인이 성공했다.

  * 권한을 부여하는 방법이 있으니 제거하는 방법도 알아본다. `system`계정에서 진행해야 한다.

    ```
    SQL> revoke dba from test01;
    
    Revoke succeeded.
    
    SQL> revoke connect from test01;
    
    Revoke succeeded.
    ```

    * `revoke`를 사용하여 권한을 제거하며, `from`을 사용하여 누구한테서 제거하는지 명시한다.

* 계정을 제거하는 방법을 알아본다.

  ```
  SQL> drop user test01 cascade;
  
  User dropped.
  ```

  * `drop user`를 사용하여 계정을 삭제한다.
  * `cascade`는 강제를 의미하며 명령어를 강제로 실행한다.

* `SCOTT/TIGER`계정을 생성한다.

  ```
  SQL> create user SCOTT identified by TIGER
    2  default TABLESPACE mc;
  
  User created.
  ```

* `C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin`경로에 존재하는 `scott.sql`파일을 가져와서 Eclipse에서 열어본다.

* Line 24, Line 25를 다음 코드와 같이 변경한다

  ```
  GRANT CONNECT,RESOURCE,DBA TO SCOTT IDENTIFIED BY TIGER;
  ALTER USER SCOTT DEFAULT TABLESPACE mc;
  ```

  * `GRANT`를 이용하여 권한을 부여한다.
  * `ALTER`를 이용하여 테이블 저장위치를 변경할 수 있으나 이는 `SCOTT`계정을 생성할 때 이미 언급했으므로 실행할 필요는 없다.

* `GRANT`문을 명령프롬프트 창에서 실행시켜서 권한을 부여한다.

* `scott.sql`파일을 C드라이브의 lib폴더로 이동시킨후 다음 명령어를 실행한다.

  ```
  @C:\lib\scott.sql;
  ```

  * `scott.sql`파일 내부의 명령어 전부를 실행시키는 코드다.

  * 이를 진행하면 `scott.sql`파일에서 선언한 `tab`테이블을 확인할 수 있다.

    ```
    SQL> select * from tab;
    ```

* `desc`를 이용하여 `table`이 어떻게 구성되어 있는지 파악할 수 있다.

  ```sql
  desc emp;
  ```

## Setting

> 명령어를 실행하는 것은 해당 창에서만 적용이 된다.
>
> 이를 모든 창에서 적용되도록 하려면 `C:\oraclexe\app\oracle\product\11.2.0\server\sqlplus\admin`
> 경로에 존재하는 `glogin.sql`파일에 적용할 설정의 명령어를 넣어준다.

* `line size`를 설정해줄 수 있다.

  ```sql
  set linesize 300;
  ```

* `page size`를 설정해줄 수 있다.

  ```sql
  set pagesize 20;
  ```

* 열이 차지하는 크기를 지정해 줄수 있다.

  ```sql
  col ename for a10;
  col job for a12;
  col sal for 9999;
  ```

  * `col`명령어로 `size`를 지정하며 `ename`이란 변수는 `a` 10개의 크기만큼 공간을 차지한다.
  * `sal`이란 변수는 9999의 숫자만큼의 공간을 차지한다.