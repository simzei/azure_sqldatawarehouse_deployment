CREATE TABLE [stg].[DemoTable] (
    [Demo_Id]           INT           NULL,
    [Other_Id]          INT           NULL,
    [Description]       VARCHAR (255) NULL,
    [SYSTEM_LoadedToDW] DATETIME      NOT NULL
)
WITH (CLUSTERED COLUMNSTORE INDEX, DISTRIBUTION = ROUND_ROBIN);

