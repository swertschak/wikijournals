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

echo $(date) - Install Mediawiki - >> $PROJECTDIR/install/linux/wikijournals.log

echo $(date) Download Mediawiki >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR

wget https://releases.wikimedia.org/mediawiki/$MEDIAWIKIVERSION/mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo $(date) Download Mediawiki failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Uncompress Mediawiki into wikijournals directory >> $PROJECTDIR/install/linux/wikijournals.log

tar -xvzf mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo $(date) Uncompress Mediawiki Download failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

mv mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION $WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Move Mediawiki direcory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

rm mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo $(date) Remove Mediawiki download failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Set rights for www-data >> $PROJECTDIR/install/linux/wikijournals.log

chown -cR www-data:www-data $WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Setting rights for Mediawiki Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Install Mediawiki >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo $(date) Change to maintenance Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

php install.php --dbuser=$DBUSER --dbpass=$DBPASS --dbserver=$DBSERVER --dbname=$DBNAME --dbtype=mysql --installdbpass=$DBPASS --installdbuser=$DBUSER --lang=de --pass=$WIKIPWD --scriptpath=/$WIKIDIR  $WIKINAME $WIKIUSER
if [ $? -ne 0 ]
then
  echo $(date) PHP Mediawiki installation script failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Change to Wikijournals Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cat $PROJECTDIR/config/configMediawiki.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Append Mediawiki Config to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi


cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Change to Project Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Mediawiki installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log