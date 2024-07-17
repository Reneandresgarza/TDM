set databaseType=mysql
set connectionStringSource="Server=clone-internal.red-gate.com;Port=32888;User ID=root;Password=f9Pr7fehwjdO0GTa;Database=sakila"
set connectionStringTarget="Server=clone-internal.red-gate.com;Port=32833;User ID=root;Password=TlUJceusghL8DUwt;Database=sakila"

subsetter.exe  --database-engine %databaseType%  --source-connection-string %connectionStringSource% --target-connection-string %connectionStringTarget% --target-database-write-mode Overwrite  --starting-table "rental" --filter-clause "`rental_id` = 1"

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

