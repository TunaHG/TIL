create table board(
    seq number(5) primary key,
    title varchar2(100),
    contents varchar2(4000),
    writer varchar2(20),
    time date,
    password number(5),
    viewcount number(10)
);

insert into board values(1, '1번게시물', '공지사항입니다', 'user1', sysdate, 11111, 0);
insert into board values(2, '2번게시물', '점심시간입니다', 'user2', sysdate, 22222, 0);
insert into board values(3, '3번게시물', '오후엔 annotation으로 변경합니다', 'user3', sysdate, 33333, 0);

commit;

# select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual;