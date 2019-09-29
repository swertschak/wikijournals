echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

cd %HTMLDIR%\%WIKIDIR%\skins
git clone https://github.com/thingles/foreground.git

call "%PROJECTDIR%\install\windows\fnr.exe" --cl --dir "%HTMLDIR%\%WIKIDIR%" --fileMask "LocalSettings.php" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "$wgDefaultSkin = ""vector"";" --replace "$wgDefaultSkin = ""foreground"";"

cd ..

type LocalSettings.php %PROJECTDIR%\config\configForeground.txt > LocalSettings.bak
del LocalSettings.php
ren LocalSettings.bak LocalSettings.php

cd %PROJECTDIR%\install\windows
