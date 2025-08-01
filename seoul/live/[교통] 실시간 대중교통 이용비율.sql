SELECT
  CASE
    WHEN TRANSPORT_TYPE = 'BUS' THEN '버스'
    WHEN TRANSPORT_TYPE = 'SUBWAY' THEN '지하철'
    ELSE TRANSPORT_TYPE
  END AS TRANSPORT_TYPE_KO,
  SUM(
    GETOFF_5MIN_POPULATION_MAX + GETON_5MIN_POPULATION_MAX
  ) AS TOTAL_POPULATION
FROM
  FACT.FACT_TRANSPORT
WHERE
  TIME_KEY = (
    SELECT
      MAX(TIME_KEY)
    FROM
      FACT.FACT_TRANSPORT
  )
GROUP BY
  TRANSPORT_TYPE
ORDER BY
  TRANSPORT_TYPE;