#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Update Semantic Mediawiki Extensions - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  $(date) echo Changing to wikijournals directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi


cd extensions
if [ $? -ne 0 ]
then
  $(date) echo Changing to extensions directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd SemanticDrilldown
git pull
if [ $? -ne 0 ]
then
  $(date) echo Updating Semantic Drilldown repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd PageForms
git pull
if [ $? -ne 0 ]
then
  $(date) echo Updating Pageforms repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd SemanticInternalObjects
git pull
if [ $? -ne 0 ]
then
  $(date) echo Updating Semantic Internal Objects repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..


cd ..
composer require mediawiki/maps $MAPSVERSION
if [ $? -ne 0 ]
then
  $(date) echo Install Maps using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

composer require mediawiki/semantic-result-formats $SMWRESULTFORMATVERSION
if [ $? -ne 0 ]
then
  $(date) echo Install Semantic Result Formats using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

composer require mediawiki/semantic-compound-queries $SMWCOMPOUNDQUERIESVERSION
if [ $? -ne 0 ]
then
  $(date) echo Install Semantic Compund Queries using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd maintenance
if [ $? -ne 0 ]
then
  echo $(date) Changing to maintenance directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

php update.php
if [ $? -ne 0 ]
then
  echo $(date) Update Mediawiki failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Changing to Project Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Semantic Mediawiki Extensions updated succesful - >> $PROJECTDIR/install/linux/wikijournals.log