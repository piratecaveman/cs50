SELECT AVG(ratings.rating) FROM ratings
WHERE ratings.movie_id IN
(
    SELECT movies.id FROM movies
    WHERE movies.year = 2012
);