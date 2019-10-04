#!/usr/bin/env bash

echo Install Wikijournals

. $(pwd)/wikijournals.conf

sh ./install_mediawiki.sh
sh ./install_foreground.sh
sh ./install_semanticmediawiki.sh
sh ./install_smw_extensions.sh
sh ./install_nosmw_extensions.sh
# sh ./install_translation_extensions.sh
sh ./install_wikijournals_structure.sh
sh ./import_metadata.sh