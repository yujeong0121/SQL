-- <정규화> --
-- 1. 이상현상
/* 실습준비
 summer 테이블을 생성하고 데이터를 삽입하기
drop table if exists summer;

create table summer
(sid integer,
class varchar(20),
price integer);

insert into summer values (100, 'fortran', 20000);
insert into summer values (150, 'pascal', 15000);
insert into summer values (200, 'c', 10000);
insert into summer values (250, 'fortran', 20000);

select *
from summer;
*/

-- 1) 삭제이상 / 200번 학생의 계절학기 수강신청을 취소하시오 
select price 'c 수강료'
from summer
where class like 'c';

# 200번 학생의 수강신청 취소
set SQL_SAFE_UPDATES=0;
delete from summer
where sid = 200;

# c 강좌 수강료 다시 조회 -> c수강료 조회 불가능
select price 'c 수강료'
from summer
where class = 'c';

# 다음 실습을 위해 200번 학생 자료 다시 입력
insert into summer  values (200, 'c', 100000);

-- 2) 삽입이상 / 계절학기에 새로운 자바 강좌를 개설하시오
# 자바 강좌 삽입
insert into summer values (null, 'java', 25000);

# summer 테이블 조회
select *
from summer;

# null 값이 잇는 경우 주의할 질의: 투플은 5개이지만 수강학생은 총 4명임
select count(*) '수강인원'
from summer;

select count(sid) '수강인원'
from summer;

select count(*) '수강인원'
from summer
where sid is not null;

-- 3) 수정이상 / fortran 강좌의 수강료를 20000원에서 15000원으로 수정하시오
# fortran 강좌 수강료 수정
update summer
set price=15000
where class = 'fortran';

select *
from summer;

select distinct price 'portran 수강료'
from summer
where class like 'fortran';

# 다음 실습을 위해 fortran 강좌의 수강료를 다시 20000원으로 복구
update summer
set price = 20000
where class like 'fortran';

# 만약 update 문을 다음과 같이 작성하면 테이터 불일치 문제가 발생함
update summer
set price = 15000
where class like 'fortran' and sid = 100;

# summer 테이블을 조회해보면 fortran 강좌의 수강료가 1건만 수정되었음
select *
from summer;

# fortran 수강료를 조회하면 두 건이 나옴(데이터 불일치 문제 발생)
select price 'fortran 수강료'
from summer
where class like 'fortran';

# 다음 실습을 위해 fortran 강좌의 수강료를 다시 20000원으로 복구
update summer
set price = 20000
where class like 'fortran';

# 다음 실습을 위해 sid가 null인 투플 삭제
delete
from summer
where sid is null;

/* 실습준비
drop table if exists summerprice;
drop table if exists summerenroll;

create table summerprice
( class varchar(20),
price integer);

insert into summerprice values ('fortran', 20000);
insert into summerprice values ('pascal', 15000);
insert into summerprice values ('c', 10000);

select *
from summerprice;

create table summerenroll
(sid integer,
class varchar(20));

insert into summerenroll values (100, 'fortran');
insert into summerenroll values (150, 'pascal');
insert into summerenroll values (200, 'c');
insert into summerenroll values (250, 'fortran');

select *
from summerenroll;
*/

-- 2. 이상없음
-- 1) 삭제이상 없음 / 200번 학생의 계절학기 수강신청을 취소하시오
select price 'c 수강료'
from summerprice
where class like 'c';

set SQL_SAFE_UPDATES=0;
delete from summerenroll
where sid = 200;

select *
from summerenroll;

# c 강좌의 수강료가 존재하는지 확인
select price 'c 수강료'
from summerprice
where class like 'c';

-- 2) 삽입이상 없음/ 계절학기에 새로운 자바 강좌를 개설하시오
# 자바 강좌 삽입, null 값을 입력할 필요 없음
insert into summerprice values('java', 25000);

select *
from summerprice;

# 수강신청 정보 확인
select *
from summerenroll;

-- 3) fortran 강좌의 수강료를 20000원에서 15000원으로 수정하시오
update summerprice
set price = 15000
where class like 'fortran';

select price 'fortran 수강료'
from summerprice
where class like 'fortran';

