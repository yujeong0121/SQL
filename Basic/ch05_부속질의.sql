-- <부속질의> --
-- 2. 부속 질의
-- 2-1. 스칼라 부속질의 - select 부속질의
-- 1) 마당서점의 고객별 판매액을 보이시오(고객이름과 고객별 판매액을 출력)
select (select name
		from customer cs
        where cs.custid = od.custid) 'name', sum(saleprice) 'total'
from orders od
group by od.custid;

/* -- 2) orders 테이블에 각 주문에 맞는 도서이름을 입력하시오
# set SOL_SAFT_UPDATE = 0
alter table orders add bname varchar(40);

update orders
set bname=(Select bookname
			from book
			where book.bookid=orders.bookid);
select*from orders;
*/

-- 2-2. 인라인 뷰 - from 부속질의
-- 1)
select cs.name, sum(od.saleprice) 'total'
from (select custid, name
	  from customer
      where custid <= 2) cs, 
      orders od
where cs.custid = od.custid
group by cs.name;

-- 2-3. where 부속질의
-- 1) 평균 주문금액 이하의 주문에 대해서 주문번호의 금액을 보이시오
select orderid, saleprice
from orders
where saleprice <= (select avg(saleprice)
					from orders);
-- 2) 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 금액을 보이시오
select orderid, custid, saleprice
from orders od
where salaprice > (select avg(Saleprice)
					from orders so
					where od.custid = so.custid);
-- 3) 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오
select sum(saleprice) 'total'
from orders
where custid in (select custid
				from customer
                where address like '%대한민국%');

-- 4) 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오
select	orderid, saleprice
from	Orders
where	saleprice > all (select saleprice
				  from   Orders
				  where custid='3');
                  
-- 5) EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 구하시오
select	SUM(saleprice) 'total'
from	Orders od
where	exists (select  *
			 from	   Customer cs
			 where	   address like '%대한민국%' and cs.custid=od.custid);
