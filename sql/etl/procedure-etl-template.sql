/*
    Exemplo genérico de ETL no SQL Server.
    Adapte schemas, colunas e regras sem inserir informações sensíveis.
*/
CREATE OR ALTER PROCEDURE dbo.usp_LoadExample
    @StartDate date,
    @EndDate   date
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    DECLARE
        @ProcessName  sysname       = OBJECT_NAME(@@PROCID),
        @Step         varchar(100)  = 'INITIALIZATION',
        @StartedAt    datetime2(3)  = SYSDATETIME(),
        @RowsAffected int           = 0;

    BEGIN TRY
        IF @StartDate IS NULL OR @EndDate IS NULL OR @StartDate >= @EndDate
            THROW 50001, 'Invalid processing period.', 1;

        SET @Step = 'STAGING';

        DROP TABLE IF EXISTS #Stage;

        SELECT
            S.RecordId,
            S.EventDate,
            NULLIF(LTRIM(RTRIM(S.Description)), '') AS Description
        INTO #Stage
        FROM dbo.SourceTable AS S
        WHERE S.EventDate >= @StartDate
          AND S.EventDate <  @EndDate;

        SET @RowsAffected = @@ROWCOUNT;

        IF @RowsAffected = 0
            THROW 50002, 'No records found for the requested period.', 1;

        CREATE UNIQUE CLUSTERED INDEX IX_Stage_RecordId
            ON #Stage (RecordId);

        SET @Step = 'LOAD';

        BEGIN TRANSACTION;

        DELETE T
        FROM dbo.TargetTable AS T
        WHERE T.EventDate >= @StartDate
          AND T.EventDate <  @EndDate;

        INSERT INTO dbo.TargetTable
        (
            RecordId,
            EventDate,
            Description
        )
        SELECT
            S.RecordId,
            S.EventDate,
            S.Description
        FROM #Stage AS S;

        SET @RowsAffected = @@ROWCOUNT;

        COMMIT TRANSACTION;

        INSERT INTO dbo.ProcessLog
        (
            ProcessName, ExecutionDate, Status, Message, RowsAffected,
            StartDate, EndDate, DurationMs, Step, ErrorNumber
        )
        VALUES
        (
            @ProcessName, SYSDATETIME(), 'SUCCESS', 'Load completed.', @RowsAffected,
            @StartDate, @EndDate, DATEDIFF_BIG(MILLISECOND, @StartedAt, SYSDATETIME()),
            @Step, NULL
        );
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        INSERT INTO dbo.ProcessLog
        (
            ProcessName, ExecutionDate, Status, Message, RowsAffected,
            StartDate, EndDate, DurationMs, Step, ErrorNumber
        )
        VALUES
        (
            @ProcessName, SYSDATETIME(), 'ERROR', ERROR_MESSAGE(), @RowsAffected,
            @StartDate, @EndDate, DATEDIFF_BIG(MILLISECOND, @StartedAt, SYSDATETIME()),
            @Step, ERROR_NUMBER()
        );

        THROW;
    END CATCH;
END;
