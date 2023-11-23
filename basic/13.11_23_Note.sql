- 특정 테이블에 생성된 index 조회
    - show index from 테이블명;
복합(다중 컬럼) 인덱스 생성 : CREATE INDEX index_name ON 테이블명(컬럼1, 컬럼2);

- 권한 변경사항 적용
    - FLUSH PRIVILEGES;

- 특정 사용자 권한 조회
    - SHOW GRANTS FOR 'testuser'@'localhost'


sudo apt-get update

sudo apt-get install -y mariadb-server

sudo systemctl start mariadb
sudo systemctl enable mariadb

멈춘거 실행시키는 기능

sudo mariadb -u root -p

create database board;

use board;
exit

git clone 레파지토리 주소

cd 이동할 폴더

sudo mysql -u root -p  board < 덤프파일명

scp:파일전송관련 명령어

내컴->원격지컴\

DB 설계 -> 한 티읍 ㄹ퉁
회원,게시글
정규화(정제) -> 쪼개는
역정규화->다시합치는



이름 이메일 =>pk
id => pk (꼭 id에만 걸 필요 없다는 뜻)


프로젝트 개요
요구사항(구체적인 내용을 글로)
개념적 모델링(erd_orderingservice.drawio)
논리적 모델링(relation_schema_orderingservice.drawio)


팀프로젝트
팀장 repository->팀원기여 ->x

팀장 repo를 클론->깃헙기능으로 커밋메시지 다 남음(history 남음)



스키마 추가 및 변경
author 테이블을 나누너 author_address 테이블 추가
country,state_city,details,zip code, phonenumber
on delet cascade 옵션
1:1

author와 post의 관계가 N:M 즉, 여러명이서 한 post를 수정할 수 있도록 스키마 수정

필요 산출물
	-ER다이어그램을 통해 추상화
	릴레이셔널 스키마를 통해 구체화
	테이블 생성문(DDL)

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



-- 스키마 설계
주문관리 서비스 설계
요구사항
    모든 테이블 컬럼 자유설계
    ordersystem DB 생성
    해당 서비스에서 회원가입 가능
        -MEMBERS
        -회원의 종류가 user,admin,seller로 구성
    회원이 상품과 재고수량을 등록
        -ITEMS
        -상품명,상품가격,재고
        -누가 등록했는지에 대한 정보가 남아야 함에 유의
    회원이 여러 상품을 한꺼번에 주문가능
        ORDER,ORDER_DETALS
산출물
    ER다이어그램
    스키마 구현
    DDL