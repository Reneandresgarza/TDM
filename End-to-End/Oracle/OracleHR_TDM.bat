::Create Data Container::                                              

rgclone create data-container --image 290 --name "OracleHR1" --lifetime 3h10m

start "" "{file:directory}\Create Proxy HR1.bat"

pause

::Subsetting the container
set databaseType=oracle
set connectionStringSource="Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=1999))(CONNECT_DATA=(SERVICE_NAME=ORCLCDB)));User Id=HR;Password=Redg@te1"
set connectionStringTarget="Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=localhost)(PORT=2000))(CONNECT_DATA=(SERVICE_NAME=ORCLCDB)));User Id=HR;Password=Redg@te1"


subsetter.exe  --database-engine Oracle  --source-connection-string %connectionStringSource% --target-connection-string %connectionStringTarget% --target-database-write-mode Overwrite  --starting-table "HR.EMPLOYEES" --filter-clause "EMPLOYEE_ID < 125"


pause


echo Classifying...
Anonymize.exe classify --database-engine %databaseType% --connection-string %connectionStringTarget% --classification-file classification.json --output-all-columns
echo.

pause


echo Mapping...
Anonymize.exe map --classification-file classification.json --masking-file masking.json
echo.

pause


echo Masking...
Anonymize.exe mask --database-engine %databaseType% --connection-string %connectionStringTarget% --masking-file masking.json

