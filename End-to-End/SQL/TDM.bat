::Create Data Container::                                              
rgclone create data-container --image 1077 --name "NewWorldDB" --lifetime 1h30m

pause

::Create Data Proxy::                                              
start "" "C:\Demos\SQL TDM\Create Proxy.bat"

pause

set databaseType=SqlServer
set connectionStringSource="Server=127.0.0.1,1988;Database=NewWorldDB;Trust Server Certificate=yes;User ID=Redgate;Password=Redg@te1"
set connectionStringTarget="Server=127.0.0.1,1988;Database=NewWorldDB_Subset;Trust Server Certificate=yes;User ID=Redgate;Password=Redg@te1"


::Create Data Subset::                                              
subsetter.exe  --database-engine sqlserver  --source-connection-string %connectionStringSource% --target-connection-string %connectionStringTarget% --target-database-write-mode Overwrite  --starting-table "[dbo].[Orders]" --filter-clause "[OrderID] < 10348"

pause


::Classify Database Schema::                                              
echo Classifying...
Anonymize.exe classify --database-engine %databaseType% --connection-string %connectionStringTarget% --classification-file classification.json --output-all-columns
echo.

pause


::Identify Sensitive Data::                                              
echo Mapping...
Anonymize.exe map --classification-file classification.json --masking-file masking.json
echo.

pause


::Obfuscate Sensitive Data::                                              
echo Masking...
Anonymize.exe mask --database-engine %databaseType% --connection-string %connectionStringTarget% --masking-file masking.json



