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

PROJECTDIR=$(pwd)

echo check number of parameters

check=0

echo "Check user rights"

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

            echo "Check Composer"

            composer -V
            if [[ $? -ne 0 ]];
            then
                echo "Composer not found"
                ((++check))
             else
                echo "Composer found"

            fi

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
    mwminor=1
    wget https://releases.wikimedia.org/mediawiki/$mwmain/mediawiki-$mwmain.$mwminor.tar.gz

    if [[ $? -ne 0 ]]; then
    echo "wget failed"
    exit 1;

    else
        echo "Download Mediawiki Version $mwmain.$mwminor successful"
        echo Uncompress Mediawiki into wikijournals directory


#        tar -xvzf mediawiki-$mwmain.$mwminor.tar.gz
#        mv mediawiki-$mwmain.$mwminor $2
#        rm mediawiki-$mwmain.$mwminor.tar.gz

#        echo Set rights for www-data
#
#        chown -cR www-data:www-data $2
#
#        echo Install Wikijournals
#
#        cd $1/$2/maintenance
#
#        php install.php --dbuser=$3 --dbpass=$4 --dbserver=$5 --dbname=$6 --dbtype=mysql --installdbpass=$4 --installdbuser=$3 --lang=de --pass=$8 --scriptpath=/$2  $9 $7
#        cd ..
#
#        echo Install foreground
#        cd skins
#        git clone https://github.com/thingles/foreground.git
#        cd ..
#        sed -i 's/$wgDefaultSkin = \"vector/$wgDefaultSkin = \"foreground/' LocalSettings.php
#
#        cd extensions
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageForms
#
#        cd ..
#
#        echo Install Semantic Mediawiki
#        composer require mediawiki/semantic-media-wiki "3.0.1"
#        cd maintenance
#        php update.php
#        cd ..
#
#        cd extensions
#
#        echo Install SMW Extensions
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
#        cd ..
#
#        echo Install Maps
#        composer require mediawiki/maps "7.1.0"
#
#        echo Install Semantic Result Formats
#        composer require mediawiki/semantic-result-formats "3.0.0"
#
#        echo Install Semantic Compound Queries
#        composer require mediawiki/semantic-compound-queries "2.0.0"
#
#        cd extensions
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
#        git clone https://phabricator.wikimedia.org/diffusion/EHET/extension-headertabs.git
#        mv extension-headertabs HeaderTabs
#        git clone https://phabricator.wikimedia.org/diffusion/EMYV/extension-myvariables.git
#        mv extension-myvariables MyVariables
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
#        git clone https://phabricator.wikimedia.org/diffusion/EVAR/extension-variables.git
#        mv extension-variables Variables
#        git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git
#
#        cd Widgets
#        git submodule init
#        git submodule update
#
#        echo Update LocalSetting.php
#        cd $1/$2
#
#        cat $PROJECTDIR/config/configExtensions.txt >> LocalSettings.php
#        sed -i 's/$wgLanguageCode = \"en/$wgLanguageCode = \"de/' LocalSettings.php
#        cd maintenance
#        php update.php
#
#        echo Install Translation Extensions
#
#        cd $1/$2/extensions
#
#        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
#        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
#        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
#        #git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/LocalisationUpdate.git
#        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
#        git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git
#
#        cd $1/$2
#
#        cat $PROJECTDIR/config/configTranslation.txt >> LocalSettings.php
#
#        cd $1/$2/maintenance
#
#        php update.php
#
#        echo Install Wikijournals Structure
#
#        php importDump.php < $PROJECTDIR/wikijournals_structure/wikijournalsStructure.xml
#
#        echo Import Metadata Publisher
#
#        php importDump.php < $PROJECTDIR/data/publisher.xml
#
#        echo Import Metadata Publications
#
#        php importDump.php < $PROJECTDIR/data/publications.xml
#
#        cd $PROJECTDIR

    fi

else
    echo "Check failed"
fi


