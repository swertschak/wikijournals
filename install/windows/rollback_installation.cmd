echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo Delete Directory %HTMLDIR%\%WIKIDIR%

rmdir %HTMLDIR%\%WIKIDIR% /S /Q

mysql -u %DBUSER% -p%DBPASS% %DBNAME% -e "show tables" > tables.txt

for /f %%i in (tables.txt) do (
echo delete %%i
mysql -u %DBUSER% -p%DBPASS% %DBNAME% -e "drop table %%i"
)

del tables.txt
