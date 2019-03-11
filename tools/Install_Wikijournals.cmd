echo off

echo Check command line parameter
echo html directory: %1
set htmldir=%1
echo wikijournals directory: %2
set wikidir=%2
echo dbuser: %3
set dbuser=%3
echo dbpass: %4
set dbpass=%4
echo dbserver: %5
set dbserver=%5
echo dbname: %6
set dbname=%6
echo wikiuser: %7
set wikiuser=%7
echo wikipwd: %8
set wikipwd=%8
echo wikiname: %9
set wikiname=%9

set PROJECTDIR="%cd%"

echo Download Mediawiki
set MEDIAWIKIVERSION=1.31.1
set MEDIAWIKIURL=https://releases.wikimedia.org/mediawiki/1.31/mediawiki-%MEDIAWIKIVERSION%.tar.gz
set MEDIAWIKIDIR=mediawiki-%MEDIAWIKIVERSION%
cd %1
curl %MEDIAWIKIURL% --output wikijournals.tar.gz

echo Uncompress Mediawiki into wikijournals directory
tar -xvzf wikijournals.tar.gz
ren %MEDIAWIKIDIR% %2

echo Install Mediawiki
cd %1/%2/maintenance
call php install.php --dbuser=%dbuser% --dbpass=%dbpass% --dbserver=%dbserver% --dbname=%dbname% --dbtype=mysql --installdbpass=%dbpass% --installdbuser=%dbuser% --lang=da --pass=%wikipwd% --scriptpath=/%wikidir%  %wikiname% %wikiuser%
call "%PROJECTDIR%/tools/fnr.exe" --cl --dir "%1\%2" --fileMask "LocalSettings.php" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "$wgLanguageCode = ""en"";" --replace "$wgLanguageCode = ""de"";"
cd ..

echo Install foreground
cd skins
git clone https://github.com/thingles/foreground.git
cd ..

cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms

cd ..

echo Install Semantic Mediawiki
call composer require mediawiki/semantic-media-wiki "3.0.1"

echo Zwschenupdate
cd maintenance
call php update.php
cd ..

cd extensions

echo Install SMW Extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
cd ..

echo Install Maps
call composer require mediawiki/maps "7.1.0"

echo Install Semantic Result Formats
call composer require mediawiki/semantic-result-formats "3.0.0"

echo Install Semantic Compound Queries
call composer require mediawiki/semantic-compound-queries "2.0.0"

cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git
ren extension-headertabs HeaderTabs
git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git
ren extension-myvariables MyVariables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git
ren extension-variables Variables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git

cd Widgets
git submodule init
git submodule update

echo Update LocalSetting.php
cd ..\..
type LocalSettings.php %PROJECTDIR%\configExtensions.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php
call "%PROJECTDIR%/tools/fnr.exe" --cl --dir "%1\%2" --fileMask "LocalSettings.php" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "$wgDefaultSkin = ""vector"";" --replace "$wgDefaultSkin = ""foreground"";"
cd maintenance
call php update.php

echo Install Wikijournals Structure
call php importDump.php < %PROJECTDIR%/wikijournals_structure/wikijournalsStructure.xml

cd %PROJECTDIR%
