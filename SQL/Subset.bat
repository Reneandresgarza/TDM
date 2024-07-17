set databaseType=SqlServer
set connectionStringSource="Server=127.0.0.1,1988;Database=NewWorldDB;Trust Server Certificate=yes;User ID=Redgate;Password=Redg@te1"
set connectionStringTarget="Server=127.0.0.1,1988;Database=NewWorldDB_Subset;Trust Server Certificate=yes;User ID=Redgate;Password=Redg@te1"


subsetter.exe  --database-engine sqlserver  --source-connection-string %connectionStringSource% --target-connection-string %connectionStringTarget% --target-database-write-mode Overwrite  --starting-table "[dbo].[Orders]" --filter-clause "[OrderID] = 10348"


