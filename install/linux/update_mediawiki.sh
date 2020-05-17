#!/usr/bin/env bash

echo off

echo Check command line parameter

. $(pwd)/wikijournals.conf

echo $(date) - Update Mediawiki - >> $PROJECTDIR/install/linux/wikijournals.log

echo $(date) Download Mediawiki >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR

wget https://releases.wikimedia.org/mediawiki/$MEDIAWIKIVERSION/mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo $(date) Download Mediawiki failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Uncompress Mediawiki into wikijournals directory >> $PROJECTDIR/install/linux/wikijournals.log

tar -xvzf mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -ne 0 ]
then
  echo $(date) Uncompress Mediawiki Download failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Copy new content from mediawiki into wikijournals directory >> $PROJECTDIR/install/linux/wikijournals.log
cp -r mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION/* $WIKIDIR/

if [ $? -ne 0 ]
then
  echo $(date) Copy Mediawiki Content into wikijournals directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

rm mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz

if [ $? -ne 0 ]
then
  echo $(date) Remove Mediawiki download failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

rm -r mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION

if [ $? -ne 0 ]
then
  echo $(date) Remove Mediawiki directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo $(date) Change to Project Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - Mediawiki Update succesful - >> $PROJECTDIR/install/linux/wikijournals.log