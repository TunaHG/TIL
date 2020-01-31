# JDBC

## Setting Driver

1. [Java Project JDBC]에서 우클릭, [Build Path] - [Configure Build Path] 선택
2. Java Build Path의 Libraries 에서 Add External JARs을 통해 ojdbc6.jar 추가

## JDBC Programming Procedure

1. 연결할 Driver Class를 `classpath`아래 `maven`설정으로 대체

2. Load Driver Class

   ```java
   String driver = "oracle.jdbc.OracleDriver";
   Class.forName(driver);
   ```

   * 객체를 생성하여 메모리에 띄우는 작업
   * `new`를 사용하여 객체를 생성하면 `Compile`과정에서 `Driver`가 결정되고, 여러 개의 객체가 생성될 수 있기 때문에 해당 방법을 사용한다.

3. 로딩된 Driver Class를 이용해서 Connection 요청(url, user, pwd)

   ```java
   import java.sql.Connection;
   
   String user = "SCOTT";
   String pwd = "TIGER";
   String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
   
   Connection con = DriverManager.getConnection(url, user, pwd);
   ```

4. 생성된 Connection으로부터 Statement 생성

   ```java
   import java.sql.PreparedStatement;
   
   String sql = "select * from emp where deptno = ?";
   
   PreparedStatement ps = con.prepareStatement(sql);
   ```

   * `Statement`보다 `PreparedStatement`가 성능이 좋다.

   * `PreparedStatement`가 `sql`내부의 `?`에 대하여 처리할 수 있는 기능을 가지고 있다.

     ```java
     ps.setInt(1, 30);
     ```

     * `1`번째 순서의 `?`에 `30`이란 값을 넣겠다는 의미다.
     
   * `PreparedStatement`에는 `setXXX`와 `getXXX`가 존재한다. 이 때 `XXX`는 자료형을 의미한다.

     * `setXXX`는 두 개의 인자를 받는다.
     * `getXXX`는 한 개의 인자를 받는다. 이 때 인자는 `Index`혹은 `fieldName`이 온다. 하지만 `fieldName`을 사용하길 권장하며 이는 순서가 바뀌더라도 이름은 바뀌지 않기 때문이다.

5. 생성된 Statement를 이용해서 SQL수행(execute, executeUpdate, executeQuery)

   ```java
   import java.sql.ResultSet;
   
   ResultSet rs = ps.executeQuery();
   ```

   * `Select`문의 결과값은 `ResultSet`로, `DDL`문의 결과값은 `INT`로 나온다.

6. 결과 처리(ResultSet, int)

   ```java
   while(rs.next()) {
   	System.out.print(rs.getString("empno") + "\t");
   	System.out.print(rs.getString("ename") + "\t");
   	System.out.print(rs.getString("job") + "\t");
   	System.out.print(rs.getString("mgr") + "\t");
   	System.out.print(rs.getString("hiredate") + "\t");
   	System.out.print(rs.getString("sal") + "\t");
   	System.out.print(rs.getString("comm") + "\t");
   	System.out.print(rs.getString("deptno") + "\t");
   	System.out.println();
   }
   ```

   * `rs.next()`를 통하여 다음에 출력할 내용이 있는지를 살펴본다.
   * `rs.getString({Column Name})`을 통하여 `{Column Name}`에 해당하는 값을 가져온다.

7. SQLException 처리(try, catch, finally)

   * 2 ~ 6 까지의 과정은 전부 `try{ }`내부에 속해 있다.

   * `catch{ }`내부에 `Error`를 출력하도록 한다.

     ```java
     catch(Exception e){
         System.out.println(e);
     }
     ```

8. 자원정리(connection, statement, resultset)

   * `finally{ }`내부에 자원 정리를 진행하는 코드를 작성한다.

     ```java
     finally {
     	try {
     		if(rs != null) rs.close();
     		if(ps != null) ps.close();
     		if(con != null) con.close();
     	} catch (Exception e2) {
     		System.out.println(e2);
     	}
     }
     ```

## JDBC Util

> Driver, url, user, password 등을 항상 입력하지않고 Util에 모아서 처리한다.

* `user`, `pwd`, `driver`, `url`을 가져와서 고정적으로 연결을 진행하도록 한다.
* `Connection`과 `close()`에서 `try-catch`를 사용하지 않고 `throws`로 보내서 `main`에서 예외처리를 진행하도록 만든다.
* [JDBC Util](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/util/jdbcUtil.java)
  * [Test using util](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/test/Test02_emp.java)
  * [Template using util](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/test/JDBC_Template.java)

## DAO

> Data Access Object
>
> Database의 Data에 접근하기위한 객체

* 실질적인 DB와의 연동을 진행하는 Method들을 가지고 있다.
* 커넥션을 하나만 가져오고 그 커넥션을 가져온 객체가 모든 DB와의 연결을 하는것이 바로 DAO객체
* DB를 사용해 데이터를 조화하거나 조작하는 기능을 전담하도록 만든 오브젝트
* 다수의 원격호출을 통한 오버헤드를 VO나 DTO를 통해 줄일 수 있고 다수의 DB 호출문제를 해결
* 단순히 읽기만 하는 연산이므로 트랜잭션 간의 오버헤드를 감소
* [Codes](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/DAO/DeptDAO.java)

## DTO

> Data Transfer Object, VO(Value Object), Record(rec)
>
> JDBC에서 SQL의 결과물을 저장하는 객체

* `Query`의 결과로 나오는 모든 `Column`을 `Encapsulation`된 변수로 가지는 `Class`
* `Setter`. `Getter`, `toString()`, `Constructor`를 모두 생성한다.
* `Java`코드에서 `List<DTO>`를 활용하여 `DTO`를 저장한다.
* 로직을 갖고 있지 않는 순수한 데이터 객체
* VO는 DTO와 동일한 개념이지만 read only 속성을 가짐
* [Codes](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/DTO/DeptDTO.java)

# Codes

* [Test using DAO, DTO](https://github.com/TunaHG/Eclipse_Workspace/blob/master/DB/src/test/Test03.java)