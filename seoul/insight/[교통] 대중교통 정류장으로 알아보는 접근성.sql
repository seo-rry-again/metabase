WITH
  RANKEDTRANSPORT AS (
    SELECT
      TRANSPORT_TYPE,
      STATION_COUNT_BASIS_MONTH,
      STATION_COUNT,
      AREA_ID,
      ROW_NUMBER() OVER (
        PARTITION BY
          AREA_ID,
          TRANSPORT_TYPE
        ORDER BY
          STATION_COUNT_BASIS_MONTH DESC
      ) AS RN
    FROM
      FACT.FACT_TRANSPORT
  )
SELECT
  DA.AREA_NAME AS "장소명",
  SUM(RT.STATION_COUNT) AS "대중교통 정류장 개수"
FROM
  RANKEDTRANSPORT RT
  JOIN DIM.DIM_AREA DA ON DA.AREA_CODE = RT.AREA_ID
WHERE
  RN = 1
GROUP BY
  DA.AREA_NAME
ORDER BY
  SUM(RT.STATION_COUNT) DESC;