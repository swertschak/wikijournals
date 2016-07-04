# wikijournals

## Description

What ist wikijournals? Wikijournals has two meanings:

* A web application, based on Semantic Wedawiki, which can be host on an own web server (here on GitHub you can found the sourcecode)
* A web portal (https://wikijournals.info) for capturing meta-data of journal articles

## Installation

### Requirements

* Linux Server
* Webserver Apache 2.x
* Database Mysql 5.x
* PHP 5.x
* Minimum 200 MB Space
* git callable per commandline (see https://git-scm.com/downloads)
* composer callable per command line (see https://getcomposer.org/download
* Existing empty Database in MySql

### Pre-Install Tasks

* Download git repo
* Create empty database in mysql
* The following database parameters will be used for the installation
  * Database name
  * Database user
  * Database user password


### Installation per Script

* Open Terminal
* Change to the wikijournals code directory (the cloned git repo)
* execute command tools/Install_Wikijournals.sh as sudo with the follwing 9 parameters in this order
  * html directory
  * wikijournals directory
  * dbuser
  * dbpass
  * dbserver
  * dbname
  * wikiuser
  * wikipwd
  * wikiname
* Sample: sudo sh tools/Install_Wikijournals.sh /var/www/html wikijournals_3 wikiuser mypassword localhost wikijournals_3 Administrator myadminpasswd wikijournals


### Manual Installation

__Install Mediawiki__

* Download current Mediawiki version from mediawiki.org
* Uncompress the mediawiki archive
* Upload the uncompressed archive to the web server f.i. /htdocs/wikijournals
* Ensure access to the web directory including sub-directories for the web user (f.i. www-data)
* For example per chown command: sudo chown -cR www-data:www-data wikijournals
* Perform normal mediawiki installation (see https://www.mediawiki.org/wiki/Manual:Installation_guide)

__Install Foreground Theme__

* Download Foreground (git clone https://github.com/thingles/foreground.git)
* Install Foreground, see https://github.com/thingles/foreground/
* Set Foreground as Default Skin (see https://www.mediawiki.org/wiki/Manual:$wgDefaultSkin)

__Install Semantic Mediawiki__

* see https://www.semantic-mediawiki.org/wiki/Help:Installation

__Install the following Semantic Extensions__

* [Semantic Compound Queries](https://www.mediawiki.org/wiki/Extension:Semantic_Compound_Queries)
* [Semantic Drilldown](https://www.mediawiki.org/wiki/Extension:Semantic_Drilldown)
* [Semantic Forms](https://www.mediawiki.org/wiki/Extension:Semantic_Forms)
* [Semantic Forms Input](https://www.mediawiki.org/wiki/Extension:Semantic_Forms_Inputs)
* [Semantic Internal Objects](https://www.mediawiki.org/wiki/Extension:Semantic_Internal_Objects)
* [Semantic Maps](https://www.mediawiki.org/wiki/Extension:Semantic_Maps)
* [Semantic Result Formats](https://www.mediawiki.org/wiki/Extension:Semantic_Result_Formats)

__Install further Mediawiki Extensions__

* [Maps](https://www.mediawiki.org/wiki/Extension:Maps)
* [Admin Links](https://www.mediawiki.org/wiki/Extension:Admin_Links)
* [Data Transfer](https://www.mediawiki.org/wiki/Extension:Data_Transfer)
* [External Data](https://www.mediawiki.org/wiki/Extension:External_Data)
* [Header Tabs](https://www.mediawiki.org/wiki/Extension:Header_Tabs)
* [MyVariables](https://www.mediawiki.org/wiki/Extension:MyVariables)
* [Page Schemas](https://www.mediawiki.org/wiki/Extension:Page_Schemas)
* [Replace Text](https://www.mediawiki.org/wiki/Extension:Replace_Text)
* [Variables](https://www.mediawiki.org/wiki/Extension:Variables)
* [Widgets](https://www.mediawiki.org/wiki/Extension:Widgets)

__Install Wikijournals Structure__

* Open terminal
* Change to wikijournals directory on the web server
* Change to maintenance directory
* Copy wikijournalsStructure.xml from the wikijournals_structure directory to the maintenance dir
* execute php importDump.php < wikijournalsStructure.xml






