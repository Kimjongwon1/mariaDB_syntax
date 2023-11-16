-- 데이터베이스 생성
CREATE DATABASE DB이름(ex)board);
-- 데이터베이스 선택
USE board;
-- 테이블 신규생성
CREATE TABLE author(id INT, name VARCHAR(255), email VARCHAR(255),password VARCHAR(255),
test1 VARCHAR(255), PRIMARY KEY (id));
-- 테이블 목록조회
SHOW TABLES;
-- 테이블 컬럼조회
DESCRIBE author;
-- post 테이블 신규 생성
CREATE TABLE posts(id INT PRIMARY KEY,title VARCHAR(255), content VARCHAR(255), author_id INT,FOREIGN KEY(author_id) REFERENCES author(id));