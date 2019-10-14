#!/usr/bin/env bash

echo off

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
if [ $? -ne 0 ]
then
  echo "Download Mediawiki failed"
  exit 1
fi

echo Uncompress Mediawiki into wikijournals directory

tar -xvzf mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo "Uncompress Mediawiki Download failed"
  exit 1
fi

mv mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION $WIKIDIR
if [ $? -ne 0 ]
then
  echo "Move Mediawiki direcory failed"
  exit 1
fi

rm mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo "Remove Mediawiki download failed"
  exit 1
fi

echo Set rights for www-data

chown -cR www-data:www-data $WIKIDIR
if [ $? -ne 0 ]
then
  echo "Setting rights for Mediawiki Directory failed"
  exit 1
fi

echo Install Wikijournals

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo "Change to maintenance Directory failed"
  exit 1
fi

php install.php --dbuser=$DBUSER --dbpass=$DBPASS --dbserver=$DBSERVER --dbname=$DBNAME --dbtype=mysql --installdbpass=$DBPASS --installdbuser=$DBUSER --lang=de --pass=$WIKIPWD --scriptpath=/$WIKIDIR  $WIKINAME $WIKIUSER
if [ $? -ne 0 ]
then
  echo "PHP Mediawiki installation script failed"
  exit 1
fi

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Change to Wikijournals Directory failed"
  exit 1
fi

cat $PROJECTDIR/config/configMediawiki.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Append Mediawiki Config to LocalSettings.php failed"
  exit 1
fi


cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Change to Project Directory failed"
  exit 1
fi

echo "Mediawiki installed succesful"