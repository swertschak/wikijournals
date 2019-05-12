#!/usr/bin/env bash

echo List line parameter

echo html directory: $1
echo wikijournals directory: $2
echo dbuser: $3
echo dbpass: $4
echo dbserver: $5
echo dbname: $6
echo wikiuser: $7
echo wikipwd: $8
echo wikiname: $9

echo check number of parameters

check=0

#echo $# arguments

if [ $# -ne 9 ];
    then
        echo "illegal number of parameters"
        ((++check))
    else echo "correct number of parameters"
fi

echo check parameter html directory

if [ -d $1 ]
then
    echo "Directory $1 exists"
    else
        echo "Directory $1 do not exists"
        ((++check))


fi

echo check database parameter

 RESULT=`mysql -u$3 -p$4 -e "SHOW DATABASES" | grep $6`
 if [ "$RESULT" == "$6" ]; then
    echo "Database $6 exist"

 else
    echo "Database $6 does not exist"
    ((++check))
 fi


echo $check

if [ $check -eq 0 ]
then echo "Check successful"
else echo "Check failed"
fi

#RESULT = mysql -u$3 -p$4 $6 -e exit

#RESULT = 'mysql -u$3 -p$4 $6'

#echo
#echo $?



#if [ $? == 0 ]
#then echo "Database connection could be established"
#else echo "Database connection could not be establiesh, Check Database name, user name and password"
#fi

#echo $?
