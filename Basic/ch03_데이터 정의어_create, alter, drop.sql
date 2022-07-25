-- <SQL 기초> --
-- 4. 데이터 정의어
-- 4-1. create문
/* 1) 다음과 같은 속성을 가진 NewBook 테이블을 생성하시오. 정수형은 INTEGER를 사용하여 문자형은 가변형 문자타입인 VARCHR을 사용한다
- bookid(도서번호) - INTEGER
- bookname(도서이름) - VARCHAR(20)
- publisher(출판사) - VARCHAR(20)
- price(가격) - INTEGER
*/

create table Newbook(
bookid integer, 
bookname varchar(20), 
publisher varchar(20),
price integer,
primary key (bookid));

/* 2) 다음과 같은 속성을 가진 New Customer 테이블을 생성하시오
- custid(고객번호) - INTEGER, 기본키
- name(이름) - VARCHAR(40)
- address(주소) - VARCHAR(40)
- phone(전화번호) - VARCHAR(30)
*/

create table NewCustomer(
cusid integer,
name varchar(40),
address varchar(40),
phone varchar(30));

/* 3) 다음과 같은 속성을 가진 NewOrders 테이블을 생성하시오
- orderid(주문번호) - INTEGER, 기본키
- custid(고객번호) - INTEFER, NOT NULL 제약조건, 외래키(New Customer.custid, 연쇄 삭제)
- bookid(도서번호) - INTEGER, NOT NULL 제약조건
- saleprice(판매가격) - INTEGER
- orderdate(판매일자) - DATE
*/

create table NewOrders(
orderid INTEGER, 
custid INTEGER not null,
bookid INTEGER not null, 
saleprice INTEGER, 
orderdate Date, 
primary key(orderid),
foreign key(custid) references NewCustomer(custid) on delete cascade);

-- 4.2 ALTER문
-- 1) NewBook 테이블에 VARCHAR(13)의 자료형을 가진 isbn 속성을 추가하시오
alter table NewBook add isbn varchar(13); 

-- 2) NewBook 테이블의 isbn 속성의 데이터 타입을 integer형으로 변경하시오
alter table NewBook modify isbn integer;

-- 3) NewBook 테이블의 isbn 속성을 삭제하시오
alter table NewBook drop column isbn;

-- 4) NewBook 테이블의 bookid 속성에 not null 제약조건을 적용하시오
alter table NewBook modify bookid integer not null;

-- 5) NewBook 테이블의 bookid 속성을 기본키로 변경하시오
alter table NewBook add primary key(bookid);

-- 4.3 DROP문
-- 1) NewBook 테이블을 삭제하시오
drop table NewBook;

-- 2) NewCustomer 테이블을 삭제하시오. 만약 삭제가 거절된다면 원인을 파악하고 관련된 테이블을 같이 삭제하시오(NewOrder 테이블이 NewCustomer를 참고하고 있는 상태이다)
drop table NewOrders;
drop table NewCustomer;

