CREATE TABLE users(
  id serial PRIMARY KEY,
  first_name text,
  last_name text,
  email_address text NOT NULL,
  screen_name text NOT NULL
);

CREATE TABLE posts(
  id serial PRIMARY KEY,
  author_id integer REFERENCES users ,
  title text NOT NULL,
  content text NOT NULL,
  created timestamp DEFAULT now()
);

CREATE TABLE tags(
  id serial PRIMARY KEY,
  tag_text text NOT NULL 
);

CREATE TABLE comments(
  id serial PRIMARY KEY,
  author_id integer REFERENCES users,
  post_id integer REFERENCES posts ON DELETE CASCADE,
  content text NOT NULL
);

CREATE TABLE post_tags(
  post_id integer REFERENCES posts(id) ON DELETE CASCADE,
  tag_id integer REFERENCES tags(id),
  PRIMARY KEY(post_id, tag_id)
);

INSERT INTO users(first_name, last_name, email_address, screen_name) VALUES
('Peter', 'Szujewski', 'me@me.com', 'me'),
('Skip', 'Dog', 'skip@dog.com', 'skipper'),
('John', 'Doe', 'john@doe.com', 'johnny'),
('Jane', 'Domer', 'jane@gmail.com', 'janeIsCool'),
('Anthony', 'Rizzo', 'rizzo@gocubs.com', 'rizzzzz') 
returning id, first_name, screen_name;

INSERT INTO posts(author_id, title, content) VALUES
(3, 'Things I love to do', 'Amazing content goes here. This is filler content.'),
(5, 'I love the Cubs', 'Amazing content goes here. This is filler content.'),
(1, 'Eating good food', 'Amazing content goes here. This is filler content.'),
(2, 'Playing outside everyday', 'Amazing content goes here. This is filler content.') 
returning id, title; 

INSERT INTO tags(tag_text) VALUES
('sports'),
('healthcare'),
('lifestlye'),
('music'), 
('weather'),
('pop');

INSERT INTO comments(author_id, post_id, content) VALUES
(3, 2, 'I love the Cubs too. Big fan'),
(5, 3, 'I also eat good food everyday because I am rich and famous'),
(2, 4, 'Leaving a comment on my own post is cool'),
(2, 2, 'Never heard of this before');

INSERT INTO post_tags(post_id, tag_id) VALUES
(3, 2),
(2, 3),
(2, 6),
(1, 3),
(4, 1),
(4, 2),
(4, 5),
(3, 3);
