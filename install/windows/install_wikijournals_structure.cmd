echo off

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Install Wikijournals Structure - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%/%WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to wikijournals directopry failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

type LocalSettings.php %PROJECTDIR%\config\configWikijournalsStructure.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Append Wikijournals configuration to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
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

cd %HTMLDIR%/%WIKIDIR%/maintenance
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to maintenance directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php update.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Update Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php importDump.php < %PROJECTDIR%\wikijournals_structure\wikijournalsStructure.xml
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Import wikijournals structure failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Wikijournals structure installed successful >> %PROJECTDIR%\install\windows\wikijournals.log