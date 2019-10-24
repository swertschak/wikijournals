#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo Install Wikijournals Structure

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Change to wikijournals directopry failed"
  exit 1
fi

cat $PROJECTDIR/config/configWikijournalsStructure.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Append Wikijournals configuration to LocalSettings.php failed"
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

php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml
if [ $? -ne 0 ]
then
  echo "Import wikijournals structure failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Change to project directory failed"
  exit 1
fi

echo "Wikijournals structure installed succesful"