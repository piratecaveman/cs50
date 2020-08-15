SELECT movies.title FROM movies,ratings
WHERE movies.id IN
(
    SELECT ratings.movie_id FROM ratings
    WHERE ratings.movie_id IN
    (
        SELECT stars.movie_id FROM stars
        WHERE stars.person_id IN
        (
            SELECT people.id FROM people
            WHERE people.name = "Chadwick Boseman"
        )
    )
)
AND movies.id = ratings.movie_id
ORDER BY ratings.rating DESC
LIMIT 5;