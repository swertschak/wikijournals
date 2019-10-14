#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo Install Semantic Mediawiki Extensions

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Changing to wikijournals directory failed"
  exit 1
fi


cd extensions
if [ $? -ne 0 ]
then
  echo "Changing to extensions directory failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
if [ $? -ne 0 ]
then
  echo "Cloning Semantic Drilldown repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
if [ $? -ne 0 ]
then
  echo "Cloning Pageforms repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
if [ $? -ne 0 ]
then
  echo "Cloning Semantic Internal Objects repository failed"
  exit 1
fi

cd ..

composer require mediawiki/maps "7.7.0"
if [ $? -ne 0 ]
then
  echo "Install Maps using composer failed"
  exit 1
fi

composer require mediawiki/semantic-result-formats "3.1.0"
if [ $? -ne 0 ]
then
  echo "Install Semantic Result Formats using composer failed"
  exit 1
fi

composer require mediawiki/semantic-compound-queries "2.1.0"
if [ $? -ne 0 ]
then
  echo "Install Semantic Compund Queries using composer failed"
  exit 1
fi

cat $PROJECTDIR/config/configSMWExtensions.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Appending SMW Extensions Config to LocalSettings.php failed"
  exit 1
fi

cd maintenance
if [ $? -ne 0 ]
then
  echo "Changing to maintenance directory failed"
  exit 1
fi

php update.php
if [ $? -ne 0 ]
then
  echo "Update Mediawiki failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Changing to Project Directory failed"
  exit 1
fi

echo "Semantic Mediawiki Extensions installed succesful"