#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Install Semantic Mediawiki Extensions - >> $PROJECTDIR/install/linux/wikijournals.log

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

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
if [ $? -ne 0 ]
then
  $(date) echo Cloning Semantic Drilldown repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
if [ $? -ne 0 ]
then
  $(date) echo Cloning Pageforms repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
if [ $? -ne 0 ]
then
  $(date) echo Cloning Semantic Internal Objects repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd ..

composer require mediawiki/maps "7.7.0"
if [ $? -ne 0 ]
then
  $(date) echo Install Maps using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

composer require mediawiki/semantic-result-formats "3.1.0"
if [ $? -ne 0 ]
then
  $(date) echo Install Semantic Result Formats using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

composer require mediawiki/semantic-compound-queries "2.1.0"
if [ $? -ne 0 ]
then
  $(date) echo Install Semantic Compund Queries using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cat $PROJECTDIR/config/configSMWExtensions.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Appending SMW Extensions Config to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
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

echo $(date) - Semantic Mediawiki Extensions installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log