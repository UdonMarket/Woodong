--kosmo 계정 07/15/수욜
--멤버테이블
create table woo_member(
        id VARCHAR(30) NOT NULL,     
        pass VARCHAR(30) NOT NULL,    
        regidate DATE DEFAULT SYSDATE,  
        mobile VARCHAR(30) NOT NULL,                                        
        avg_score VARCHAR(10) default '1',      
        addr VARCHAR(100) NOT NULL,  
        grade VARCHAR(50) NOT NULL, 
        trade_count VARCHAR(1000) default '0', 
        authority varchar2(20) default 'ROLE_USER',
        enabled number(1) default 1,
        
        PRIMARY KEY (id)
);


--더미데이터
insert into woo_member values ('a0@a','kos1',sysdate,'1-1-1','1','a-a-a','normal','0','ROLE_USER', 1);
insert into woo_member values ('a1@a','kos2',sysdate,'1-1-1','1','a-a-a','normal','0','ROLE_USER', 0);
insert into woo_member values ('a2@a','kos3',sysdate,'1-1-1','1','a-a-a','normal','0','ROLE_USER', 1);
insert into woo_member values ('a3@a','kos4',sysdate,'1-1-1','1','a-a-a','normal','0','ROLE_USER', 0);
insert into woo_member values ('a4@a','kos5',sysdate,'1-1-1','1','a-a-a','normal','0','ROLE_USER', 1);

commit;

--kosmo 계정 07/15/수욜
--게시판 관리(상품):woo_board
create table woo_board(
idx  varchar(10)  primary key,
title varchar(100) NOT NULL,
content        varchar(2000) NOT NULL,
postdate date default sysdate ,
id        varchar(50) NOT NULL,
b_name varchar(50) NOT NULL,
visitcount        number default 0,
image        varchar(50) NOT NULL,
likecount        number default 0,
manyimage varchar(100) ,
price        varchar(100) NOT NULL,
good_state        varchar(100) NOT NULL,
chatcount        varchar(100) default 0,
like_check number default -1
);

--게시판 관리(상품) :시퀀스 생성
create sequence seq_woo_board
    increment by 1
    start with 1
    nomaxvalue 
    minvalue 1
    nocycle
    nocache;

--더미데이터

-------------------------------------------------새로운 더미데이터----------------------------
insert into woo_board values(seq_woo_board.nextval,'첫번째 게시판','첫번째 내용1',sysdate,'코스모1','bname',0,'image',0,
'manyimage',1000,'거의새것',0,-1);

insert into woo_board values(seq_woo_board.nextval,'두번째 게시판','두번째 내용2',sysdate,'코스모1','bname',0,'image',0,
'manyimage',2000,'거의새것',0,-1);

insert into woo_board values(seq_woo_board.nextval,'세번째 게시판','세번째 내용3',sysdate,'코스모1','bname',0,'image',0,
'manyimage',3000,'거의새것',0,-1);

insert into woo_board values(seq_woo_board.nextval,'네번째 게시판','네번째 내용4',sysdate,'코스모1','bname',0,'image',0,
'manyimage',4000,'거의새것',0,-1);

insert into woo_board values(seq_woo_board.nextval,'다섯번째 게시판','다섯번째 내용5',sysdate,'코스모1','bname',0,'image',0,
'manyimage',5000,'거의새것',0,-1);



commit;

create table mypage(
    goods varchar2(200) default '#',
    id varchar(50) constraint goods_fk
    references woo_member (id)
);

--더미데이터
insert into mypage (id) values ('q@q');

commit;