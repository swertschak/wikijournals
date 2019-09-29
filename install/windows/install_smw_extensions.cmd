echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo Install Semantic Mediawiki Extensions
cd %HTMLDIR%\%WIKIDIR%

cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git

cd ..

call composer require mediawiki/maps "7.7.0"
call composer require mediawiki/semantic-result-formats "3.1.0"
call composer require mediawiki/semantic-compound-queries "2.1.0"

type LocalSettings.php %PROJECTDIR%\config\configSMWExtensions.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

cd maintenance
call php update.php

cd %PROJECTDIR%\install\windows