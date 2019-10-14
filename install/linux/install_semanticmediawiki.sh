#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo Install Semantic Mediawiki

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Changing to wikijournals directory failed"
  exit 1
fi

composer require mediawiki/semantic-media-wiki "3.1.0"
if [ $? -ne 0 ]
then
  echo "Install Semantic Mediawiki using composer failed"
  exit 1
fi

cat $PROJECTDIR/config/configSMW.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Appending SMW Config to LocalSettings.php failed"
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
  echo "Changing to project directory failed"
  exit 1
fi

echo "Semantic Mediawiki installed succesful"