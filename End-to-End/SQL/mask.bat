
set databaseType=SqlServer
set connectionString="Server=127.0.0.1,1988;Database=NewWorldDB_Subset;Trust Server Certificate=yes;User ID=Redgate;Password=Redg@te1"


echo Classifying...
Anonymize.exe classify --database-engine %databaseType% --connection-string %connectionString% --classification-file classification.json --output-all-columns
echo.

pause


echo Mapping...
Anonymize.exe map --classification-file classification.json --masking-file masking.json
echo.

pause


echo Masking...
Anonymize.exe mask --database-engine %databaseType% --connection-string %connectionString% --masking-file masking.json



