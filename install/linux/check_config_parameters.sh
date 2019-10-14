#!/usr/bin/env bash

echo off

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
echo Project Directory: $PROJECTDIR

echo check HTMLDIR

if [ -d "$HTMLDIR" ]
then
echo "Directory $HTMLDIR exists"
else
echo "Directory $HTMLDIR not exists"
exit 1
fi

echo "Check write access for html directory"

if [ -w "$HTMLDIR" ];
then
echo "directory "$HTMLDIR" is writeable"
else
echo "Directory $HTMLDIR not writable"
exit 2
fi

echo "Check Database Parameters"

RESULT=`mysql -u$DBUSER -p$DBPASS -e "SHOW DATABASES" | grep $DBNAME`
echo $RESULT
if  [ "$RESULT" = "$DBNAME" ];
then
echo "Database $DBNAME exist"
else
echo "Database $DBNAME not exist"
exit 3
fi

echo "check Mediawiki Version"

wget --spider https://releases.wikimedia.org/mediawiki/$MEDIAWIKIVERSION/mediawiki-$MEDIAWIKIVERSION.$MEDIAWIKIMINORVERSION.tar.gz
if [ $? -eq 0 ]
then
  echo "Mediawiki Version exis"

else
  echo "Mediawiki Version not exists"
  exit 4
fi

echo "Check if Project Directory exists"

if [ -d "$PROJECTDIR" ]
then
echo "Directory $PROJECTDIR exists"
else
echo "Directory $PROJECTDIR not exists"
exit 5
fi

echo "Check if Project Directory contains Install directories"
