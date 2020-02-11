create table member(
    userid varchar2(30) primary key,
    password varchar2(30),
    name varchar2(50),
    phone varchar2(30)
);

insert into member('spring', 'spring', '홍길동', '010-2222-4567');
insert into member('mybatis','mybatis','김수옥','010-555-4567');
insert into member('mvc','mvc','유재범','010-2222-5765');
commit;