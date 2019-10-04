#!/usr/bin/env bash

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/extensions

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git HeaderTabs
git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git MyVariables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git Variables
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git

cd Widgets
git submodule init
git submodule update

echo Update LocalSetting.php

cd $HTMLDIR/$WIKIDIR

cat $PROJECTDIR/config/configNoSMWExtensions.txt >> LocalSettings.php


cd $HTMLDIR/$WIKIDIR/maintenance

php update.php

cd $PROJECTDIR/install/linux