echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo Install Semantic Mediawiki

cd %HTMLDIR%\%WIKIDIR%
call composer require mediawiki/semantic-media-wiki "3.1.0"

type LocalSettings.php %PROJECTDIR%\config\configSMW.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

echo Zwschenupdate
cd maintenance
call php update.php

cd %PROJECTDIR%\install\windows