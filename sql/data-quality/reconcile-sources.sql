/* Identifica registros ausentes e divergências entre duas fontes. */
WITH SourceA AS
(
    SELECT RecordId, Amount, StatusCode
    FROM dbo.SourceA
    WHERE ReferenceDate >= @StartDate
      AND ReferenceDate <  @EndDate
),
SourceB AS
(
    SELECT RecordId, Amount, StatusCode
    FROM dbo.SourceB
    WHERE ReferenceDate >= @StartDate
      AND ReferenceDate <  @EndDate
)
SELECT
    COALESCE(A.RecordId, B.RecordId) AS RecordId,
    CASE
        WHEN A.RecordId IS NULL THEN 'MISSING_IN_A'
        WHEN B.RecordId IS NULL THEN 'MISSING_IN_B'
        WHEN ISNULL(A.Amount, 0) <> ISNULL(B.Amount, 0)
          OR ISNULL(A.StatusCode, '') <> ISNULL(B.StatusCode, '')
            THEN 'DIFFERENT_VALUES'
        ELSE 'MATCH'
    END AS ReconciliationStatus,
    A.Amount AS AmountA,
    B.Amount AS AmountB,
    A.StatusCode AS StatusA,
    B.StatusCode AS StatusB
FROM SourceA AS A
FULL OUTER JOIN SourceB AS B
    ON B.RecordId = A.RecordId
WHERE A.RecordId IS NULL
   OR B.RecordId IS NULL
   OR ISNULL(A.Amount, 0) <> ISNULL(B.Amount, 0)
   OR ISNULL(A.StatusCode, '') <> ISNULL(B.StatusCode, '');
