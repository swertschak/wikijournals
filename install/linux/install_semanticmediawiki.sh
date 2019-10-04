#!/usr/bin/env bash

. $(pwd)/wikijournals.conf

echo Install Semantic Mediawiki

cd $HTMLDIR/$WIKIDIR

composer require mediawiki/semantic-media-wiki "3.1.0"

cat $PROJECTDIR/config/configSMW.txt >> LocalSettings.php

cd maintenance
php update.php

cd $PROJECTDIR/install/linux