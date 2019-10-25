echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Install Mediawiki - >> %PROJECTDIR%\install\windows\wikijournals.log

echo %date%-%time% Download Mediawiki >> %PROJECTDIR%\install\windows\wikijournals.log

set MEDIAWIKIURL=https://releases.wikimedia.org/mediawiki/%MEDIAWIKIVERSION%/mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%.tar.gz
set MEDIAWIKIDIR=mediawiki-%MEDIAWIKIVERSION%.%MEDIAWIKIMINORVERSION%

cd %HTMLDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Could not change to HTMLDIR >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

curl %MEDIAWIKIURL% --output wikijournals.tar.gz
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Download Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Uncompress Mediawiki into wikijournals directory >> %PROJECTDIR%\install\windows\wikijournals.log

tar -xvzf wikijournals.tar.gz
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Uncompress Mediawiki Download failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

ren %MEDIAWIKIDIR% %WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Rename mediawiki directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

del wikijournals.tar.gz
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Remove mediawiki download failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


echo %date%-%time% Install Mediawiki per Script >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%\%WIKIDIR%\maintenance
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to maintenance Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


call php install.php --dbuser=%DBUSER% --dbpass=%DBPASS% --dbserver=%DBSERVER% --dbname=%DBNAME% --dbtype=mysql --installdbpass=%DBPASS% --installdbuser=%DBUSER% --lang=de --pass=%WIKIPWD% --scriptpath=/%WIKIDIR% %WIKINAME% %WIKIUSER%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% PHP Mediawiki installation script failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd ..

type LocalSettings.php %PROJECTDIR%\config\configMediawiki.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Append Mediawiki Config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

del LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Deleting old Settings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

ren LocalSettings.bak LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Rename new LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Mediawiki installed successful >> %PROJECTDIR%\install\windows\wikijournals.log