use volcanic_eruptions;

# replace empty values with NULLs
UPDATE
    volcanoes
SET
    last_known_eruption = CASE last_known_eruption WHEN '' THEN NULL ELSE last_known_eruption END;

# all years in eruptions, considering both start_year and end_year
WITH all_years as ( SELECT 
    start_year as eruption_year
FROM
    (SELECT 
        start_year
    FROM
        eruptions
    WHERE
        start_year >= 1900) A
UNION (SELECT 
    end_year
FROM
    eruptions
WHERE
    end_year >= 1900) ORDER BY eruption_year
)
SELECT 
    eruption_year,
    SUM(start_year = ay.eruption_year) AS started_in_year_count,
    SUM(end_year = ay.eruption_year) AS ended_in_year_count,
    COUNT(*) AS total_eruptions
FROM
    all_years ay
        LEFT JOIN
    eruptions e ON ay.eruption_year BETWEEN e.start_year AND e.end_year
GROUP BY ay.eruption_year;

# Volcanoes with most eruptions since 1900 
SELECT 
	SUM(e.end_year-e.start_year+1),
    COUNT(e.eruption_number) eruptions_count,
    CONCAT(v.volcano_name, ' (', v.country, ')') as volcano_name
FROM
    eruptions e
        JOIN
    volcanoes v ON e.volcano_number = v.volcano_number
WHERE
    e.start_year > 1900
GROUP BY v.volcano_name, v.country
ORDER BY eruptions_count DESC
LIMIT 20;

# Longest eruptions
WITH eruptions_with_dates as ( SELECT 
    STR_TO_DATE(CONCAT(e.start_year,
                    '-',
                    e.start_month,
                    '-',
                    e.start_day),
            '%Y-%m-%d') AS start_date,
    STR_TO_DATE(CONCAT(e.end_year, '-', e.end_month, '-', e.end_day),
            '%Y-%m-%d') AS end_date,
            v.volcano_name,
            v.country,
            v.primary_volcano_type
	FROM eruptions e 
		JOIN
		volcanoes v ON e.volcano_number = v.volcano_number
    WHERE start_month > 0 AND start_day>0 AND end_month>0 and end_day>0 
)
SELECT *, DATEDIFF(end_date,start_date) as eruption_days_length 
FROM eruptions_with_dates
ORDER BY eruption_days_length DESC
LIMIT 20
;
