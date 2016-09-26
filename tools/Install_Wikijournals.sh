#!/usr/bin/env bash

echo Check command line parameter

echo html directory: $1
echo wikijournals directory: $2
echo dbuser: $3
echo dbpass: $4
echo dbserver: $5
echo dbname: $6
echo wikiuser: $7
echo wikipwd: $8
echo wikiname: $9

PROJECTDIR=$(pwd)

echo Download Mediawiki

cd $1

#wget https://releases.wikimedia.org/mediawiki/1.26/mediawiki-1.26.2.tar.gz
wget https://releases.wikimedia.org/mediawiki/1.27/mediawiki-1.27.1.tar.gz

echo Uncompress Mediawiki into wikijournals directory

tar -xvzf mediawiki-1.27.1.tar.gz

mv mediawiki-1.27.1 $2

echo Set rights for www-data

chown -cR www-data:www-data $2

echo Install Wikijournals

cd $1/$2/maintenance

php install.php --dbuser=$3 --dbpass=$4 --dbserver=$5 --dbname=$6 --dbtype=mysql --installdbpass=$4 --installdbuser=$3 --lang=de --pass=$8 --scriptpath=/$2  $9 $7
cd ..

echo Install foreground
cd skins
git clone https://github.com/thingles/foreground.git
cd ..
sed -i 's/$wgDefaultSkin = \"vector/$wgDefaultSkin = \"foreground/' LocalSettings.php

echo Install Semantic Mediawiki
composer require mediawiki/semantic-media-wiki "*.*"
cd maintenance
php update.php
cd ..

echo Install SMW Extensions
cd extensions
git clone https://github.com/SemanticMediaWiki/SemanticCompoundQueries.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://phabricator.wikimedia.org/diffusion/ESFO/extension-semanticforms.git
mv extension-semanticforms SemanticForms

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticFormsInputs.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
cd ..

composer require mediawiki/maps "*"
composer require mediawiki/semantic-maps "*"
composer require mediawiki/semantic-result-formats "*"

cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git
mv extension-headertabs HeaderTabs
git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git
mv extension-myvariables MyVariables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ReplaceText.git
git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git
mv extension-variables Variables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git

cd Widgets
git submodule init
git submodule update


echo Update LocalSetting.php
cd $1/$2

cat $PROJECTDIR/configExtensions.txt >> LocalSettings.php
sed -i 's/$wgLanguageCode = \"en/$wgLanguageCode = \"de/' LocalSettings.php
cd maintenance
php update.php

echo Install Wikijournals Structure

php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml

