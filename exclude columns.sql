CREATE PROCEDURE [usp_select_without]
@schema_name sysname = N'dbo',
@table_name sysname,
@list_of_columns_excluded nvarchar(max),
@separator nchar(1) = N','
AS
BEGIN
 DECLARE 
 @SQL nvarchar(max),
 @full_table_name nvarchar(max) = CONCAT(@schema_name, N'.', @table_name);

 SELECT @SQL = COALESCE(@SQL + ', ', '') + QUOTENAME([Name])
 FROM sys.columns sc
 LEFT JOIN STRING_SPLIT(@list_of_columns_excluded, @separator) ss ON sc.[name] = ss.[value]
 WHERE sc.OBJECT_ID = OBJECT_ID(@full_table_name, N'u')
 AND ss.[value] IS NULL;

 SELECT @SQL = N'SELECT ' + @SQL + N' FROM ' + @full_table_name;
 EXEC(@SQL)
END