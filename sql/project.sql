USE prj2;

# 게시물 테이블 생성
CREATE TABLE board
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(100)  NOT NULL,
    content  VARCHAR(1000) NOT NULL,
    writer   VARCHAR(100)  NOT NULL,
    inserted DATETIME      NOT NULL DEFAULT NOW()
);

SELECT *
FROM board
ORDER BY id DESC;

CREATE TABLE member
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    email     VARCHAR(100) NOT NULL UNIQUE,
    password  VARCHAR(100) NOT NULL,
    nick_name VARCHAR(100) NOT NULL UNIQUE,
    inserted  DATETIME     NOT NULL DEFAULT NOW()
);

use prj2;

SELECT *
FROM member;

DESC member;

# board 테이블 수정
# writer column 지우기
# member_id column reference member(id)
ALTER TABLE board
    DROP COLUMN writer;
ALTER TABLE board
    ADD COLUMN member_id INT REFERENCES member (id) AFTER content;

UPDATE board
SET member_id = (SELECT id FROM member ORDER BY id DESC LIMIT 1)
WHERE id > 0;

ALTER TABLE board
    MODIFY COLUMN member_id INT NOT NULL;

DESC board;

SELECT *
FROM board
ORDER BY id DESC;

SELECT *
FROM member
WHERE email = 'ww@ww';

DELETE
FROM member
WHERE email = 'ww@ww';

DELETE
FROM member
WHERE id = 12;

# 권한 테이블
CREATE TABLE authority
(
    member_id INT         NOT NULL REFERENCES member (id),
    name      VARCHAR(20) NOT NULL,
    PRIMARY KEY (member_id, name)
);

SELECT *
FROM member
         JOIN authority a on member.id = a.member_id;

INSERT INTO authority (member_id, name)
VALUES (25, 'admin');

USE prj2;

# 게시물 여러개 입력
INSERT INTO board
    (title, content, member_id)
SELECT title, content, member_id
FROM board;

DESC board;

SELECT COUNT(*)
FROM board;

# INSERT INTO board
#     (title, content, writer)
# SELECT title, content, writer
# FROM board;


DESC board;

SELECT *
FROM member;

UPDATE member
SET nick_name = 'abcdd'
WHERE id = 31;
UPDATE member
SET nick_name = 'efgh'
WHERE id = 30;

UPDATE board
SET board.member_id = 31
WHERE id % 2 = 0;

UPDATE board
SET board.member_id = 30
WHERE id % 2 = 1;

UPDATE board
SET title   = 'abc def',
    content = 'ghi jkl'
WHERE id % 3 = 0;

UPDATE board
SET title   = 'mno pqr',
    content = 'stu vwx'
WHERE id % 3 = 1;

UPDATE board
SET title   = 'yz1 234',
    content = '567 890'
WHERE id % 3 = 2;

USE prj2;
DESC board;

CREATE TABLE board_file
(
    board_id INT          NOT NULL REFERENCES board (id),
    name     VARCHAR(500) NOT NULL,
    PRIMARY KEY (board_id, name)
);

DESC board_file;

SELECT *
FROM board_file;

DESC board_file;

ALTER TABLE board_file
    DROP CONSTRAINT prj2.board_file.board_file_ibfk_1;

ALTER TABLE board_file
    ADD CONSTRAINT fk_board
        FOREIGN KEY (board_id) REFERENCES board (id)
            ON DELETE CASCADE;



SELECT rc.CONSTRAINT_NAME,
       kcu.TABLE_NAME,
       kcu.COLUMN_NAME,
       kcu.REFERENCED_TABLE_NAME,
       kcu.REFERENCED_COLUMN_NAME,
       rc.UPDATE_RULE,
       rc.DELETE_RULE
FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc
         JOIN
     INFORMATION_SCHEMA.KEY_COLUMN_USAGE kcu
     ON
         rc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
             AND rc.CONSTRAINT_SCHEMA = kcu.TABLE_SCHEMA
WHERE kcu.TABLE_NAME = 'board_file'
  AND kcu.TABLE_SCHEMA = 'prj2'; -- 'your_database_name'을 실제 데이터베이스 이름으로 변경

ALTER TABLE board_file
    DROP FOREIGN KEY fk_board;

ALTER TABLE board_file
    ADD CONSTRAINT board_file_ibfk_1
        FOREIGN KEY (board_id) REFERENCES board (id)
            ON DELETE RESTRICT;

SELECT *
FROM board_file
ORDER BY board_id DESC;

DELETE
FROM board_file
WHERE name = 'rrr.png';

# board_like 만들기
CREATE TABLE board_like
(
    board_id  INT NOT NULL REFERENCES board (id),
    member_id INT NOT NULL REFERENCES member (id),
    PRIMARY KEY (board_id, member_id)
);

SELECT *
FROM board_like;
