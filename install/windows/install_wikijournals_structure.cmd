echo off
echo Install Wikijournals Structure

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

cd %HTMLDIR%/%WIKIDIR%

type LocalSettings.php %PROJECTDIR%\config\configWikijournalsStructure.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

cd %HTMLDIR%/%WIKIDIR%/maintenance

call php update.php

call php importDump.php < %PROJECTDIR%\wikijournals_structure\wikijournalsStructure.xml

cd %PROJECTDIR%\install\windows