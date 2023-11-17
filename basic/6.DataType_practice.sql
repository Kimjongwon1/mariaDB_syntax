
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