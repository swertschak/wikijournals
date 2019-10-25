echo off

for /f "delims=" %%x in (wikijournals.ini) do (set "%%x")

echo %date%-%time% == Install Wikijournals == >> %PROJECTDIR%\install\windows\wikijournals.log

call install_mediawiki.cmd
call install_foreground.cmd
call install_semanticmediawiki.cmd
call install_smw_extensions.cmd
call install_nosmw_extensions.cmd
call install_translation_extensions.cmd
call install_wikijournals_structure.cmd
call import_metadata.cmd

echo %date%-%time% == Wikijournals successful installed == >> %PROJECTDIR%\install\windows\wikijournals.log