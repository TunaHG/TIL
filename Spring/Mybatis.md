# Mybatis

> JDBC를 대체하여 Spring과 DB를 연결하는 Framework

* Mybatis의 SQL Code는 XML파일에 들어간다.
  * 이제는 JDBC의 Driver, url, Account, password 또한 XML파일에서 설정한다.

## JDBC에서 Upgrade

> 그동안 사용한 JDBC에 대해서 복습한다.

```java
try{
    Class.forName("");
	Connection con = DriverManager.getConnection(jdbc url, account, password);
	// PreparedStatement를 사용하여 int값 또는 ResultSet을 return받으며 sql 작업처리
	con.close();
} catch(Exception e){
    e.printStacktrace();
}
```

* Code의 반복이 많다.
* Java 언어 내부에 SQL 언어가 포함되어 있다.
  * 이제 sql-mapping.xml파일에서 SQL Code를 작성한다.
  * 게시판에 관련된 SQL Code는 board-mapping.xml로 작성하고, 회원에 관련된 SQL Code는 member-mapping.xml로 작성하는 등 SQL Table별로 XML파일을 한개씩 만들어서 사용한다.
* DB 연결을 위한 복잡한 정보가 Java코드에 포함되어 매번 작성해야 한다.
  * 반복되는 Code들은 이제 DB-config.xml에서 처리한다.
  * DB-config.xml 파일은 1개만 만들어서 사용한다.

### Mybatis 적용

* sql-mapping.xml과 db-config.xml을 읽는다.
  * db가 연결되면 연결된 객체를 가져온다.
* sql 정보를 가져와서 실행을 요청한 후 return값이 VO객체인지 String인지 ArrayList인지를 정해준다.
* 받은 SQL결과를 출력한다.

## Mybatis Setting

### Library Download

