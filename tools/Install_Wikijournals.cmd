echo off
echo Install Mediawiki

cd maintenance
php install.php --dbuser=<db_user> --dbpass=<db_pwd> --dbserver=<db_server> --dbname=<db_name> --dbtype=mysql --installdbpass=<db_pwd> --installdbuser=<db_user> --lang=de --pass=<wiki_pwd> --scriptpath=/<wiki_dir>  <wiki_name> <wiki_user>
cd ..

echo Install foreground
cd skins
git clone https://github.com/thingles/foreground.git
cd ..


echo Install Semantic Mediawiki
call composer require mediawiki/semantic-media-wiki "*.*"
cd maintenance
php update.php

echo Install SMW Extensions
cd ..\extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticCompoundQueries.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticDrilldown.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/SemanticForms.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticFormsInputs.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/SemanticInternalObjects.git
cd ..
call composer require mediawiki/maps "*"
call composer require mediawiki/semantic-maps "*"
call composer require mediawiki/semantic-result-formats "*"
cd extensions
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/AdminLinks.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/DataTransfer.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ExternalData.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/HeaderTabs.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/MyVariables.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/PageSchemas.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/ReplaceText.git
git clone https://git.wikimedia.org/git/mediawiki/extensions/Variables.git
git clone https://gerrit.wikimedia.org/r/p/mediawiki/extensions/Widgets.git
cd Widgets
git submodule init
git submodule update