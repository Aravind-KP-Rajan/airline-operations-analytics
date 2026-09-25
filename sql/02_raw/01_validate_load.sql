-- Validate total rows, date parsing, and the full-year date range.
-- FL_DATE is text in RAW, so convert it before finding MIN and MAX.
SELECT
    COUNT(*) AS TOTAL_ROWS,
    COUNT_IF(
        TRY_TO_DATE(SPLIT_PART(FL_DATE, ' ', 1), 'MM/DD/YYYY') IS NULL
    ) AS UNPARSEABLE_DATES,
    MIN(TRY_TO_DATE(SPLIT_PART(FL_DATE, ' ', 1), 'MM/DD/YYYY'))
        AS FIRST_FLIGHT_DATE,
    MAX(TRY_TO_DATE(SPLIT_PART(FL_DATE, ' ', 1), 'MM/DD/YYYY'))
        AS LAST_FLIGHT_DATE
FROM AIRLINE_DB.RAW.BTS_ONTIME_2024;

-- Confirm that all 12 calendar months were loaded.
SELECT
    DATE_TRUNC(
        'MONTH',
        TRY_TO_DATE(SPLIT_PART(FL_DATE, ' ', 1), 'MM/DD/YYYY')
    ) AS FLIGHT_MONTH,
    COUNT(*) AS FLIGHT_ROWS
FROM AIRLINE_DB.RAW.BTS_ONTIME_2024
GROUP BY FLIGHT_MONTH
ORDER BY FLIGHT_MONTH;
