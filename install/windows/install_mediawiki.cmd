echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo Download Mediawiki
set MEDIAWIKIURL=https://releases.wikimedia.org/mediawiki/%MEDIAWIKIVERSION%/mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%.tar.gz
set MEDIAWIKIDIR=mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%
cd %HTMLDIR%

curl %MEDIAWIKIURL% --output wikijournals.tar.gz

echo Uncompress Mediawiki into wikijournals directory
tar -xvzf wikijournals.tar.gz
ren %MEDIAWIKIDIR% %WIKIDIR%
del wikijournals.tar.gz

echo Install Mediawiki
echo %HTMLDIR%\%WIKIDIR%\maintenance
cd %HTMLDIR%\%WIKIDIR%\maintenance
call php install.php --dbuser=%DBUSER% --dbpass=%DBPASS% --dbserver=%DBSERVER% --dbname=%DBNAME% --dbtype=mysql --installdbpass=%DBPASS% --installdbuser=%DBUSER% --lang=de --pass=%WIKIPWD% --scriptpath=/%WIKIDIR% %WIKINAME% %WIKIUSER%

cd ..

type LocalSettings.php %PROJECTDIR%\config\configMediawiki.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

cd %PROJECTDIR%\install\windows
