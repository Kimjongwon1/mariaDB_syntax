
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

실습

post 테이블에 DATETIME으로 createdTime 컬럼 추가 및 default로 현재 시간 들어가도록 설정
	datetime(6) default current_timestamp(6)
	컬럼 추가 후 insert 테스트

ALTER TABLE post ADD COLUMN createdTime datetime(6) default current_timestamp(6);
insert into post(id)values('6');

실습
author 테이블의 id가 1,2,4는 아닌 데이터 조회(NOT IN 사용)
select * from author where id NOT IN(1,2,4);

post 테이블의 id가 2~4까지 데이터 조회
	between활용
	and 조건 활용
	or 조건 활용



describe post;
use board;
select * from post;
select now();
SELECT * FROM post WHERE createdtime >= '2021-01-01' AND createdtime<= '2023-11-17';

ALTER TABLE post MODIFY COLUMN title varchar(255)not null;

ALTER TABLE post MODIFY COLUMN id int AUTO_INCREMENT;

-- post 테이블에 id없이 insert
-- insert한 데이터 삭제 후 다시 insert

insert into post(title, contents)values('kim2','abc@naver.com');

실습
-- post 테이블에 id없이 insert
-- insert한 데이터 삭제 후 다시 insert

'5', 'computer26', '3', NULL, NULL, '2023-12-17 16:25:09.505084'
'7', 'kim2', 'abc@naver.com', NULL, NULL, '2023-11-20 11:33:54.139879'


SELECT BOOK_ID,DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE from BOOK where CATEGORY ='인문' AND DATE_FORMAT(PUBLISHED_DATE, '%Y') = '2021' order by PUBLISHED_DATE ASC;

# 2
SELECT BOOK_ID,DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE from BOOK where CATEGORY ='인문' AND PUBLISHED_DATE like '2021%' order by PUBLISHED_DATE ASC;

# 3
SELECT BOOK_ID,DATE_FORMAT(PUBLISHED_DATE, '%Y-%m-%d') AS PUBLISHED_DATE from BOOK where CATEGORY ='인문' AND PUBLISHED_DATE BETWEEN '2021-01-01' AND '2021-12-31' order by PUBLISHED_DATE ASC;

->AS 굳이 쓸필요없는듯?(내생각)

제약조건 제거
제약조건 목록조회

ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건이름;
ALTER TABLE 테이블명 DROP FOREIGN KEY 제약조건이름;

author테이블 email에 unique 제약 조건 추가
	컬럼 제약조건으로 추가
	제약조건 제거 및 index 제거
	테이블 제약조건 추가형식으로 추가

alter table author MODIFY COLUMN email varchar(255) unique;
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'author';
alter table author DROP CONSTRAINT  email;

alter table author ADD CONSTRAINT unique(email);