echo off

echo Install Translation Extensions

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

cd %HTMLDIR%/%WIKIDIR%/extensions

git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Babel.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/cldr.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/CleanChanges.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/Translate.git
git clone https://gerrit.wikimedia.org/r/mediawiki/extensions/UniversalLanguageSelector.git

cd %HTMLDIR%/%WIKIDIR%

type LocalSettings.php %PROJECTDIR%\config\configTranslation.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

cd %HTMLDIR%/%WIKIDIR%/maintenance

call php update.php

cd %PROJECTDIR%\install\windows