echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Install Semantic Mediawiki Extensions - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%\%WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to wikijournals directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd extensions
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to extensions directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning Semantic Drilldown repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning PageForms repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning Semantic Internal Objects repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd ..

call composer require mediawiki/maps %MAPSVERSION%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Install Maps using composer failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call composer require mediawiki/semantic-result-formats %SMWRESULTFORMATVERSION%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Install Semantic Result Formats using composer failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call composer require mediawiki/semantic-compound-queries %SMWCOMPOUNDQUERIESVERSION%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Install Semantic Compound Queries using composer failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

type LocalSettings.php %PROJECTDIR%\config\configSMWExtensions.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Appending SMW Extensions Config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
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

cd maintenance
if %ERRORLEVEL% NEQ 0 (
echo Changing to maintenance directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php update.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Update Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Semantic Mediawiki Extensions installed successful >> %PROJECTDIR%\install\windows\wikijournals.log