echo off
for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo - Install Wikijournals Structure - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%/%WIKIDIR%/maintenance
if %ERRORLEVEL% NEQ 0 (
echo Change to maintenance Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Import Metadata Publisher >> %PROJECTDIR%\install\windows\wikijournals.log

call php importDump.php < %PROJECTDIR%\data\publisher.xml
if %ERRORLEVEL% NEQ 0 (
echo Import Publisher Metadata failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Import Metadata Publications >> %PROJECTDIR%\install\windows\wikijournals.log

call php importDump.php < %PROJECTDIR%\data\publications.xml
if %ERRORLEVEL% NEQ 0 (
echo Import Publications Metadata failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php rebuildall.php
if %ERRORLEVEL% NEQ 0 (
echo Rebuildall failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo Change to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Metadata imported successful >> %PROJECTDIR%\install\windows\wikijournals.log