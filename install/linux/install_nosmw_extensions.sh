#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

cd $HTMLDIR/$WIKIDIR/extensions

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
if [ $? -ne 0 ]
then
  echo "Cloning AdminLinks repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
if [ $? -ne 0 ]
then
  echo "Cloning DataTrabsfer repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
if [ $? -ne 0 ]
then
  echo "Cloning ExternalData repository failed"
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git HeaderTabs
if [ $? -ne 0 ]
then
  echo "Cloning HeaderTabs repository failed"
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git MyVariables
if [ $? -ne 0 ]
then
  echo "Cloning MyVariables repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
if [ $? -ne 0 ]
then
  echo "Cloning PageSchemas repository failed"
  exit 1
fi

git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git Variables
if [ $? -ne 0 ]
then
  echo "Cloning Variables repository failed"
  exit 1
fi

git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git
if [ $? -ne 0 ]
then
  echo "Cloning Widgets repository failed"
  exit 1
fi

cd Widgets
if [ $? -ne 0 ]
then
  echo "Changing to widgets directory failed"
  exit 1
fi


git submodule init
if [ $? -ne 0 ]
then
  echo "Init widgets failed"
  exit 1
fi

git submodule update
if [ $? -ne 0 ]
then
  echo "Update widgets failed"
  exit 1
fi

echo Update LocalSetting.php

cd $HTMLDIR/$WIKIDIR
if [ $? -ne 0 ]
then
  echo "Changing to wikijournals directory failed"
  exit 1
fi

cat $PROJECTDIR/config/configNoSMWExtensions.txt >> LocalSettings.php
if [ $? -ne 0 ]
then
  echo "Append NoSMW Extensions config to LocalSettings.php failed"
  exit 1
fi


cd $HTMLDIR/$WIKIDIR/maintenance
if [ $? -ne 0 ]
then
  echo "Changing to maintenance directory failed"
  exit 1
fi

php update.php
if [ $? -ne 0 ]
then
  echo "Update Mediawiki failed"
  exit 1
fi

cd $PROJECTDIR/install/linux
if [ $? -ne 0 ]
then
  echo "Changing to Project Directory failed"
  exit 1
fi

echo "NoSMW Extensions installed succesful"