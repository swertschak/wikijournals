echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Install Semantic Mediawiki - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%\%WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to wikijournals directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call composer require mediawiki/semantic-media-wiki "3.1.0"
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Install Semantic Mediawiki using composer failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

type LocalSettings.php %PROJECTDIR%\config\configSMW.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Appending SMW Config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
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

echo Zwschenupdate
cd maintenance
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to maintenance directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php update.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Update Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows

echo %date%-%time% Semantic Mediawiki installed successful >> %PROJECTDIR%\install\windows\wikijournals.log