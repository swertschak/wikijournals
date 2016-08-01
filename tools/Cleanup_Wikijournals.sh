#!/usr/bin/env bash

echo Check command line parameter

echo html directory: $1
echo wikijournals directory: $2
echo dbuser: $3
echo dbpass: $4
echo dbserver: $5
echo dbname: $6

PROJECTDIR=$(pwd)

echo remove wiki directory

rm -rf $1/$2

echo remove wiki database

mysqladmin -u$3 -p$4 drop $6

echo remove mediawiki download

rm $1/mediawiki-1.27.0.tar.gz
