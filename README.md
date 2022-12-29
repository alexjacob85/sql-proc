# sql-proc
proc to exclude columns from select statement in sql

for example i want to remove from my employee table the selection of ID and FirstName
EXEC [usp_select_without] 
@table_name = N'Employee',
@list_of_columns_excluded = N'ID,FirstName';
