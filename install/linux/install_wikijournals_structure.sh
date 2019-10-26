#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Install Wikijournals Structure - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Change to wikijournals directopry failed>> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cat $PROJECTDIR/config/configWikijournalsStructure.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Append Wikijournals configuration to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
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

php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml
if [ $? -ne 0 ]
then
  echo $(date) Import wikijournals structure failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Change to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Wikijournals structure installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log