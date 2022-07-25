-- <SQL 고급>--
-- 3. 뷰
-- 3.1 뷰의 생성
-- 1) 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오
create view vw_customer
as select *
from customer
where address like '%대한민국%';
# 결과 확인
select *
from vw_customer;

-- 2) order 테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후, '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 보이시오
CREATE VIEW vw_Orders (orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name,
od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid =cs.custid AND od.bookid =bk.bookid;
# 결과 확인
SELECT orderid, bookname, saleprice
FROM vw_Orders
WHERE name='김연아';

-- 3.2 뷰의 수정
-- 1) 위에서 생성한 뷰 vw_customer는 주소가 대한민국인 고객을 보여준다. 이 뷰를 영국을 주소로 가진 고객으로 변경하시오. 
-- phone 속성은 필요 없으므로 포함시키지 마시오
create or replace view vw_Customer (custid, name, address)
as select custid, name, address
	from customer
    where address like '%영국%';
# 결과 확인    
select *
from vw_customer;
 
 -- 3.3 뷰의 삭제
 -- 1) 앞서 생성한 뷰 vw_customer를 삭제하시오
 drop view vw_customer;
 # 결과 확인
 select *
 from vw_customer;
