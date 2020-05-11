#!/usr/bin/env bash

echo off

. $(pwd)/wikijournals.conf

echo $(date) - Check Config Parameters - >> $PROJECTDIR/install/linux/wikijournals.log

echo $(date) html directory: $HTMLDIR >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) wikijournals directory: $WIKIDIR >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) dbuser: $DBUSER >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) dbpass: $DBPASS >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) dbserver: $DBSERVER >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) dbname: $DBNAME >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) wikiuser: $WIKIUSER >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) wikipwd: $WIKIPWD >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) wikiname: $WIKINAME >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) Mediawiki Main Version: $MEDIAWIKIVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) Mediawiki Minor Version: $MEDIAWIKIMINORVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) SMW Version: $SMWVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) SMW Result Format Version: $SMWRESULTFORMATVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) SMW Compound Queries Version: $SMWCOMPOUNDQUERIESVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) Maps Version: $MAPSVERSION >> $PROJECTDIR/install/linux/wikijournals.log
echo $(date) Project Directory: $PROJECTDIR >> $PROJECTDIR/install/linux/wikijournals.log

echo $(date) check HTMLDIR >> $PROJECTDIR/install/linux/wikijournals.log

if [ -d "$HTMLDIR" ]
then
echo $(date) Directory $HTMLDIR exists >> $PROJECTDIR/install/linux/wikijournals.log
else
echo $(date) Directory $HTMLDIR not exists >> $PROJECTDIR/install/linux/wikijournals.log
exit 1
fi

echo $(date) Check write access for html directory >> $PROJECTDIR/install/linux/wikijournals.log

if [ -w "$HTMLDIR" ];
then
echo $(date) directory "$HTMLDIR" is writeable >> $PROJECTDIR/install/linux/wikijournals.log
else
echo $(date) Directory $HTMLDIR not writable >> $PROJECTDIR/install/linux/wikijournals.log
exit 2
fi

echo $(date) Check Database Parameters >> $PROJECTDIR/install/linux/wikijournals.log

RESULT=`mysql -u$DBUSER -p$DBPASS -e "SHOW DATABASES" | grep $DBNAME`
echo $RESULT
if  [ "$RESULT" = "$DBNAME" ];
then
echo $(date) Database $DBNAME exist >> $PROJECTDIR/install/linux/wikijournals.log
else
echo $(date) Database $DBNAME not exist >> $PROJECTDIR/install/linux/wikijournals.log
exit 3
fi

echo $(date) check Mediawiki Version >> $PROJECTDIR/install/linux/wikijournals.log

wget --spider https://releases.wikimedia.org/mediawiki/$MEDIAWIKIVERSION/mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -eq 0 ]
then
  echo $(date) Mediawiki Version exists >> $PROJECTDIR/install/linux/wikijournals.log

else
  echo $(date) Mediawiki Version not exists >> $PROJECTDIR/install/linux/wikijournals.log
  exit 4
fi

echo $(date) Check if Project Directory exists >> $PROJECTDIR/install/linux/wikijournals.log

if [ -d "$PROJECTDIR" ]
then
echo $(date) Directory $PROJECTDIR exists >> $PROJECTDIR/install/linux/wikijournals.log
else
echo $(date) Directory $PROJECTDIR not exists >> $PROJECTDIR/install/linux/wikijournals.log
exit 5
fi

# echo "Check if Project Directory contains Install directories"

echo $(date) - Check Config Parameters successful - >> $PROJECTDIR/install/linux/wikijournals.log
