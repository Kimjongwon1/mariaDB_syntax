베타적 락
공유락
베타락
카디널리티 : 열데이터의 종류와 갯수
카디널리티가 높은곳에 인덱스 걸기
중복도가 ‘낮으면’ 카디널리티가 ‘높다’고 표현한다.
중복도가 ‘높으면’ 카디널리티가 ‘낮다’고 표현한다.
인덱스의 단점 및 유의사항
단점
-인덱스는 데이터의 복사본을 유지하므로, 테이블 데이터보다 추가 공간 필요
insert, update, delete 와 같은 쓰기작업에서는 인덱스가 성능저하를 유발

유의사항
- 낮은 카디널리티에 인덱스를 설정하면, 인덱스를 사용한 검색이 전체 테이블 스캔만큼이나 비효율적*카디널리티:데이터의종류
	예를들어 1명의 저자가 1000개의 글을 썻다고 가정하고 author_id로 인덱스 페이지를 만들어도 root페이지를 1,2,3...등을 모두 찾아야 하는 상황이 생길수있음


자동으로 index걸리는 것들은 크게 문제x
->pk, unique, fk
->내가 직접 index를 만들때

1)author name으로 단일컬럼 index
select * from author where name = 'abc'
2)복합컬럼 index: author의 name, email index
select * from author where name ='abc' and email ='x

사용자 관리
->특정사용자에게 특정권한만 줄수있다.
->계정생성
->마케팅팀에게 select 권한준다고 가정 post 테이블

view:가상의 테이블


user생성
show grant
grant insert 권한 부여
flush privileges;
show grant


view 
는 데이터베이스의 테이블과 유사한 구조를 가지지만, 가상의 테이블로서 실제 데이터를 저장하지않는 데이터베이스, 실제 데이터베이스를 참조만

	create view author_for_view(뷰네임) as 
	select 컬럼1, 컬럼2
	from 테이블명;
ex)create view author_for_view as select id, name from author;
	select * from author_for_view;
특징
	복잡한 쿼리 결과를 뷰로 생성해두면, 이후에는 뷰를 간단한 쿼리로 호출
	CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw';
	grant select on [데이터베이스 이름].[뷰이름]TO''testuser'@'localhost';
	flush privileges;


sql 선언적 언어
프로시저 :절차적 언어

저장 프로시저
-stored procedure는 데이터베이스에 저장되어 실행될 수 있는 하나 이상의 sql문의 집합

-특성
 -GRANT EXECUTE ON PROCEDURE 데이터베이스명.프로시저명 TO 'testuser'@'localhost';
프로시저 생성
DELIMITER//
CREATE PROCEDURE procedure_name(parameters)
BEGIN
	--sql문법
END //
DELIMITER;

프로시저 호출
call 프로시저명();

프로시저 네임:getUser(IN userid INT)
where id = userid
파라미터는 생략가능, 함수와 같이 parameter를 전달하여 실행하는것도 가능
- 기본형은 (IN 변수명 변수타입)

post테이블에 쉽게 insert 할 수 있는 post 관련 프로시저 생성
사용자에게 title, contents, author_id 만 입력받아 insert 하는 insert문 생성
DELIMITER//
CREATE PROCEDURE author_insert(IN title varchar(255) , contents varchar(3000), author_id INT)
BEGIN
	insert into author(title, contents,author_id )values(title, contents,author_id);
END //
DELIMITER;

 변수선언
DECARE 변수명 변수타입 [DEFAULT default_value];
반드시 프로시저나 함수의 본문 시작 부분, 즉 BEGIN바로 뒤에 위치
 변수 수정
	set 변수명 = 수정 할 값
제어문
if
DECLARE abc INT DEFAULT 0
select 컬럼명 into  변수
 if 조건식 THEN
	->조건참일떄 실행할 명령어
	 ELSE
	->조건이 거짓일때 실행할 명령어
	END IF;
"select 컬럼명 into 변수"문과 함께 많이 사용
while 
	while 조건식 DO
	-조건이 참일 동안 반복 실행할 명령'
	END WHILE;


실습 post 테이블에 if문을 활용하여 고액 원고료 작가 조회


select avg(price) from post where author_id=2;

DELIMITER //
CREATE procedure post_price(IN author_id INT)
BEGIN
	DECLARE avg_price INT DEFAULT 0;
	select avg(price) into avg_price from post where author_id = author_id;
	if avg_price>10000 THEN
	select "고액 원고료 작가입니다" as message;
	ELSE
	select "고액 원고료 작가입니다" as message;
	END IF;
END //
DELIMITER ;

call post_price(1);


