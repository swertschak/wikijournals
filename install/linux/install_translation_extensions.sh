#!/usr/bin/env bash

echo Install Translation Extensions

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/extensions

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git

cd $HTMLDIR/$WIKIDIR

cat $PROJECTDIR/config/configTranslation.txt >> LocalSettings.php

cd $HTMLDIR/$WIKIDIR/maintenance

php update.php

cd $PROJECTDIR/install/linux