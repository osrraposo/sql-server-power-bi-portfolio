DROP TABLE IF EXISTS #Work;

SELECT
    S.RecordId,
    S.EventDate,
    S.StatusCode
INTO #Work
FROM dbo.SourceTable AS S
WHERE S.EventDate >= @StartDate
  AND S.EventDate <  @EndDate;

/* Índice alinhado ao join pela chave. */
CREATE UNIQUE CLUSTERED INDEX IX_Work_RecordId
    ON #Work (RecordId);

/* Crie índices adicionais apenas quando o plano e o volume justificarem. */
CREATE NONCLUSTERED INDEX IX_Work_EventDate_StatusCode
    ON #Work (EventDate, StatusCode)
    INCLUDE (RecordId);
