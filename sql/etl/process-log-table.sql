CREATE TABLE dbo.ProcessLog
(
    ProcessLogId bigint IDENTITY(1,1) NOT NULL
        CONSTRAINT PK_ProcessLog PRIMARY KEY,
    ProcessName  sysname          NOT NULL,
    ExecutionDate datetime2(3)    NOT NULL,
    Status       varchar(20)      NOT NULL,
    Message      nvarchar(4000)   NULL,
    RowsAffected int              NULL,
    StartDate    date             NULL,
    EndDate      date             NULL,
    DurationMs   bigint           NULL,
    Step         varchar(100)     NULL,
    ErrorNumber  int              NULL
);

CREATE INDEX IX_ProcessLog_ProcessName_ExecutionDate
    ON dbo.ProcessLog (ProcessName, ExecutionDate DESC)
    INCLUDE (Status, RowsAffected, DurationMs, Step, ErrorNumber);
