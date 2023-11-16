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
