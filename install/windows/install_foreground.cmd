echo off

echo Set install parameter from ini file

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo - Install Foreground Skin - >> %PROJECTDIR%\install\windows\wikijournals.log

cd %HTMLDIR%\%WIKIDIR%\skins
if %ERRORLEVEL% NEQ 0 (
echo Could not change to skins directory >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

git clone https://github.com/thingles/foreground.git
if %ERRORLEVEL% NEQ 0 (
echo Cloning foreground repository failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

call "%PROJECTDIR%\install\windows\fnr.exe" --cl --dir "%HTMLDIR%\%WIKIDIR%" --fileMask "LocalSettings.php" --excludeFileMask "*.dll, *.exe" --includeSubDirectories --find "$wgDefaultSkin = ""vector"";" --replace "$wgDefaultSkin = ""foreground"";"
if %ERRORLEVEL% NEQ 0 (
echo Setting foreground as default skin failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)


cd ..

type LocalSettings.php %PROJECTDIR%\config\configForeground.txt > LocalSettings.bak
if %ERRORLEVEL% NEQ 0 (
echo Append foreground Config to LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

del LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo Deleting old Settings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

ren LocalSettings.bak LocalSettings.php
if %ERRORLEVEL% NEQ 0 (
echo Rename new LocalSettings.php failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

cd %PROJECTDIR%\install\windows
if %ERRORLEVEL% NEQ 0 (
echo Change to Project Directory failed >> %PROJECTDIR%\install\windows\wikijournals.log
exit 1
)

echo Foreground skin installed successful >> %PROJECTDIR%\install\windows\wikijournals.log
