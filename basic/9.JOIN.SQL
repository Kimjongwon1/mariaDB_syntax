- SELECT * FROM tableA INNER JOIN tableB ON tableA.ID = tableB.A_ID
- SELECT * FROM tableA AS a INNER JOIN tableB AS b on a.ID = b.author_id;


UNION A테이블의 조회결과 UNION B테이블의 조회결과

AUTHOR테이블에서 NAME, email
POST테이블 TITLE, contents
UNION
UNION ALL