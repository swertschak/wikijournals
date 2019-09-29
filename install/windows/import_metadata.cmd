echo off
echo Install Wikijournals Structure

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

cd %HTMLDIR%/%WIKIDIR%

cd %HTMLDIR%/%WIKIDIR%/maintenance

echo Import Metadata Publisher

call php importDump.php < %PROJECTDIR%\data\publisher.xml

echo Import Metadata Publications

call php importDump.php < %PROJECTDIR%\data\publications.xml

call php rebuildall.php

cd %PROJECTDIR%\install\windows