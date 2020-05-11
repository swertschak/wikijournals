#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Install Translation Extensions ->> $PROJECTDIR/install/linux/wikijournals.log


cd $HTMLDIR/$WIKIDIR/extensions


if [ $? -ne 0 ]
then
  echo $(date) Changing to extensions directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning Babel repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning CLDR repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning CleanChanges repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning Translate repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning Universal Language Selector repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Changing to wikijournals directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cat $PROJECTDIR/config/configTranslation.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Append Translation config to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo $(date) Change to maintenance directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

php update.php
if [ $? -ne 0 ]
then
  echo $(date) Update mediawiki failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Change to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Translation extensions installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log