#!/usr/bin/env bash

echo Update Wikijournals

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

echo $(date) = Update Wikijournals = > $PROJECTDIR/install/linux/wikijournals.log

sh ./update_mediawiki.sh
if [ $? -ne 0 ]
then
  echo "Mediawiki update failed"
  exit 1
fi

sh ./update_foreground.sh
if [ $? -ne 0 ]
then
  echo "Foreground update failed"
  exit 1
fi

sh ./update_semanticmediawiki.sh
if [ $? -ne 0 ]
then
  echo "Semantic Mediawiki update failed"
  exit 1
fi

sh ./update_smw_extensions.sh
if [ $? -ne 0 ]
then
  echo "SMW Extension update failed"
  exit 1
fi

sh ./update_nosmw_extensions.sh
if [ $? -ne 0 ]
then
  echo "NoSMW Extension update failed"
  exit 1
fi

sh ./update_translation_extensions.sh
if [ $? -ne 0 ]
then
  echo "Translation Extensions update failed"
  exit 1
fi

echo $(date) = Update Wikijournals successful = >> $PROJECTDIR/install/linux/wikijournals.log


