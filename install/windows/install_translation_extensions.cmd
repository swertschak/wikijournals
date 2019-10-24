echo off

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo - Install Translation Extensions - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%/%WIKIDIR%/extensions
if %ERRORLEVEL% NEQ 0 (
echo Changing to extensions directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning Babel repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning CLDR repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning Clean Changes repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning Translate repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning Universal Language Selector repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %HTMLDIR%/%WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo Changing to wikijournals directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

type LocalSettings.php %PROJECTDIR%\config\configTranslation.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo Append Translation config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

del LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo Deleting old Settings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

ren LocalSettings.bak LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo Rename new LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %HTMLDIR%/%WIKIDIR%/maintenance
if %ERRORLEVEL% NEQ 0 (
echo Change to maintenance directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call php update.php
if %ERRORLEVEL% NEQ 0 (
echo Update Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo Changing to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Translation extensions installed successful >> %PROJECTDIR%\install\windows\wikijournals.log