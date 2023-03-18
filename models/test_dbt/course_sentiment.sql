WITH details as (
    SELECT
        user_id,
        course_id,
        fcq_score_cat1,
        fcq_score_cat2,
        fcq_score_cat3,
        fcq_score_cat4,
        fcq_score_cat5,
        fcq_score_cat6,
        professor_id,
        aggregate_sentiment
    FROM 
        no_pii.ido_sent
),

WITH courses AS (
    SELECT
        id,
        course_name,
        division,
        course_level,
        department_id
    FROM 
        c.sl
    WHERE 
        course_level <= 4999
),

WITH sentiment_avg as (
    SELECT
        course_name,
        professor_id,
        avg(aggregate_sentiment) as avg_sentiment_score
    FROM 
        details as d
    LEFT JOIN
        courses as c
        ON d.course_id = c.id
    HAVING sum(aggregate_sentiment) > 0
)

SELECT 
    * 
FROM 
    sentiment_avg as sentiment
LEFT JOIN 
    prof.stat_det
    ON sentiment.professor_id = prof_d.id
WHERE
    prof_d.status in ('Current', 'Future')
