#!/usr/bin/env bash

. $(pwd)/wikijournals.conf

echo Install Wikijournals Structure

cd $HTMLDIR/$WIKIDIR

cat $PROJECTDIR/config/configWikijournalsStructure.txt >> LocalSettings.php

cd $HTMLDIR/$WIKIDIR/maintenance

php update.php

php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml

cd $PROJECTDIR/install/linux