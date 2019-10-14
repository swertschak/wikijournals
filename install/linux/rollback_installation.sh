#!/usr/bin/env bash

echo Check command line parameter

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

echo remove wiki directory

rm -rf $HTMLDIR/$WIKIDIR

echo remove wiki tables from database

MYSQL=$(which mysql)
AWK=$(which awk)
GREP=$(which grep)

TABLES=$($MYSQL -u $DBUSER -p$DBPASS $DBNAME -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables' )

for t in $TABLES
do
	echo "Deleting $t table from $DBNAME database..."
	$MYSQL -u $DBUSER -p$DBPASS $DBNAME -e "drop table $t"
done