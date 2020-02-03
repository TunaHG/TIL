# Annotation

@ annotation 

1. DAO >> `@Repository("dao")` = `<bean id="dao" class="xxx.DAO">`
   `@Repository` >> 이름이 없다면 Class랑 같은 이름(EmpDAO라면 empDAO로 입력된다.)
   `@Repository`가 `<bean>`과 같은 역할을 수행한다.
   Class위에 붙여준다. >> DAO Class에 권장
2. `@Component` = `@Repository` >> 모든 Class에 권장
3. `@Autowired` : 변수 선언시 Annotation한다.
   EmpVO로 생성된 객체를 찾아서 가져온다. 변수위에 붙여준다. 객체를 변수로 가질때만 사용가능함

4. EmpVO와 같이 전달받을 값이 있으면 `<bean>`을 사용해야 한다.

@Service("{bean id}") : Class 위

@Repository("") : Class 위

@Component("") : Class 위

@Autowired : 멤버변수, 변수 위

@Resource : 멤버변수, 생성자, Setter 위에 선언

@Qualifier : 멤버변수, 생성자, Setter 위에 선언