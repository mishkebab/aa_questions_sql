PRAGMA foreign_keys = ON;
DROP TABLE if EXISTS users;
DROP TABLE if EXISTS questions;
DROP TABLE if EXISTS question_follows;
DROP TABLE if EXISTS replies;
DROP TABLE if EXISTS question_likes;

CREATE TABLE users (
    id INTEGER PRIMARY KEY
    fname TEXT NOT NULL
    lname TEXT NOT NULL 
)

CREATE TABLE questions (
    id INTEGER PRIMARY KEY 
    title TEXT NOT NULL
    body TEXT NOT NULL
    
    foreign key (user_id) REFERENCES users(id)
)

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY

    foreign key (user_id) REFERENCES users(id)
    foreign key (question_id) REFERENCES questions(id)
)

CREATE TABLE replies (
    id INTEGER PRIMARY KEY 
    reply TEXT NOT NULL

    foreign key (user_id) REFERENCES users(id)
    foreign key (question_id) REFERENCES questions(id)
    foreign key (reply_id) REFERENCES replies(id)
)

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY
    liked BOOLEAN 

    foreign key (user_id) REFERENCES users(id)
    foreign key (question_id) REFERENCES questions(id)
    foreign key (reply_id) REFERENCES replies(id)
)

