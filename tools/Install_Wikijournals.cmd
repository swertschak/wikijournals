echo off
echo Install Mediawiki

cd maintenance
php install.php --dbuser=<db_user> --dbpass=<db_pwd> --dbserver=<db_server> --dbname=<db_name> --dbtype=mysql --installdbpass=<db_pwd> --installdbuser=<db_user> --lang=de --pass=<wiki_pwd> --scriptpath=/<wiki_dir>  <wiki_name> <wiki_user>
cd ..

echo Install foreground
cd skins
git clone https://github.com/thingles/foreground.git
cd ..


echo Install Semantic Mediawiki
call composer require mediawiki/semantic-media-wiki "3.0.1"
cd maintenance
php update.php

echo Install SMW Extensions
cd ..\extensions

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
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

cd ..
copy /b LocalSettings.php+configExtensions.txt LocalSettings.php
cd maintenance
php update.php

echo Install Wikijournals Structure
php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml