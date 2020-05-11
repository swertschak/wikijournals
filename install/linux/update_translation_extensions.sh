#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Update Translation Extensions ->> $PROJECTDIR/install/linux/wikijournals.log


cd $HTMLDIR/$WIKIDIR/extensions


if [ $? -ne 0 ]
then
  echo $(date) Changing to extensions directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd Babel
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating Babel repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd cldr
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating CLDR repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd CleanChanges
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating CleanChanges repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd Translate
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating Translate repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd UniversalLanguageSelector
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating Universal Language Selector repository failed >> $PROJECTDIR/install/linux/wikijournals.log
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

echo $(date) - Translation extensions updated succesful - >> $PROJECTDIR/install/linux/wikijournals.log