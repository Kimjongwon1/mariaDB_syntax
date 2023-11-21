- SELECT * FROM tableA INNER JOIN tableB ON tableA.ID = tableB.A_ID
- SELECT * FROM tableA AS a INNER JOIN tableB AS b on a.ID = b.a_id;

author의 테이블은 일단 다조회하고
author가 작성한 글정보를 join 추가적으로 조회

 SELECT * FROM author INNER JOIN post ON author.ID = post.author_id;
 SELECT * FROM author AS a INNER JOIN post AS b on a.ID = b.author_id;
 
 join 실습
--  1)author 테이블과 post 테이블을 join, 글을 작성한 모든 저자의 이름과 해당 글의 제목조회, author는 alias a, post 는 alias post
SELECT name,title  FROM author INNER JOIN post ON author.ID = post.author_id;
SELECT a.name as name, p.title as title FROM author AS a INNER JOIN post AS p on a.id=p.author_id;
-- 2)author 테이블을 기준으로 post 테이블과 join하여, 모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회하십시오, 글을 작성하지 않은 저자의 경우 글 제목은 null표시
SELECT name,ifnull(title,'null') as title  FROM author INNER JOIN post ON author.ID = post.author_id;
select a.name, p.title from author a left join post p on a.id = p.author_id;
-- 3) 위 예제와 동일하게 모든 저자의 이름과 해당 저자가 작성한 글의 제목을 조회, 단 저자의 나이가 25세 이상인 저자만 조회
select a.name, p.title from author a left join post p on a.id = p.author_id where a.age >= 25;
프로그래머스
left 조인 문제) 없어진 기록 찾기
SELECT a.ANIMAL_ID, a.NAME FROM ANIMAL_OUTS a left join ANIMAL_INS b ON a.ANIMAL_ID= b.ANIMAL_ID Where b.ANIMAL_ID is null;

SELECT FROM OUT WHERE ANIMAL_ID NOT IN(OUT과 I의 innerjoin한 다음 id값)
=>
SELECT ANIMAL_ID,NAME FROM ANIMAL_OUTS
WHERE ANIMAL_ID NOT IN(SELECT AO.ANIMAL_ID FROM ANIMAL_OUTS AO INNER JOIN ANIMAL_INS AI 
                      ON AO.ANIMAL_ID = AI.ANIMAL_ID)
                      ORDER BY ANIMAL_ID;

inner 조인 문제) 조건에 맞는 도서와 저자 리스트 출력하기
SELECT B.BOOK_ID,A.AUTHOR_NAME,DATE_FORMAT(B.PUBLISHED_DATE, '%Y-%m-%d')PUBLISHED_DATE
FROM BOOK B INNER JOIN AUTHOR A ON B.AUTHOR_ID = A.AUTHOR_ID WHERE B.CATEGORY = '경제'
ORDER BY B.PUBLISHED_DATE ASC;


select count(*) from author;
select round(avg(author_id),0) from post;
-- --정수값이 안나오므로 정수로 만들기위해서 round 함수를 사용 
select SUM(author_id) from post;
select max(author_id) from post;
select min(author_id) from post;

1)region(여기선 author_id) 별로 sales 평균값을 구하시오, 단 건별로 300달러 이상인 데이타만 평균내서 룰력
하시오 
select author_id, avg(price) from post where price >= 24000 group by author_id;
2)region별로 sales평균값을 구하되 평균값이 300달러 이상인 건만 출력
select author_id, avg(price) from post group by author_id having age(price) >=2000;
3) 1)+2)
select author_id, avg(price) from post where price >= 2000 group by author_id having age(price) >=2000;





코테문제 

-- 코드를 입력하세요
# SELECT DATE_FORMAT(DATETIME,'%H') HOUR, count(ANIMAL_ID) COUNT FROM ANIMAL_OUTS 
# WHERE DATETIME BETWEEN '09' AND '18' group by HOUR having Count(*) order by HOUR asc;

select date_format(DATETIME, '%H') as HOUR, count(*) as COUNT from ANIMAL_OUTS  
Where date_format(DATETIME, '%H:%i') between '09:00' and '19:59'
group by HOUR Order by HOUR;

# SELECT cast(DATE_FORMAT(DATETIME, '%H') as unsigned)AS HOUR, COUNT(*) AS COUNT
# FROM ANIMAL_OUTS WHERE DATE_FORMAT(DATETIME, '%H:%i') BETWEEN '09:00' AND '19:59'
# group by HOUR order by HOUR;



SELECT b.INGREDIENT_TYPE,SUM(a.TOTAL_ORDER) as TOTAL_ORDER 
FROM FIRST_HALF AS a INNER JOIN ICECREAM_INFO AS b on a.FLAVOR = b.FLAVOR group by b.INGREDIENT_TYPE;

select ICE.INGREDIENT_TYPE AS INGREDIENT_TYPE , SUM(FIR.TOTAL_ORDER) AS TOTAL_ORDER
from ICECREAM_INFO as ICE INNER JOIN FIRST_HALF as FIR ON ICE.FLAVOR = FIR.FLAVOR 
group by ICE.INGREDIENT_TYPE
order by TOTAL_ORDER;

cast (값 as 데이터형식)