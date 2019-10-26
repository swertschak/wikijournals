#!/usr/bin/env bash
echo off


. $(pwd)/wikijournals.conf

echo $(date) - Import Metadata - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo $(date) Change to maintenance directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Import Metadata Publisher >> $PROJECTDIR/install/linux/wikijournals.log

php importDump.php < $PROJECTDIR/data/publisher.xml
if [ $? -ne 0 ]
then
  echo $(date) Import Publisher Metadata failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Import Metadata Publications >> $PROJECTDIR/install/linux/wikijournals.log

php importDump.php < $PROJECTDIR/data/publications.xml
if [ $? -ne 0 ]
then
  echo $(date) Import Publications Metadata failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

php rebuildall.php
if [ $? -ne 0 ]
then
  echo $(date) Rebuildall failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Change to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Metadata imported succesful - >> $PROJECTDIR/install/linux/wikijournals.log