-- 1. 데이터 조작어 - 검색
-- 1.1 select문
/*
 - select(distinct, *)
 - from
 - where(between __and __, __ in, __like, __ like __and __,  __ or __)
 - order by(__ desc, __ asc)
*/

-- 1) 모든 도서의 이름과 가격을 검색하시오
select bookname, price
from Book;

-- 2) 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오
select bookid, bookname, publisher, price
from book;

select *
from book;

-- 3) 도서 테이블에 있는 모든 출파사를 검색하시오.
select publisher
from book;

select distinct publisher #  중복제거(distinct)
from book;

-- 4) 가격이 10000원 이상 20,000원 미만인 도서를 검색하시오
select *
from book
where price between 10000 and 20000;

-- 5) 출판사가 '굿스포츠' 혹인 '대한미디어'인 도서를 검색하시오
select *
from book
where publisher in('굿스포츠', '대한미디어');

-- 6) '축구의 역사'를 출간한 출판사를 검색하시오
select *
from book
where bookname like '축구의 역사';

-- 7) 도서이름에 '축구'가 포함된 출판사를 검색하시오
select *
from book
where bookname like '%축구%';

-- 8) 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
select *
from book
where bookname like '_구%';

-- 9) 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오
select *
from book
where bookname like '%축구%' and price >=20000;

-- 10) 출판사가 '굿스포츠'혹은 '대한미디어'인 도서를 검색하시오
select *
from book
where publisher='굿스포츠' or publisher='대한미디어';

-- 11) 도서를 이름순으로 검색하시오
select *
from book
order by bookname;

-- 12) 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오
select *
from book
order by price, bookname;

-- 13) 도서를 가격의 내림차순으로 검색하고, 가격이 같다면 출판사의 오름차순으로 검색하시오
select *
from book
order by price desc, publisher asc;

-- 1-2. 집겨 함수와 GROUP BY
/*
- sum: 총합계
- avg: 평균값
- min: 최소값
- max: 최대값
- count: 행의 개수 세기(null값 제외)
- group by<속성>
- having<검색조건>
- 데이블1 inner join 테이블2 on <조인조건>
- 테이블1 {left|right|full|[outer]} join 테이블2 on <조인조건>
*/

select *
from orders;

-- 1) 고객이 주문한 도서의 총 판매액을 구하시오
select sum(saleprice)
from orders;

-- 2) 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오 
select sum(saleprice) as 총매출
from orders
where custid=2;

-- 3) 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오
select sum(saleprice) as Total,
	   avg (saleprice) as Average,
       min(saleprice) as Minimum,
       max(saleprice) as Maximum
from orders;

-- 4) 마당서점의 도서 판매 건수를 구하시오
select count(*)
from orders;

-- 5) 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오
select custid, count(*) as 도서수량, sum(saleprice) as 총액
from orders
group by custid
order by custid;

-- 6) 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구하시오
select custid, count(*) as 도서수량
from orders
where saleprice >= 8000
group by custid
having count(*) >=2;

-- 1-3. 두 개 이상 테이블에서 SQL 질의
-- 1) 고객과 고객의 주문에 관한 데이터를 모두 보이시오
select *
from customer, orders
where customer.custid = orders.custid; 

-- 2) 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 보이시오
select *
from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- 3) 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오
select name, saleprice
from customer, orders
where customer.custid=orders.custid;

-- 4) 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오
select name, sum(saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 5) 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
select customer.name, book.bookname
from customer, orders, book
where customer.custid=orders.custid and orders.bookid=book.bookid;

-- 6) 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오
select customer.name, book.bookname
from customer, orders, book
where customer.custid=orders.custid and orders.bookid=book.bookid and book.price = 20000;

-- 7) 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오
select customer.name, saleprice
from customer left outer join orders
				on customer.custid=orders.custid;
