DROP DATABASE IF EXISTS inspirada_in_tech;
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
  -- comments belong to user
  user_id INTEGER REFERENCES users(id),
  -- comments belong to posts
  post_id INTEGER REFERENCES posts(id)
);