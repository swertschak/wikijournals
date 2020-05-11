#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Update Semantic Mediawiki - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Changing to wikijournals directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

composer require mediawiki/semantic-media-wiki $SMWVERSION
if [ $? -ne 0 ]
then
  echo $(date) Install Semantic Mediawiki using composer failed >> $PROJECTDIR/install/linux/wikijournals.log
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
  echo $(date) Changing to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Semantic Mediawiki updated succesful - >> $PROJECTDIR/install/linux/wikijournals.log