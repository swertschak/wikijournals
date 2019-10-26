#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Install foreground - >> $PROJECTDIR/install/linux/wikijournals.log
cd $HTMLDIR/$WIKIDIR/skins
if [ $? -ne 0 ]
then
  echo $(date) Could not change to skins directory >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://github.com/thingles/foreground.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning foreground repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd ..
sed -i 's/$wgDefaultSkin = \"vector/$wgDefaultSkin = \"foreground/' LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Setting foreground as default skin failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi


cat $PROJECTDIR/config/configForeground.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Appending foreground config to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Changing to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Foreground skin installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log