ALTER TABLE post MODIFY COLUMN contents VARCHAR(3000) not null;
ALTER TABLE author ADD COLUMN address varchar(255);
SHOW CREATE TABLE post;

drop table post;

CREATE TABLE `post` (
  `id` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contents` varchar(3000) NOT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `author_id` (`author_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ;
describe post;