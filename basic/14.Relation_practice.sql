use board;

create view author_for_view as select id, name from author;
select * from author_for_view;
select * from author;
select * from post;
CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'testpw';
describe post;
DELIMITER //
CREATE PROCEDURE getUser(IN userid INT)
BEGIN
	select * from author where id = userid;
END //
DELIMITER ;

CALL getUser(1);

show create procedure post_insert;


DELIMITER //
CREATE PROCEDURE post_insert(IN title varchar(255) , contents varchar(3000), author_id INT)
BEGIN
	insert into post(title,contents,author_id )values(title, contents,author_id);
END //
DELIMITER ;

CALL post_insert('김거북','compst','4');

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

DELIMITER //
CREATE procedure post_c(IN author_id INT)
BEGIN
DECLARE a int DEFAULT 0;
while a<10 DO
	select concat("Hello world",a) as A;
    set a = a+1;
END WHILE;
END //
DELIMITER ;

DELIMITER //
CREATE procedure insert_c()
BEGIN
DECLARE a int DEFAULT 7;
while a<= 1000 DO
		insert author(id, name) values(a, concat("Kim",a));
		set a = a+1;
END WHILE;
END //
DELIMITER ;

describe author;
call insert_c();
select * from author;
delete from author;
describe post;
select * from post;
delete from post;

CREATE TABLE author_address(id INT, country VARCHAR(255), state_city VARCHAR(255),details VARCHAR(255),zip_code INT(11),phonenumber INT,author_id int(11),
FOREIGN KEY(author_id) REFERENCES author(id));

select * from author_address;
describe author_address;
-- ALTER TABLE author_address MODIFY COLUMN author_id not null;
-- ALTER TABLE author_address DROP author_id int(11) FOREIGN KEY(author_id) REFERENCES author(id) on delete cascade;
SHOW CREATE TABLE author_address;

ALTER TABLE author_address 
ADD FOREIGN KEY (author_id) 
REFERENCES author (id)
ON DELETE CASCADE;
DROP TABLE author_address ;
-- CREATE TABLE `author_address` (
--   `id` int(11) DEFAULT NULL,
--   `country` varchar(255) DEFAULT NULL,
--   `state_city` varchar(255) DEFAULT NULL,
--   `details` varchar(255) DEFAULT NULL,
--   `zip_code` int(11) DEFAULT NULL,
--   `phonenumber` int(11) DEFAULT NULL,
--   `author_id` int(11) DEFAULT NULL,
--   KEY `author_id` (`author_id`),
--   CONSTRAINT `author_address_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci



CREATE TABLE `author_address` (
  `id` int(11) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `state_city` varchar(255) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL,
  `phonenumber` int(11) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  KEY `author_id` (`author_id`),
  CONSTRAINT `author_address_ibfk_2` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

select * from author_address;

describe author_address;

select * from post;


select * from author;


create table author2(id INT primary key, name VARCHAR(255));
create table author_addre(id INT, primary key(id), city varchar(255),
author_id INT, foreign key(author_id) references author2(id), unique(author_id));


create table post2(id INT, title VARCHAR(30), content VARCHAR(255), primary key(id));


select * from author2;

create table post_authors(id int, author_id int, post_id int, foreign key(author_id) references author(id),
foreign key(post_id) references post(id));



 
  CREATE DATABASE ordersystem;
use ordersystem;

CREATE TABLE MEMBERS(id INT, user VARCHAR(255), admin VARCHAR(255),seller VARCHAR(255), PRIMARY KEY (id));
select * from MEMBERS;
CREATE TABLE ITEMS(
id INT, 
product_name VARCHAR(255), 
price int, 
stock int, unique(stock),unique(product_name),
PRIMARY KEY (id),
buyer_id INT NOT NULL, foreign key(buyer_id) references MEMBERS(id), unique(buyer_id));

select * from ITEMS;
describe ITEMS;
CREATE TABLE ORDERS(id INT NOT NULL, orders VARCHAR(255), address VARCHAR(255),  PRIMARY KEY (id),
unique(id));
select * from ORDERS;
Drop table ORDERS;
Drop table ITEMS;

CREATE TABLE orders_details(id INT NOT NULL,PRIMARY KEY (id),unique(id),
Order_stock INT,
Order_product_name VARCHAR(255),
Order_id INT NOT NULL,
foreign key(Order_stock) references ITEMS(stock),
foreign key(Order_product_name) references ITEMS(product_name),
foreign key(Order_id) references ITEMS(buyer_id));


select * from orders_details;
select * from orders;
select * from ITEMS;

describe ITEMS;
describe orders;
describe orders_details;
 

-- * F.K를 쓰려면 빼오려는 테이블,요소에 P.K 혹은 unique 조건이 걸려 있어야 F.K 선언을 할 수 있다.