1. author에 데이터 5개 넣지말기
    address는 데이터 넣지말기
    select * from author;
insert into author(id, name, email,password,role)values('6','choi','ab43cd@naver.com','12335e4','yes2!');
2. post 데이터 5개 추가
    2개는 저자가 있는 데이터
    2개는 저자가 비어있는 데이터->author_id에 not null 조건없다는거 확인
    1개는 저자가 author테이블에 없는 데이터 추가 -> 에러발생확인

describe post;
select * from post;

insert into post(id, title, contents)values('5','computer26','5');
insert into post(id, title, contents,author_id)values('5','computer26','5',10);

-- UPDATE,DELETE 실습
author 데이터 중 id가 4인 데이터를 email을 abc@naver.com, name을 abc로 변경
update author set name='abc',email='abc@naver.com' where id=4;
post에 글쓴적이 없는 author데이터 1개 삭제
delete from post where id=4;
post에 글쓴적이 있는 author데이터 1개 삭제 ->에러->조치 후 삭제

MariaDB [board]> delete from author where id=2;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`board`.`post`, CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`))
MariaDB [board]> select * from post;
+----+------------+----------+-----------+
| id | title      | contents | author_id |
+----+------------+----------+-----------+
|  3 | computer2  |          |         2 |
|  5 | computer26 | 5        |      NULL |
+----+------------+----------+-----------+
2 rows in set (0.000 sec)

MariaDB [board]> delete from post where id=3;
Query OK, 1 row affected (0.011 sec)

MariaDB [board]> delete from author where id=2;
Query OK, 1 row affected (0.011 sec)

방법 2)
update post set author_id = null where author_id =2;
delete from author where id = 2;

