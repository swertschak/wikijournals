#!/usr/bin/env bash
echo off
echo Import Metadata

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo "Change to maintenance directory failed"
  exit 1
fi

echo Import Metadata Publisher

php importDump.php < $PROJECTDIR/data/publisher.xml
if [ $? -ne 0 ]
then
  echo "Import Publisher Metadata failed"
  exit 1
fi

echo Import Metadata Publications

php importDump.php < $PROJECTDIR/data/publications.xml
if [ $? -ne 0 ]
then
  echo "Import Publications Metadata failed"
  exit 1
fi

php rebuildall.php
if [ $? -ne 0 ]
then
  echo "Rebuildall failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Change to project directory failed"
  exit 1
fi

echo "Metadata imported succesful"