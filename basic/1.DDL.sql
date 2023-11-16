-- 데이터베이스 생성
CREATE DATABASE DB이름(ex)board);
-- 데이터베이스 선택
USE board;
-- 테이블 신규생성
CREATE TABLE author(id INT, name VARCHAR(255), email VARCHAR(255),password VARCHAR(255),
test1 VARCHAR(255), PRIMARY KEY (id));
PRIMARY KEY를 걸게되는 컬럼에 대해서는 unique, not null 제약 조건 부여
-- 테이블 목록조회
SHOW TABLES;
-- 테이블 컬럼조회
DESCRIBE author;
-- post 테이블 신규 생성
CREATE TABLE posts(id INT PRIMARY KEY,title VARCHAR(255), content VARCHAR(255), author_id INT,FOREIGN KEY(author_id) REFERENCES author(id));
외래키가 설정되면, post테이블 데이터의 생성, 삭제,수정에 대해 제약이 발생
    만약 not null 조건이 있다면, author_id가 데이터는 post에 생성불가
    author가 삭제될때 post에 데이터가 남아있으면 author삭제불가
    author의 id가 수정될 때 post에 데이터가 남아있으면 author 수정불가
삭제,수정에 대해서는 기본적으로 제약(restrict)를 갖고 있으나, 옵션을 줘서 변경 가능

-- 테이블,컬럼 상세조회
show full columns from author;

-- 테이블 생성 후 확인 
SHOW TABLES;

-- 컬럼정보조회 
DESCRIBE author;

-- 테이블 생성문 조회
SHOW CREATE TABLE posts;
=
-- 'CREATE TABLE `posts` (
--   `id` int(11) NOT NULL,
--   `title` varchar(255) DEFAULT NULL,
--   `content` varchar(255) DEFAULT NULL,
--   `author_id` int(11) DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   KEY `author_id` (`author_id`),
--   CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci'

-- 테이블 제약조건 조회
SELECT * FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'posts';

-- 인덱스 조회
    SHOW INDEX FROM 테이블명;
    ex) SHOW INDEX FROM posts;
    제약조건 정보조회와 인덱스(인덱스만 따로 만들수있음)조회는 상당수 일치(pk,fk 제약조건은 인덱스를 생성)
    인덱스란 조회의 성능을 높이기 위한 별도 페이지

-- 테이블 생성
CREATE TABLE 테이블이름
(
    필드이름1 필드타입1[제약조건],
    필드이름2,필드타입2[제약조건],
    ...
    [테이블제약조건]
);
-- 제약조건 추가방법
-- 필드에 
해당 필드에 적용할 제약조건을 선택적으로 지정가능
ex)CREATE TABLE author(id INT, name VARCHAR(255), email VARCHAR(255),password VARCHAR(255),
test1 VARCHAR(255), PRIMARY KEY (id));
-- 테이블
테이블 전체에 적용될 제약조건을 선택적으로 지정가능
ex)CREATE TABLE posts(id INT PRIMARY KEY,title VARCHAR(255), content VARCHAR(255), author_id INT,FOREIGN KEY(author_id) REFERENCES author(id));
-- ALTER
-- 테이블 이름변경
ex)ALTER TABLE 테이블명(posts) RENAME 새로운 테이블명(post);
ALTER TABLE posts RENAME post;
-- 컬럼추가
ALTER TABLE 테이블명 ADD COLUMN 컬럼명 자료형(NULL 또는 NOTNULL);
ALTER TABLE author ADD COLUMN role VARCHAR(50);

-- 컬럼변경(덮어쓰기됨)
ALTER TABLE 테이블명 MODIFY COLUMN 컬럼명 타입[제약조건->null,  not null]
ALTER TABLE author MODIFY COLUMN name VARCHAR(100) not null;

-- 컬럼이름변경 content->contents
ALTER TABLE 테이블명 CHANGE COLUMN 기존컬럼명 새로운 컬럼명 타입[제약조건->null,  not null]
ALTER TABLE post CHANGE COLUMN content contents varchar(255);
-- 칼럼삭제 -> test1삭제
ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
ALTER TABLE author DROP COLUMN test1;

-- 테이블 삭제
DROP TABLE 이름
-- 테이블의 데이터만을 지우고 싶을 때
DELETE FROM 테이블이름
TRUNCATE TABLE 테이블이름
-- IF EXISTS
특정 객체(데이터베이스나 테이블)가 존재하는 경우에만 명령어를 실행
DROP DATABASE 또는 TABLE IF EXISTS abc;

-- 실습
1.post 테이블의 contents 칼럼 글자수 3000으로 변경
ALTER TABLE post MODIFY COLUMN contents VARCHAR(3000) not null;
2.author테이블에 address칼럼 varchar(255)로 추가
ALTER TABLE author ADD COLUMN address varchar(255);
3.post 테이블 생성문 미리 확인 ->post 테이블 삭제->post테이블 다시생성
-- 'CREATE TABLE `post` (
--   `id` int(11) NOT NULL,
--   `title` varchar(255) DEFAULT NULL,
--   `contents` varchar(3000) NOT NULL,
--   `author_id` int(11) DEFAULT NULL,
--   PRIMARY KEY (`id`),
--   KEY `author_id` (`author_id`),
--   CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci'