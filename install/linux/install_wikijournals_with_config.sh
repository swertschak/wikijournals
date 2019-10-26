#!/usr/bin/env bash

echo Install Wikijournals

. $(pwd)/wikijournals.conf


echo $(date) = Install Wikijournals = > $PROJECTDIR/install/linux/wikijournals.log

sh check_config_parameters.sh

if [ $? -ne 0 ]
then
  echo "Failed Parameters check"
  exit 1
fi

sh ./install_mediawiki.sh
if [ $? -ne 0 ]
then
  echo "Mediawiki instalallation failed"
  exit 1
fi

sh ./install_foreground.sh
if [ $? -ne 0 ]
then
  echo "Foreground instalallation failed"
  exit 1
fi

sh ./install_semanticmediawiki.sh
if [ $? -ne 0 ]
then
  echo "Semantic Mediawiki instalallation failed"
  exit 1
fi

sh ./install_smw_extensions.sh
if [ $? -ne 0 ]
then
  echo "SMW Extension instalallation failed"
  exit 1
fi

sh ./install_nosmw_extensions.sh
if [ $? -ne 0 ]
then
  echo "NoSMW Extension instalallation failed"
  exit 1
fi

sh ./install_translation_extensions.sh
if [ $? -ne 0 ]
then
  echo "Translation Extensions instalallation failed"
  exit 1
fi

sh ./install_wikijournals_structure.sh
if [ $? -ne 0 ]
then
  echo "Wikijournals Structure instalallation failed"
  exit 1
fi

sh ./import_metadata.sh
if [ $? -ne 0 ]
then
  echo "Import Metadata instalallation failed"
  exit 1
fi

echo $(date) = Install Wikijournals successful = >> $PROJECTDIR/install/linux/wikijournals.log


