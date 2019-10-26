#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Install NoSMW Extensions - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR/extensions

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning AdminLinks repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning DataTrabsfer repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning ExternalData repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git HeaderTabs
if [ $? -ne 0 ]
then
  echo $(date) Cloning HeaderTabs repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git MyVariables
if [ $? -ne 0 ]
then
  echo $(date) Cloning MyVariables repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning PageSchemas repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git Variables
if [ $? -ne 0 ]
then
  echo $(date) Cloning Variables repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git
if [ $? -ne 0 ]
then
  echo $(date) Cloning Widgets repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cd Widgets
if [ $? -ne 0 ]
then
  echo $(date) Changing to widgets directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi


git submodule init
if [ $? -ne 0 ]
then
  echo $(date) Init widgets failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

git submodule update
if [ $? -ne 0 ]
then
  echo $(date) Update widgets failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) Update LocalSetting.php >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo $(date) Changing to wikijournals directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

cat $PROJECTDIR/config/configNoSMWExtensions.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo $(date) Append NoSMW Extensions config to LocalSettings.php failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi


cd $HTMLDIR/$WIKIDIR/maintenance
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
  echo $(date) Changing to Project Directory failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi

echo $(date) - NoSMW Extensions installed succesful - >> $PROJECTDIR/install/linux/wikijournals.log