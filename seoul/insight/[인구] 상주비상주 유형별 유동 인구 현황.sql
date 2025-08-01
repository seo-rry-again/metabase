WITH
  WEEK_RANGE AS (
    SELECT
      DATE_TRUNC('WEEK', GETDATE()) - INTERVAL '7 DAYS' AS START_OF_LAST_WEEK,
      DATE_TRUNC('WEEK', GETDATE()) - INTERVAL '1 SECOND' AS END_OF_LAST_WEEK
  )
SELECT
  DA.AREA_NAME AS "장소명",
  AVG(RESIDENT_RATIO) AS "상주",
  AVG(NON_RESIDENT_RATIO) AS "비상주"
FROM
  FACT.FACT_POPULATION FP
  JOIN DIM.DIM_AREA DA ON FP.AREA_ID = DA.AREA_ID,
  WEEK_RANGE WR
WHERE
  TO_TIMESTAMP(FP.TIME_KEY::TEXT, 'YYYYMMDDHH24MI') BETWEEN WR.START_OF_LAST_WEEK AND WR.END_OF_LAST_WEEK
GROUP BY
  DA.AREA_NAME
ORDER BY
  CASE
    WHEN {{SORT_BY}} = '상주' THEN AVG(FP.RESIDENT_RATIO)
    WHEN {{SORT_BY}} = '비상주' THEN AVG(FP.NON_RESIDENT_RATIO)
    ELSE NULL
  END DESC
LIMIT
  5;