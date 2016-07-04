#!/usr/bin/env bash

echo Check command line parameter

echo html directory: $1
echo wikijournals directory: $2

PROJECTDIR=$(pwd)

echo Download Mediawiki

cd $1

wget https://releases.wikimedia.org/mediawiki/1.26/mediawiki-1.26.2.tar.gz

echo Uncompress Mediawiki into wikijournals directory

tar -xvzf mediawiki-1.26.2.tar.gz

mv mediawiki-1.26.2 $2

echo Update Wikijournals

cd $1/$2/maintenance

php update.php

cd ..

echo Update foreground
cd skins/foreground
git pull
cd ../..


echo Update Semantic Mediawiki
composer update
cd maintenance
php update.php
cd ..

echo Update SMW Extensions
cd extensions

cd SemanticCompoundQueries
git pull
cd ..

cd SemanticDrilldown
git pull
cd ..

cd SemanticForms
git pull
cd ..

cd SemanticFormsInputs
git pull
cd ..

cd SemanticInternalObjects
git pull
cd ..


echo Update Non-Semantic Extensions

cd AdminLinks
git pull
cd ..

cd DataTransfer
git pull
cd ..

cd ExternalData
git pull
cd ..

cd HeaderTabs
git pull
cd ..

cd MyVariables
git pull
cd ..

cd PageSchemas
git pull
cd ..

cd ReplaceText
git pull
cd ..

cd Variables
git pull
cd ..

cd Widgets
git pull
git submodule update
cd ..

cd ..
cd maintenance
php update.php





