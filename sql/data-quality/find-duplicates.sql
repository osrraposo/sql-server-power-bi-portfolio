/* Diagnóstico de chaves duplicadas antes de uma carga. */
SELECT
    BusinessKey,
    COUNT_BIG(*) AS DuplicateCount,
    MIN(CreatedAt) AS FirstOccurrence,
    MAX(CreatedAt) AS LastOccurrence
FROM dbo.StageTable
GROUP BY BusinessKey
HAVING COUNT_BIG(*) > 1
ORDER BY DuplicateCount DESC;
