PRAGMA foreign_keys = ON;

DROP TABLE if EXISTS users;
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL 
);
---
DROP TABLE if EXISTS questions;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE if EXISTS question_follows;

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    foreign key (user_id) REFERENCES users(id),
    foreign key (question_id) REFERENCES questions(id)
);
DROP TABLE if EXISTS replies;

CREATE TABLE replies (
    id INTEGER PRIMARY KEY ,
    reply TEXT NOT NULL,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    reply_id INTEGER,
    foreign key (user_id) REFERENCES users(id),
    foreign key (question_id) REFERENCES questions(id),
    foreign key (reply_id) REFERENCES replies(id)
);
-- DROP TABLE if EXISTS question_likes;

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liked BOOLEAN ,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    foreign key (user_id) REFERENCES users(id),
    foreign key (question_id) REFERENCES questions(id)
);

--seeding 

INSERT INTO 
    users(fname,lname)
VALUES
    ('Vincent','Pham'),
    ('Misha', 'Bansal');

INSERT INTO
    questions(title,body,user_id)
VALUES
    ('first question','How do we use SQL?',(SELECT id FROM users WHERE fname = 'Misha')),
    ('second question','Why do we use SQL?',(SELECT id FROM users WHERE fname = 'Vincent'));

INSERT INTO
    question_follows(user_id,question_id)
VALUES
    (2,2),
    (1,1);

INSERT INTO 
    replies(reply, user_id, question_id,reply_id)
VALUES
    (':)',2,1,NULL),
    ('this question sucks xp',1,1,1);


INSERT INTO
    question_likes(liked,user_id,question_id)
VALUES
    (TRUE,2,2),
    (TRUE,1,1);

