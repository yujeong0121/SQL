-- <SQL 기초> --
-- 5. 데이터 조작어(삽입, 수정, 삭제)
-- 5.1 INSERT문
-- 1) Book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 90,000원이다
insert into book(bookid, bookname, publisher, price)
			values(11, '스포츠의학', '한솔의학서적', 90000);
select*
from book;

-- 2) book 테이블에 새로운 도서 '스포츠 의학'을 삽입하시오. 스포츠 의학은 한솔의학서적에서 출간했으며 가격은 미정이다
insert into book(bookid, bookname, publisher)
			values(14, '스포츠 의학', '한솔의학서적');
select *
from book;

-- 3) 수입도서 목록(import_book)을 book 테이블에 모두 삽입하시오
insert into book(bookid, bookname, price, publisher)
			select bookid, bookname, price, publisher
            from imported_book;
            
select*
from book;

-- 5.2 update문
-- 1) customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국의 부산'으로 변경하시오
set sql_safe_updates = 0;
update customer
set address='대한민국 부산'
where custid = 5;

select *
from customer;

-- 2) book 테이블에서 14번 '스포츠 의학'의 출판사를 imported_book 테이블의 21번 책의 출판사와 동일하게 변경하시오
update book
set publisher = (select publisher
				from imported_book
				where bookid = '21')
where bookid = '14';

select*
from customer;

-- 5-3. delete문
-- 1) Book 테이블에서 도서번호가 11인 도서를 삭제하시오
delete from book
where bookid = '11';

select* 
from book;

-- 2) 모든 고객의 삭제하시오
delete from customer;


