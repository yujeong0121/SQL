-- <SQL 고급> --
-- 1. 내장 함수
-- 1.1 숫자 함수
-- 1) -78과 + 78의 절댓값을 구하시오
select abs(-78), abs(78);

-- 2) 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오
select round(4.875, 1);

-- 3) 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하시오
select custid '고객번호', round(sum(saleprice)/count(*), -2)'평균금액'
from orders
group by custid;

-- 1.2 문자 함수
-- 1) 도서제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 보이시오
select bookid, replace(bookname, '야구', '농구')bookname, publisher, price
from book;

-- 2) 굿스포프에서 출판한 도서의 제목과 제목의 문자 수, 바이트 수를 보이시오
select bookname '제목', char_length(bookname)'문자수',
	   length(bookname) '바이트수'
from book
where publisher='굿스포츠';

-- 3) 마당서점의 고객 중에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오
select substr(name, 1, 1)'성', count(*)'인원'
from customer
group by substr(name, 1, 1);


-- 1.3 시간함수
-- 1) 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
select orderid '주문번호', orderdate '주문일',
ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
from orders;

-- 2) 마당서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오
select orderid '주문번호', STR_TO_DATE(orderdate, '%Y-%m-%d') '주문일',
custid '고객번호', bookid '도서번호'
from Orders
where orderdate=DATE_FORMAT('20140707', '%Y%m%d');

-- 3) DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오
select sysdate(),
		date_format(sysdate(), '%y/%m/%d%M%h: %s')'sysdate_1';
        
-- 1.4  null 값 처리
-- 1) 이름, 전화번호가 포함된 고객목록을 보이시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오
select name '이름', ifnull(phone, '연락처없음') '전화번호'
from customer;

-- 2) 고객 목록에서 고객번호, 이름, 전화번호를 앞의 두 명만 보이시오
set @seq:=0;
select (@seq:=@seq+1)'순번', custid, name, phone
from customer
where @seq < 2;
