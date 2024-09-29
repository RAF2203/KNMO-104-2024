"@echo off
setlocal enabledelayedexpansion

if "%~1" == "/?" (
    
    echo this script converts .txt files from cp866 to utf-8 in the directory

    echo enconvert.cmd [directory]

    exit /b 0
)


if "%~1" == "" (

    echo please type in a directory

    echo encovered.cmd [directory]

    exit /b 1
)

set "directory=%~1"

if not exist "%directory%" (

    echo this directory doesn't exist

    exit /b 1
)

echo directory found: %directory%


for /r "%directory%" %%f in (*.txt) do (

    set "filepath=%%f"
    
    set "tmpfilepath=!filepath!_tmp"

    if exist "!tmpfilepath!" (

        del /f "!tmpfilepath!"
    )
    
    powershell -Command "Get-Content !filepath! -Encoding OEM | Out-File !tmpfilepath! -Encoding UTF8"

    if exist "!tmpfilepath!" (

        move /y "!tmpfilepath!" "!filepath!"

        echo success: !filepath!

    ) else (

        echo error: !filepath!
    )
)

echo conversion complete!
exit /b 0
