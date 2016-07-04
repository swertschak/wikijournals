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
* Download current Mediawiki version from mediawiki.org
* Uncompress the mediawiki archive
* Upload the uncompressed archive to the web server f.i. /htdocs/wikijournals
* Ensure access to the web directory including sub-directories for the web user (f.i. www-data)
* For example per chown command: sudo chown -cR www-data:www-data wikijournals


### Installation per Script


### Manual Installation

