#!/usr/bin/env bash

echo Check command line parameter

. $(pwd)/wikijournals.conf

echo html directory: $HTMLDIR
echo wikijournals directory: $WIKIDIR
echo dbuser: $DBUSER
echo dbpass: $DBPASS
echo dbserver: $DBSERVER
echo dbname: $DBNAME
echo wikiuser: $WIKIUSER
echo wikipwd: $WIKIPWD
echo wikiname: $WIKINAME
echo Mediawiki Main Version: $MEDIAWIKIVERSION
echo Mediawiki Minor Version: $MEDIAWIKIMINORVERSION

echo Download Mediawiki

cd $HTMLDIR

wget https://releases.wikimedia.org/mediawiki/$MEDIAWIKIVERSION/mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz

echo Uncompress Mediawiki into wikijournals directory

tar -xvzf mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz

mv mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION $WIKIDIR

rm mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz

echo Set rights for www-data

chown -cR www-data:www-data $WIKIDIR

echo Install Wikijournals

cd $HTMLDIR/$WIKIDIR/maintenance

php install.php --dbuser=$DBUSER --dbpass=$DBPASS --dbserver=$DBSERVER --dbname=$DBNAME --dbtype=mysql --installdbpass=$DBPASS --installdbuser=$DBUSER --lang=de --pass=$WIKIPWD --scriptpath=/$WIKIDIR  $WIKINAME $WIKIUSER

cd $HTMLDIR/$WIKIDIR

cat $PROJECTDIR/config/configMediawiki.txt >> LocalSettings.php

cd $PROJECTDIR/install/linux


