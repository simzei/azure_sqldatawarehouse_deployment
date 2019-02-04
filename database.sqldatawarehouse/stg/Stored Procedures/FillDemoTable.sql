CREATE PROC [stg].[FillDemoTable] @numRows [INT] AS
BEGIN

IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'stg' AND TABLE_NAME = 'DemoTable'))
BEGIN
      DROP TABLE [stg].[DemoTable];
END

CREATE TABLE [stg].[DemoTable]
WITH
(        DISTRIBUTION = ROUND_ROBIN
		,CLUSTERED COLUMNSTORE INDEX
)
AS
SELECT	TOP (@numRows)
		Demo_Id = CONVERT(INT, ROW_NUMBER() OVER (ORDER BY s1.[object_id])),
		Other_Id = ABS(CHECKSUM(NewId())) % 100000,
		Description = CONVERT(varchar(255), NEWID()),
		SYSTEM_LoadedToDW = GETDATE() 
--INTO dbo.Numbers
FROM sys.all_objects AS s1 CROSS JOIN sys.all_objects AS s2 CROSS JOIN sys.all_objects AS s3
OPTION (MAXDOP 1);
END