* [Maven Repository](https://mvnrepository.com/)에서 mybatis를 검색하고 첫 번째 검색결과의 3.4.6버전의 Dependency를 복사한다.
  * Eclipse의 Spring Project에서 pom.xml에서 `<dependencies>` 태그 내부에 복사한 내용을 붙여넣는다.
  * Eclipse에서 mybatis.jar파일을 자동으로 설치하므로 잠시 기다린다.
* ojdbc6.jar : Oracle jdbc driver의 압축파일
  * mybatis를 진행할 때도 해당 jar파일은 필요하다,
  * OracleDB를 받았다면 해당 파일은 보통 `oraclexe/app/oracle/product/11.2.0/server/jdbc/lib` 내부에 존재한다.
  * Eclipse에서 Project - Properties - Java Build Path - Libraries에서 Add External JARs를 클릭하여 경로를 찾아가서 ojdbc6.jar을 추가한다.
    * 위 과정은 main에서 JDBC를 사용하기 위한 라이브러리 추가다.
  * Tomcat의 경로에서 lib폴더 내에 ojdbc6.jar파일을 추가하거나, Eclipse Project에서 src/main/webapp/WEB-INF경로에 lib폴더를 생성하고 해당 폴더에 ojdbc6.jar을 추가한다.
    * 위 과정은 servlet, jsp등 java web server application에서 JDBC를 사용하기 위한 라이브러리 추가다.

### DB Connect

* Spring project의 src/main/java에 mybatis 패키지를 만든다.

* 패키지 내에 다음의 기본 틀을 가지는 mybatis-config.xml파일을 만든다.

  ```xml
  <?xml version="1.0" encoding="UTF-8" ?>
  <!DOCTYPE configuration
    PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
    "http://mybatis.org/dtd/mybatis-3-config.dtd">
    
  <configuration>
  </configuration>
  ```

  * `<configuration>`내부에 이제 다음의 Code를 추가한다.

    ```xml
    <environments default="mydb">
    	<environment id="mydb">
    		<transactionManager type="JDBC"/>
    		<dataSource type="POOLED">
    			<property name="driver" value="oracle.jdbc.driver.OracleDriver"/>
    			<property name="url" value="jdbc:oracle:thin:@localhost:1521:xe"/>
    			<property name="username" value="hr"/>
    			<property name="password" value="hr"/>
    		</dataSource>
    	</environment>
    </environments>
    <mappers>
    	<mapper resource="mybatis/emp-mapping.xml"/>
    </mappers>
    ```

    * `<environment>`를 통하여 JDBC와 연결하는 작업을 진행한다.
      * property에 들어갈 값만 조정해주면 다른 DB 혹은 다른 계정과 연결할 수 있다.
      * 여러 개의 계정을 한번에 입력해두고 싶다면 `<environments>`안에 다른 `<environment>`를 입력해두면 된다. 이 때 id는 중복되면 안된다.
    * `<mapper>`를 통하여 어떤 mapping파일과 연동할지도 설정한다.

* mybatis-config.xml 파일을 위와같이 만들었으면 DB와 연결할 준비는 끝났다.

## Use Select Query with xml

* DB와 연결이 끝났으니 직접적으로 DB를 사용해본다.

* Class 하나를 생성하여 해당 Class에서 DB와 연결을 위한 다음 Code를 작성한다.

  ```java
  public class EmpMain {
  
  	public static void main(String[] args) throws Exception {
  		// 1.
  		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
  		// 2. SqlSessionFactory = JDBC Connection 과 유사, 연결 설정 파일을 읽는 것. (SqlSession을 만드는 공장 역할)
  		SqlSessionFactory factory = builder.build(Resources.getResourceAsReader("mybatis/mybatis-config.xml"));
  		// 3. SqlSession = 연결 생성
  		SqlSession session = factory.openSession();
  
  		System.out.println(session);
  	}
  
  }
  ```

  * SqlSession을 이용하여 연결을 생성하며, SqlSession을 만드는 공장 역할인 SqlSessionFactory도 생성한다.
    * SqlSessionFactory를 생성하기 위한 Builder를 먼저 선언해줘야 한다.
    * SqlSessionFactory는 위에서 Setting한 mybatis-config.xml의 경로를 알려줘야한다.
      * 이 때 사용하는 Resources 객체는 org.apache.ibatis.io.Resources 객체이다.
  * session의 해쉬값 주소가 출력되면 정상적으로 가져왔다.

* 다음으로 직접 DB에 SQL구문을 입력하기 위해 emp-mapping.xml파일을 생성한다.

  * 해당 파일의 기본 틀은 다음과 같다.

    ```xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
      "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="emp">
    </mapper>
    ```

  * `<mapper>` 태그 내부에 원하는 Sql Query를 입력한다.

    * `<select>`, `<insert>`, `<update>`, `<delete>`와 같은 태그가 올 수 있다.
      각 태그 내부에 해당 Query문을 입력하면 된다.

    ```xml
    <select id="allemp" resultType="mybatis.EmpVO">
    	select * from employees
    </select>
    ```

    * 이를 Class에서 사용하기 위하여 id를 선언해주며 해당 select문의 결과를 어떻게 가져올지에 따른 resultType또한 선언해준다. resultType은 Class 경로를 선언해줘야한다.

      * EmpVO Class를 만들어줘야한다. OracleDB의 hr/hr계정에 EMPLOYEES Table을 사용한다.

        [EmpVO Class]

    * select문에서 나오는 결과값들은 employees의 column 이름과 EmpVO의 변수명이 같은 것들을 자동으로 연결하여 저장된다.

* 이제 emp-mapping.xml에서 작성한 select문을 실행하는 Code를 Class에 넣어본다.

  ```java
  List<EmpVO> list = session.selectList("allemp");
  for (EmpVO vo : list) {
  	System.out.println(vo.getEmployee_id() + ":" + vo.getFirst_name());
  }
  ```

  * 해당 select문의 결과가 1개의 record만 출력하는 경우가 아닌 107개의 record를 출력하는 경우다.
  * 그렇기에 EmpVO를 객체로 가지는 List를 선언하여 해당 List에 값을 받아서 출력했다.
  * 또한 session의 selectList라는 메소드를 사용하였다. 결과값이 list로 return되는 메소드다.

* 그럼 이제 1개의 record만 가져오는 경우에 대해 알아본다.

  * emp-mapping.xml에는 다음의 코드를 추가한다.

    ```xml
    <select id="oneemp" resultType="mybatis.EmpVO" parameterType="int">
    	select * from employees where employee_id = #{a}
    </select>
    ```

    * id를 변경해줘야하며, select문을 1개의 record만 결과로 가지도록 변경한다.
    * 이 때 값을 전달할 수 있는데, parameterType을 통하여 전달할 값의 타입을 선언하며 값을 받는 위치에는 `#{name}`이 오게된다. 이 때 name은 어떤값이 오더라도 상관없다.
    * parameterType에는 하나의 타입만 올 수 있다. `String, String, int`와 같은 형태는 불가능하다.
      * VO와 같은 객체, 배열 등의 한가지 타입만이 가능하다.

  * Main Class에는 다음의 코드를 추가한다.

    ```java
    EmpVO vo = session.selectOne("oneemp", 100);
    System.out.println(vo.getEmployee_id() + ":" + vo.getFirst_name());
    ```

    * 1개의 record만 받아오므로 결과값도 List가 아닌 EmpVO객체로 받는다.
    * 또한 1개의 record만 가져오는 selectOne 메소드를 사용한다.
    * 전달할 값 또한 id이후에 넣어주며 된다. Type을 맞춰서 전달해주면된다.

* mapping.xml에서 select문을 작성할 때, `<` 혹은 `>`처럼 범위를 지정해주는 경우 HTML 태그와 겹친다.

  * 이럴 경우 `<`와 `>`를 포함한 select문을 하나의 문자열로 인식할 수 있도록 CDATA Section을 사용한다.

  * 사용하는 방법은 다음과 같다.

    ```xml
    <select id="idemp" resultType="mybatis.EmpVO">
    	<![CDATA[select * from employees where employee_id < 150]]>
    </select>
    ```

### typeAlias

* 지금까진 mapping.xml에서 resultType을 선언할 때 Class의 경로를 선언해주었다. 이 부분을 짧게 만들 수 있다.

* mybatis-config.xml에서 다음의 Code를 `<environments>` 바로 위에 추가한다.

  ```xml
  <typeAliases>
  	<typeAlias type="mybatis.EmpVO" alias="emp"/>
  	<typeAlias type="mybatis.BoardVO" alias="board"/>
  </typeAliases>
  ```

  * EmpVO의 경로를 type으로 정해주며, alias를 emp로 선언함으로써 returnType을 작성할 때 emp로 작성함으로서 EmpVO를 지정해줄 수 있다.
  * typeAlias는 위처럼 여러 개를 선언할 수 있다.

### Using DAO

* Main Class에서 진행한 Code를 이후 Spring MVC로 적용하기 쉽게 하기 위해 DAO Class를 사용하여 변경한다.

  ```java
  List<EmpVO> list = session.selectList("allemp");
  for (EmpVO vo : list) {
  	System.out.println(vo.getEmployee_id() + ":" + vo.getFirst_name());
  }
  ```

* 위 Code는 Main Class에서 진행한 Code이다. 이를 DAO Class를 사용하여 변경해본다.

  * DAO Class를 생성한 후, Main에서 진행한 Session을 넘겨줘야한다.

    ```java
    public class EmpDAO(){
        SqlSession session;
        public void setSession(SqlSession session){
            this.session = session;
        }
    }
    ```

    * Set메소드를 선언하여 session을 받는다.

  * Main Class에서는 이제 DAO객체를 생성하고 session을 넘겨줘야 한다.

    ```java
    EmpDAO dao = new EmpDAO();
    dao.setSession(session);
    ```

* 이제 위의 Code를 변경해본다.

  * 우선 DAO Class에서 해당역할을 수행하는 메소드를 생성한다.

    ```java
    public List<EmpVO> getAllEmp() {
    	List<EmpVO> list = session.selectList("allemp");
    	return list;
    }
    ```

  * 이제 Main Class에서 해당 메소드를 호출한다.

    ```java
    List<EmpVO> list = dao.getAllEmp();
    for (EmpVO vo : list) {
    	System.out.println(vo.getEmployee_id() + ":" + vo.getFirst_name());
    }
    ```

## DML

> mapping.xml, EmpDAO, EmpMain Class를 활용하여 Insert작업을 진행한다.
>
> update, delete는 mapping.xml의 code가 조금 변경될뿐 큰 틀의 차이는 없다.

* EmpMain에 다음의 Code를 작성한다.

  ```java
  EmpVO vo = new EmpVO();
  vo.setEmployee_id(1000);
  vo.setFirst_name("길동");
  vo.setLast_name("홍");
  vo.setEmail("gil@multi.com");
  vo.setJob_id("IT_PROG");
  
  dao.insertEmp(vo);
  System.out.println("신규 사원을 등록했습니다.");
  ```

  * 각 값들을 따로따로 넣어줄 수 있지만 그렇게 되면 parameter가 길어지므로 VO객체를 사용한다.

* EmpDAO Class에 다음의 Code를 작성한다.

  ```java
  public void insertEmp(EmpVO vo) {
  	session.insert("newemp", vo);	
  }
  ```

  * insert작업이 int값을 return하긴 하지만 쓸모가없으니 return type을 void로 처리한다.
    * DML의 return값은 몇 개의 row가 변경되었는지를 확인하는 것이므로 원한다면 int형 return을 받아오면 된다.

* mapping.xml에 다음의 Code를 작성한다.

  ```xml
  <insert id="newemp" parameterType="emp">
  	insert into employees(employee_id, first_name, last_name, email, job_id, hire_date)
  	values(#{employee_id}, #{first_name}, #{last_name}, #{email}, #{job_id}, sysdate)
  </insert>
  ```

  * return값이 없기 때문에 resultType을 선언하지 않는다.
  * VO객체를 parameter로 넘겨줄것이기 때문에 parameterType을 선언한다.

* 위 세 Code를 작성한 이후 Main Class를 실행하면 정상적으로 구동되나, DB로 진입하여 확인해보면 값이 추가가 안되어있다.

  * 이는 DML의 특성상 자동반영이 되지 않기 때문이며, commit을 통하여 반영해야한다.

    ```java
    session.commit();
    ```

    * 해당 코드가 commit을 진행하는 Code이다.

  * 이외에 자동으로 commit처리를 하기 위해선 다음을 확인한다.

    * 현재 Commit처리가 자동인지 확인해본다.

      ```java
      System.out.println(session.getConnection().getAutoCommit());
      ```

    * 자동으로 Commit처리가 되도록 설정해주려면 처음 Session을 만들때 매개변수를 변경한다.

      ```xml
      SqlSession session = factory.openSession(true);
      ```

      * 해당 매개변수의 default값이 false이므로 true를 입력하지않으면 자동 Commit은 false이다.

### Codes

* [Mybatis-config.xml file](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/mybatis-config.xml)
* [emp-mapping.xml file](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/emp-mapping.xml)
* [EmpMain](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/EmpMain.java), [EmpDAO](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/EmpDAO.java), [EmpVO](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/EmpVO.java)

## Mybatis Spring

> Spring mvc + Spring ORM(= 다른 DB Framework 연동) + mybatis 연동

### Setting

* spring-jdbc.jar(ORM기능을 가진 라이브러리)와 mybatis-spring.jar(ORM기능을 가진 라이브러리)가 필요

  * [Maven Repository](https://mvnrepository.com/)에서 두 라이브러리를 `<dependency>`에 추가하여 다운로드 받는다.
  * spring-jdbc는 우리가 설치한 spring과 같은 버전을 선택하여야 한다. (4.3.18)
    * spring-tx라는 라이브러리가 필요해서 같이 설치된다.

* mybatis-config.xml 설정파일을 변경한다.

  * `<environments>`, `<mappers>`부분을 전부 삭제 또는 주석 처리한다.
  * `<typeAlias>`의 패키지 경로를 맞게 변경한다.

* emp-mapping.xml 설정파일은 변경하지 않는다.

  * 하지만 `<select>`의 resultType과 같은 경우 typeAlias를 사용중인 상태여야한다.

* Mybatis - Spring 연동 설정파일(Spring bean 설정파일) 생성

  * src/main/webapp/WEB-INF/spring경로에 *.xml파일 생성(mybatis-spring.xml)
  * `<bean>`태그, `@Component`등의 기능은 전부 Spring기능이므로 mybatis에선 사용하지 않았다.
  * xml 파일에 포함되어야 하는 내용
    * JDBC Driver, Url, Username, Pw - DataSource 생성(Connection Pool)
      * 4개의 property를 가지는 dataSource bean을 생성한다.
      * JDBC : ConnectionPool => Spring DataSource
      * JDBC : Connection => Spring SqlSessionTemplate = mybatis SqlSession
    * Mapper, mybatis 설정파일 정보
      * dataSource, mybatis-config.xml, emp-mapping.xml을 연결해준다.
      * 여러개의 mapping.xml을 연결할 땐 *-mapping.xml과 같이 사용하면 된다.
    * SqlSessionTemplate (Spring api) 생성

* web.xml, servlet-context.xml 파일 수정

  * web.xml에서 `<context-param>`의 `<param-value>`에 mybatis-spring.xml 경로 추가

    ```xml
    <param-value>/WEB-INF/spring/root-context.xml, /WEB-INF/spring/mybatis-spring.xml</param-value>
    ```

    * 기존에 존재하던 root-context와 구분은 ,로 하거나 엔터로 구분하면 된다.

  * servlet-context.xml에서 mybatis패키지에서 Annotation을 사용하도록 수정

    ```xml
    <context:component-scan base-package="edu.multi.mybatis" />
    ```

### Usage

> Main Class를 사용한 mybatis때와 다르게 Spring으로 활용하면 Controller를 사용한다.

* Spring MVC를 공부하며 사용했던 Annotation, Controller Class와 mybatis를 공부하며 사용했던 XML 설정파일 둘 다 이용해서 진행한다.

* Controller를 사용하여 Model과 View를 정해주고 JSP를 활용하여 View를 보여준다.

* mybatis를 공부하며 사용했던 Class중 Main을 제외한 나머지 Class들을 사용한다.

  [EmpDAO](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/EmpDAO.java), [EmpVO](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/EmpVO.java), [emp-mapping.xml file](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/mybatis/emp-mapping.xml)

* Controller는 Spring MVC에서 공부했던 대로 구성한다.
  * `@RequestMapping`을 사용하여 mapping하고 Controller의 메소드를 생성하여 Model과 View를 지정한다.
  * mapping된 JSP파일을 생성하여 웹에서 보일 페이지를 만든다.

#### Codes

* [Emp Controller](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/mybatis/EmpController.java), [Emp list JSP file](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/mybatis/emplist.jsp), [Emp detail JSP file](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/mybatis/detailemp.jsp)

### Join, Login, Logout Example

#### Setting

* Create [SQL Table](./exam.sql)

* Create [VO Class](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/member/memberVO.java)

* Modify XML Files

  * [mybatis-spring.xml](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/spring/mybatis-spring.xml) 
    dataSource의 username, password / sqlSessionFactory의 configLocation, mapperLocations

  * [servlet-context.xml](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml) Annotation기능 추가

    ```xml
    <context:component-scan base-package="edu.multi.member" />
    ```

  * [mybatis-config.xml](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/member/mybatis-config.xml) memberVO를 typeAlias로 추가

#### Join

> 이미 있는 ID면 inserterror페이지로 이동, 없는 ID면 insert sql구문 실행후 로그인화면으로 이동

* ID가 이미 존재하는지를 판별할 checkMember() 생성

  * mapping에는 다음의 SQL문을 실행하도록 설정

    ```sql
    select count(*) from member where userid = #{userid}
    ```

    * userid는 기본키로 설정해두었으므로 결과는 0아니면 1이 나온다.

  * returnType을 int로 선언, parameterType은 member객체로 선언하거나 String으로 선언하면 된다.

  * [member-mapping.xml](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/member/member-mapping.xml)

* checkMember()로 얻은 int값은 0 혹은 1이 올 수 있다.

  * 1이면 이미 있는 ID이므로 inserterror View를 return
  * 0이면 없는 ID이므로 insert문을 실행시킨 후 login View를 return

* Codes

  * [DAO Class](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/member/memberDAO.java)
  * [Controller](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/java/edu/multi/member/memberController.java)
  * [inserterror.jsp](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/member/inserterror.jsp)
  * [insertmemberform.jsp](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/member/insertmemberform.jsp)
  * [login.jsp](https://github.com/TunaHG/Eclipse_Workspace/blob/master/Spring/src/main/webapp/WEB-INF/views/member/login.jsp)

#### Login

> 로그인한 이후에는 로그인상태 유지

* 여러개 View에서 1번 로그인한 정보를 지속해서 공유
  (브라우저 종료까지 or 30분동안 아무 작업이 없을때까지)

  * HttpSession 생성

    ```java
    HttpSession session = request.getSession();
    ```

  * HttpSession 공유 정보 저장

    ```java
    session.setAttribute("Session값이름", 객체);
    ```

  * HttpSession 저장 정보 추출

    ```java
    ??? = (형변환)session.getAttribute("Session값이름");
    ```

  * HttpSession 저장 정보 삭제

    ```java
    session.removeAttribute("Session값이름");
    ```

    * Session값이름에 해당하는 Session하나만 삭제

  * HttpSession 소멸

    ```java
    session.invalidate();
    ```

    * Session자체의 모든 데이터를 사라지게 한다.

#### Logout