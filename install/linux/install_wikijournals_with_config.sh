#!/usr/bin/env bash

echo Install Wikijournals

. $(pwd)/wikijournals.conf

echo html directory: $HTMLDIR
echo wikijournals directory: $WIKIDIR
echo dbuser: $DBUSER
echo dbpass: $DBPASS
echo dbserver: $DBSERVER
echo dbname: $DBNAME
echo wikiuser: $WIKIUSER
echo wikipwd: $WIKIPWD
echo wikiname: $WIKINAME
echo Mediawiki Main Version: $MEDIAWIKIVERSION
echo Mediawiki Minor Version: $MEDIAWIKIMINORVERSION
echo SMW Version: $SMWVERSION
echo SMW Result Format Version: $SMWRESULTFORMATVERSION
echo SMW Compound Queries Version: $SMWCOMPOUNDQUERIESVERSION
echo Maps Version: $MAPSVERSION

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
  echo "Mediawiki installation failed"
  exit 1
fi

sh ./install_foreground.sh
if [ $? -ne 0 ]
then
  echo "Foreground installation failed"
  exit 1
fi

sh ./install_semanticmediawiki.sh
if [ $? -ne 0 ]
then
  echo "Semantic Mediawiki installation failed"
  exit 1
fi

sh ./install_smw_extensions.sh
if [ $? -ne 0 ]
then
  echo "SMW Extension installation failed"
  exit 1
fi

sh ./install_nosmw_extensions.sh
if [ $? -ne 0 ]
then
  echo "NoSMW Extension installation failed"
  exit 1
fi

sh ./install_translation_extensions.sh
if [ $? -ne 0 ]
then
  echo "Translation Extensions installation failed"
  exit 1
fi

sh ./install_wikijournals_structure.sh
if [ $? -ne 0 ]
then
  echo "Wikijournals Structure installation failed"
  exit 1
fi

sh ./import_metadata.sh
if [ $? -ne 0 ]
then
  echo "Import Metadata installation failed"
  exit 1
fi

echo $(date) = Install Wikijournals successful = >> $PROJECTDIR/install/linux/wikijournals.log


