-- insert, select, update, delete
-- INSERT 
테이블에 새로운 레코드를 추가
INSERT INTO 테이블이름(필드이름1,필드이름2,필드이름3) VALUES(데이터값1,데이터값2,...)
ex)
    insert into author(id, name, email)values('1','kim','abc@naver.com');
조회 select * from author;
문자열은 ''로 감싼다.
대소문자로 구분x
-- update
테이블 레코드의 내용 수정
update 테이블 이름 SET 필드이름1=데이터값1,필드이름2=데이터값2, where 필드이름=데이터값
만약where절을 생략하면, 해당 테이블의 모든 레코드값이 위 설정대로 수정되므로 유의
ex)
update author set email='abc2@test.com' where id=1;

여기서 =의 쓰임새는 2가지
where문 뒤에 나오는 비교문은 java기준으로 ==
어떤값을 set할때도 =을 사용하여 대입 (java=과 동일)
-- Delete
Delete FROM 테이블이름 WHERE 필드이름=데이터값
WHERE절을 생략하면,해당 테이블에 저장된 모든 데이터가 삭제
--예제
delete from author where author_id=5;

-- DELETE와 TRUNCATE, DROP의 차이
DROP은 테이블 구조 전체 삭제
DELETE와 TRUNCATE의 차이
delete는 storage까지 삭제하지는 않아 복구가 가능
delete는 log를 남김
delete의 삭제속도는 TRUNCATE보다 느림

-- SELECT
SELECT 필드이름 FROM 테이블이름 [where조건]

select * from member;

예제
select * from author where id =1;
select name, email from author where id=1;
select * from author where id >1;
select * from author where id>1 AND name = 'kim'
-- Select시 중복 제거
select distinct name from author;

-- 선택한 결과의 정렬
-- SELECT문으로 선택한 결과를 Order by 절을 사용하여 정렬
-- 기본설정으로 오름차순(ASC), 내림차순은 desc
-- 여러필드의 데이터를 , 사용 하여 여러기준으로 정렬
-- order by 생략시 pk를 기준으로 오름차순 정렬한 값 변환

-- order by
select * from author order by name desc;

-- order by 멀티: 먼저 쓴 칼럼 우선정렬, asc/desc 생략시 asc 적용
select *from author order by id desc limit 2;

--allias(별칭)을 이용한 처리
--테이블과 필드에 임시로 allias를 부여하고, 해당 allias를 selecte에서 사용(as 생략가능)
select 필드이름 as 별칭 from 테이블명;
-- dPwp
select 필드이름 from 테이블이름 as 별칭;
-- 예제
select name as 이름, email from author as a;