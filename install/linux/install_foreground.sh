#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo Install foreground
cd $HTMLDIR/$WIKIDIR/skins
if [ $? -ne 0 ]
then
  echo "Could not change to skins directory"
  exit 1
fi

git clone https://github.com/thingles/foreground.git
if [ $? -ne 0 ]
then
  echo "Cloning foreground repository failed"
  exit 1
fi

cd ..
sed -i 's/$wgDefaultSkin = \"vector/$wgDefaultSkin = \"foreground/' LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Settin foreground as default skin failed"
  exit 1
fi


cat $PROJECTDIR/config/configForeground.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Appending foreground config to LocalSettings.php failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Changing to project directory failed"
  exit 1
fi

echo "Foreground skin installed succesful"