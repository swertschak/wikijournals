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
    else
        echo "correct number of parameters"

        echo check parameter html directory

        if [ -d $1 ]

        then
            echo "Directory $1 exists"

            echo check database parameter

            RESULT=`mysql -u$3 -p$4 -e "SHOW DATABASES" | grep $6`

            if [ "$RESULT" == "$6" ]; then

            echo "Database $6 exist"

            else
            echo "Database $6 does not exist"
            ((++check))

            fi

        else
            echo "Directory $1 do not exists"
            ((++check))
        fi


fi


echo "Check Result: " $check


if [ $check -eq 0 ]
then
    echo "Check successful"
    echo Download Mediawiki

    cd $1
    mwmain=1.32
    mwminor=0
    wget https://releases.wikimedia.org/mediawiki/$mwmain/mediawiki-$mwmain.$mwminor.tar.gz

    if [[ $? -ne 0 ]]; then
    echo "wget failed"
    exit 1;

    else
        echo "Download Mediawiki Version $mwmain.$mwminor successful"
        echo Uncompress Mediawiki into wikijournals directory
        tar -xvzf mediawiki-$mwmain.$mwminor.tar.gz
        mv mediawiki-$mwmain.$mwminor $2
        rm mediawiki-$mwmain.$mwminor.tar.gz



    fi

else
    echo "Check failed"
fi


