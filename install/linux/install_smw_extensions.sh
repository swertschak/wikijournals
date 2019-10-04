#!/usr/bin/env bash

. $(pwd)/wikijournals.conf

echo Install Semantic Mediawiki Extensions

cd $HTMLDIR/$WIKIDIR

cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git

cd ..

composer require mediawiki/maps "7.7.0"
composer require mediawiki/semantic-result-formats "3.1.0"
composer require mediawiki/semantic-compound-queries "2.1.0"

cat $PROJECTDIR/config/configSMWExtensions.txt >> LocalSettings.php


cd maintenance
php update.php

cd $PROJECTDIR/install/linux