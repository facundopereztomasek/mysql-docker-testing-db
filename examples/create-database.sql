-- This remove the databse if it exists
DROP DATABASE IF EXISTS movies;

-- This creates the database with the utf8 charset encoding
CREATE DATABASE movies
CHARACTER SET utf8
COLLATE utf8_bin;

-- This tells mysql to select the movies database in order to run next senteces
USE movies;

-- Creates movies table
CREATE TABLE movies (
  id	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  title	VARCHAR(255) NOT NULL,
  year	YEAR
) ENGINE=INNODB;

-- Creates genres table
CREATE TABLE genres (
  id	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name	VARCHAR(255) NOT NULL
) ENGINE=INNODB;

-- Creates pivot table (many to many: many movies has many genres)
CREATE TABLE movie_genres (
  movie_id	INT UNSIGNED,
  genre_id	INT UNSIGNED,

  FOREIGN KEY (movie_id)
  REFERENCES movies(id)
  ON DELETE CASCADE,

  FOREIGN KEY (genre_id)
  REFERENCES genres(id)
  ON DELETE CASCADE

) ENGINE=INNODB;


-- Insert some movie genres
INSERT
INTO
  genres (name)
VALUES
  ('Acción'),
  ('Suspenso'),
  ('Infantil'),
  ('Terror'),
  ('Policial'),
  ('Animación'),
  ('Ficción');

-- Insert some movie titles
INSERT
INTO
  movies (title, year)
VALUES
  ('Toy Story', 1997),
  ('Matrix', 2003);

-- Insert some movie-genre relationships
INSERT
INTO
  movie_genres (movie_id, genre_id)
VALUES
  (1, 3),
  (1, 6),
  (2, 1),
  (2, 2),
  (2, 7);

-- Select movies with genres
SELECT *
FROM movies
LEFT JOIN movie_genres ON movies.id = movie_genres.movie_id
LEFT JOIN genres ON genres.id = movie_genres.genre_id;