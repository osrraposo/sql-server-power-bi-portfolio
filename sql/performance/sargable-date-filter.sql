/*
    Prefira intervalos fechados/abertos. Eles evitam aplicar funções
    sobre a coluna e permitem melhor aproveitamento de índices.
*/
DECLARE @StartDate date = DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1);
DECLARE @EndDate   date = DATEADD(MONTH, 1, @StartDate);

SELECT
    T.RecordId,
    T.EventDate,
    T.Amount
FROM dbo.FactTable AS T
WHERE T.EventDate >= @StartDate
  AND T.EventDate <  @EndDate;
