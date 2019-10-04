echo off
echo Install Wikijournals Structure

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/maintenance

echo Import Metadata Publisher

php importDump.php < $PROJECTDIR/data/publisher.xml

echo Import Metadata Publications

php importDump.php < $PROJECTDIR/data/publications.xml

php rebuildall.php

cd $PROJECTDIR/install/linux