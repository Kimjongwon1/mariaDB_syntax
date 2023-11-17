환경변수란?
주요제약조건(pk,fk) -> index가 자동생성 
index는 조회성능을 높이기 위해 생성

역순 정렬하기
상위  n개 레코드
여러 기준으로 정렬하기
이름이 없는 동물의 아이디

DDL, DML -전체실습
게시판회원은 총 5명이 되도록 만들고, 게시판에 실명으로 글이 쓰여진 게시글은 총 3건, 익명으로 글이 쓰여진 글은 총 2건이 있도록 데이터 insert
insert into post(id, title, contents,author_id)values('4','computer426','68','4');


게시판의 회원을 모두 delete ,기존 포스팅된글은 삭제되지 않고 남아있게 하라
hint)where author_id is not null

use board;
delete from author;
update post set author_id = null where author_id is not null;
update post set title = 'computer2' where id=2;

post의 글을 3개만 조회하되, title을 기준으로 오름차순으로하고 만약 제목이 같은 경우 contents로 내림 차순이 되도록 조회
select * from post order by title asc, contents desc limit 3;



타입(문자타입)

테이블의 타입확인
describe 테이블명

숫자타입
정수 TINYINT
	-128~127 범위 1바이트
	java와 byte의 매핑
INT 
	4바이트
	java의 int타입과 매핑
BIGINT
	8바이트
	java의 long타입과 매핑
UNSIGNED타입을 사용하여 양수만 표현가능
	표현값 2배로 증가
	TINYINT UNSIGNED 이렇게 사용한다면 255까지 사용가능

실수
부동 소수점 타입
	float,double
	오차 발생여지 있음
고정 소수점 타입
	Decimal(M,D)->소수점 쓸 때 쓴다.(ex ->create table post(price DECIMAL(10,3))
	java의 Bigdecimal	
	M은 총자릿수 (정수부+소수부)를 의미하고, 65자리까지 표현가능
	D는 소수부 의미	
	정확한 숫자 표현을 위해 사용
실습
author 테이블에 age 데이터 tinyint unsigned로 추가
ALTER TABLE author ADD COLUMN age tinyint unsigned;
잘됨 insert into author(id,name,email,password,role,address,age)values('1','김거북','abc@naver.com','1234','1','1','12')	1 row(s) affected	0.000 sec


	255초과로 insert 테스트
->오류 발생 insert into author(id,name,email,password,role,address,age)values('2','김자라','abcd@naver.com','12345','2','2','256')	Error Code: 1264. Out of range value for column 'age' at row 1	0.000 sec

post에 price라는 원고료칼럼을 추가,원고료 칼럼은 총 자릿수 10자리 및 소수점단위는 3자리까지가능
	컬럼 추가 후 비어있는 컬럼에 숫자 update test(소숫점 3이하 test, 소숫점 3초과 테스트)

ALTER TABLE post ADD COLUMN price DECIMAL(10,3);
select * from post;
update post set price = '1.533' where id=2;
update post set price = '1.5334' where id=3;
update post set price = '1.5334' where id=3	1 row(s) affected, 1 warning(s):
 1265 Data truncated for column 'price' at row 1
 Rows matched: 1  Changed: 1  Warnings: 1	0.000 sec


문자타입

CHAR, VARCHAR
CHAR(M=255)->10바이트->255바이트 차지
	M은 문자열 최대 길이를 의미
	고정 길이의 문자열(0~255까지 설정가능)
	정해진 자릿수 문자에 제한을 두기 위해서는 사용
VARCHAR(M=255)->10바이트->10바이트차지
	java의 String 사용시 varchar
	0~65,535까지 설정 가능
	가변길이의 문자열(M을 통해 길이지정)
	길이를 지정하더라도 실제 입력된 문자열의 길이만큼만 저장하고 사용
	일반적으로 가장 많이 사용

TEXT
	가변 길이 문자열
	text:65,535바이트 저장 가능한 가변길이 문자열을 위한 타입
	varchar보다 더 큰 범위의 표현이 가능 ex)LONGTEXT는 4GB
	disk에 저장해서 조회속도가 VARCHAR(메모리저장)에 비해 느림
	index사용의 어려움(B-tree인덱싱 불가, Full-Text 인덱스 가능)

BLOB
다양한 킥의 바이너리 데이터를 저장 할 수 있는 타입
일반적으로 PNG같이 이미지 파일을 저장할 때 지정하는 타입

--
실습
ex)
Create table table_blob(id int, myimg blob);
INSERT INTO table_blob(id,myimg) Values(1,LOAD_FILE('C:\Users\Playdata\Pictures\test_picture'));
SELECT HEX(myimg) FROM table_blob WHERE id =1;

Create table table_blob(id int, myimg longblob);
select * from table_blob;
drop table table_blob; ->쓴 이유 longblob으로 형식을 바꿔서 처음했던 blob형식을 drop 하기위해
describe table_blob;
INSERT INTO table_blob(id,myimg) Values(4,LOAD_FILE('"C:\\Users\Playdata\Pictures\test_picture.png"'));
SELECT HEX(myimg) FROM table_blob WHERE id =4;

--

ENUM
	미리 들어갈수 있는 특정 데이터의 값을 지정
	칼럼명 ENUM('데이터값1','데이터값2'...)
	NOT NULL DEFAULT'user'등의 옵션도 추가 가능

--
실습
role 타입 enum타입으로 변경하고,
'user','admin'으로 enum타입 지정. not null로 설정하되,
입력이 없을시에는 'user'로 세팅되도록 default 설정

dml test)
admin으로 데이터 세팅 후 insert
insert into author(id,name,email,password,role,address,age)values('1', '김자라', 'abcd@naver.com', '12345', 'admin', '2', '25'
);
super-user 데이터로 insert
insert into author(id,name,email,password,role,address,age)values('2','박자라','abcde@naver.com','123345','super-user','2','24')	Error Code: 1265. Data truncated for column 'role' at row 1	0.000 sec

role데이터 없이 insert
insert into author(id,name,email,password,address,age)values('3','최자라','abcfde@naver.com','123345','2','22');