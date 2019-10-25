echo off
for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Import Metadata - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%/%WIKIDIR%/maintenance
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to maintenance Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Import Metadata Publisher >> %PROJECTDIR%\install\windows\wikijournals.log

call php importDump.php < %PROJECTDIR%\data\publisher.xml
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Import Publisher Metadata failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Import Metadata Publications >> %PROJECTDIR%\install\windows\wikijournals.log

call php importDump.php < %PROJECTDIR%\data\publications.xml
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Import Publications Metadata failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php rebuildall.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Rebuildall failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% Metadata imported successful >> %PROJECTDIR%\install\windows\wikijournals.log