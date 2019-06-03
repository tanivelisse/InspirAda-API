# InspirAda-API

### GA SEI Capstone Project

InspirAda blog app was originally built as full stack MVC app with CRUD functionalities using Ruby Sinatra and SQL. This was a pair programing project. 

Ruby Fullstack Version: (https://github.com/veda07/ruby-project)

This version is refacture with a React front-end and a Ruby API back-end. 

InspirAda React repository: (https://github.com/tanivelisse/InspirAda)

### Routes 

| Method | Path | Action|
|--------|------|-------|
| POST | /users/register | register a new user |
| POST | /users/login | log in a new user |
| GET | /users/{user id}| get user information and posts |
| GET | /users/logout| logout user |
| GET | /posts | get list of all post |
| POST | /posts/new_post | add post to DB |
| PUT | /posts/{post id} | edit post and save in DB |
| DELETE | /posts/{post id} | delete post from DB |

### SQL Create Routes

```
CREATE DATABASE inspirada_in_tech;


\c inspirada_in_tech


CREATE TABLE users(
  id SERIAL PRIMARY KEY, 
  username VARCHAR(255),
  password_digest VARCHAR(255),
  email TEXT,
  about TEXT
);

CREATE TABLE posts(
  id SERIAL PRIMARY KEY, 
  photo_url TEXT,
  f_name VARCHAR(255),
  l_name VARCHAR(255),
  category VARCHAR(255),
  title TEXT,
  body TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT now(),
  -- post belongs to user
  user_id INTEGER REFERENCES users(id)
);

CREATE TABLE comments(
  id SERIAL PRIMARY KEY,
  body TEXT,
  date TIMESTAMP,
  user_id INTEGER REFERENCES users(id),
  post_id INTEGER REFERENCES posts(id)
);

```

*** 

Copy Right © TIMP 2019