#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Update NoSMW Extensions - >> $PROJECTDIR/install/linux/wikijournals.log

cd $HTMLDIR/$WIKIDIR/extensions

cd AdminLinks
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating AdminLinks repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd DataTransfer
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating DataTransfer repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd ExternalData
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating ExternalData repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd HeaderTabs
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating HeaderTabs repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd MyVariables
git pull
if [ $? -ne 0 ]
then
  echo $(date) Cloning MyVariables repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd PageSchemas
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating PageSchemas repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd Variables
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating Variables repository failed >> $PROJECTDIR/install/linux/wikijournals.log
  exit 1
fi
cd ..

cd Widgets
git pull
if [ $? -ne 0 ]
then
  echo $(date) Updating Widgets repository failed >> $PROJECTDIR/install/linux/wikijournals.log
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

echo $(date) - NoSMW Extensions updated succesful - >> $PROJECTDIR/install/linux/wikijournals.log