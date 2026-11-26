-- 4.6 SQL Interview Demonstration #3
-- Average required-course GPA per student per school year,
-- showing only Dean's List results (GPA >= 3.5)

SELECT
    student_id,
    school_year,
    AVG(grade) AS avg_required_gpa
FROM gpa_history
WHERE is_required = 1          -- only required courses
GROUP BY student_id, school_year
HAVING AVG(grade) >= 3.5       -- Dean's List cutoff
ORDER BY school_year, student_id;