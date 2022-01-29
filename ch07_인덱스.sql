-- <SQL 고급> --
-- 4. 인덱스
-- 4-1. 인덱스의 생성
-- 1) book 테이블의 bookname 열을 대상으로 비 클러스터 인덱스 ix_book을 생성하라
create index ix_book on book (bookname);

-- 2) book 테이블의 publisher, price 열을 대상으로 인덱스 ix_book2를 생성하시오
create index ix_book2 on book(publisher, price);

-- 4-2. 인덱스의 재구성과 삭제
-- 1) book 테이블의 인덱스를 최적화하시오(생성)
alter table book;

-- 2) 인덱스 ix_book을 삭제하시오
drop index ix_book ON book;

