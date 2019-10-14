#!/usr/bin/env bash

echo off

echo Install Translation Extensions

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/extensions
if [ $? -ne 0 ]
then
  echo "Changing to extensions directory failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
if [ $? -ne 0 ]
then
  echo "Cloning Babel repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
if [ $? -ne 0 ]
then
  echo "Cloning CLDR repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
if [ $? -ne 0 ]
then
  echo "Cloning CleanChanges repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
if [ $? -ne 0 ]
then
  echo "Cloning Translate repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git
if [ $? -ne 0 ]
then
  echo "Cloning Universal Language Selector repository failed"
  exit 1
fi

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Changing to wikijournals directory failed"
  exit 1
fi

cat $PROJECTDIR/config/configTranslation.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Append Translation config to LocalSettings.php failed"
  exit 1
fi

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo "Change to maintenance directory failed"
  exit 1
fi

php update.php
if [ $? -ne 0 ]
then
  echo "Update mediawiki failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Change to project directory failed"
  exit 1
fi

echo "Translation extensions installed succesful"