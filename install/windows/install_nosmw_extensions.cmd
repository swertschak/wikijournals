echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% - Install NoSMW Extensions - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%/%WIKIDIR%/extensions
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Could not change to extensions directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning AdminLinks repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning ExternalData repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning ExternalData repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git HeaderTabs
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning HeaderTabs repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git MyVariables
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning MyVariables repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning PageSchemas repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git Variables
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning Variables repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Cloning Widgets repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd Widgets
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to widgets directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git submodule init
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Init widgets failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git submodule update
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Update widgets failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Update LocalSetting.php

cd %HTMLDIR%/%WIKIDIR%
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Changing to wikijournals directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

type LocalSettings.php %PROJECTDIR%\config\configNoSMWExtensions.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Append NoSMW Extensions config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
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
echo %date%-%time% Change to maintenance Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


call php update.php
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Update Mediawiki failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo %date%-%time% Change to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo %date%-%time% NoSMW Extensions installed successful >> %PROJECTDIR%\install\windows\wikijournals.log