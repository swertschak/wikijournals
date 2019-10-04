#!/usr/bin/env bash

. $(pwd)/wikijournals.conf

echo Install foreground
cd $HTMLDIR/$WIKIDIR/skins
git clone https://github.com/thingles/foreground.git
cd ..
sed -i 's/$wgDefaultSkin = \"vector/$wgDefaultSkin = \"foreground/' LocalSettings.php


cat $PROJECTDIR/config/configForeground.txt >> LocalSettings.php

cd $PROJECTDIR/install/linux


