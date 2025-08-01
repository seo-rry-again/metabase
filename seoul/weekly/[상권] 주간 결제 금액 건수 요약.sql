SELECT
  DA.AREA_NAME,
  DATE_TRUNC('WEEK', DT.DATETIME_VALUE) AS "Created At: Week_Start_Date",
  SUM(FC.TOTAL_PAYMENT_COUNT) AS "결제 건수(합계)",
  AVG(FC.PAYMENT_AMOUNT_MAX) / 10000 AS "최대 결제 금액(평균)"
FROM
  FACT.FACT_COMMERCIAL FC
  JOIN DIM.DIM_AREA DA ON FC.AREA_ID = DA.AREA_ID
  JOIN DIM.DIM_TIME DT ON DT.TIME_KEY = FC.TIME_KEY
WHERE
  1 = 1
  AND [[DA.AREA_NAME = {{AREA_NAME}}]]
GROUP BY
  DA.AREA_NAME,
  "Created At: Week_Start_Date"
ORDER BY
  DA.AREA_NAME,
  "Created At: Week_Start_Date";