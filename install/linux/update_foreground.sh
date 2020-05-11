#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Update foreground - >> $PROJECTDIR/install/linux/wikijournals.log
cd $HTMLDIR/$WIKIDIR/skins/foreground
if [ $? -ne 0 ]
then
  echo $(date) Could not change to foreground skins directory >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git pull
if [ $? -ne 0 ]
then
  echo $(date) Update foreground repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Changing to project directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Foreground skin updated succesful - >> $PROJECTDIR/install/linux/wikijournals.log