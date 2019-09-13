echo off

echo Set install parameter
set HTMLDIR=
set WIKIDIR=
set DBUSER=
set DBPASS=
set DBSERVER=
set DBNAME=
set WIKIUSER=
set WIKIPWD=
set WIKINAME=

echo Download Mediawiki
set MEDIAWIKIVERSION=1.33
set MEDIAWIKIMINORVERSION=0
set MEDIAWIKIURL=https://releases.wikimedia.org/mediawiki/%MEDIAWIKIVERSION%/mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%.tar.gz
set MEDIAWIKIDIR=mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%
cd %htmldir%

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
