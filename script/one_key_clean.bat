@echo off
setlocal EnableDelayedExpansion
title One-Click System Cleanup Tool

:: Check for Administrator privileges
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo.
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"

cls
echo ===============================================================================
echo                           One-Click System Cleanup
echo ===============================================================================
echo.
echo This script will clean:
echo  - User Temporary Files
echo  - System Temporary Files
echo  - Windows Update Cache
echo  - Windows Prefetch
echo  - NPM / PNPM / Yarn Caches
echo.
echo Close all other applications for best results.
echo.
pause

echo.
echo [1/7] Cleaning User Temp Directory...
del /f /s /q "%TEMP%\*.*" >nul 2>&1
for /d %%p in ("%TEMP%\*.*") do rd "%%p" /s /q >nul 2>&1
echo Done.

echo.
echo [2/7] Cleaning System Temp Directory...
del /f /s /q "%WINDIR%\Temp\*.*" >nul 2>&1
for /d %%p in ("%WINDIR%\Temp\*.*") do rd "%%p" /s /q >nul 2>&1
echo Done.

echo.
echo [3/7] Cleaning Windows Prefetch...
del /f /s /q "%WINDIR%\Prefetch\*.*" >nul 2>&1
echo Done.

echo.
echo [4/7] Cleaning Windows Update Download Cache...
echo Stopping Windows Update Service...
net stop wuauserv >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*.*" >nul 2>&1
for /d %%p in ("%WINDIR%\SoftwareDistribution\Download\*.*") do rd "%%p" /s /q >nul 2>&1
echo Restarting Windows Update Service...
net start wuauserv >nul 2>&1
echo Done.

echo.
echo [5/7] Cleaning NPM Cache...
where npm >nul 2>&1
if %errorlevel% equ 0 (
    call npm cache clean --force
) else (
    echo NPM not found, skipping.
)

echo.
echo [6/7] Cleaning PNPM Store...
where pnpm >nul 2>&1
if %errorlevel% equ 0 (
    call pnpm store prune
) else (
    echo PNPM not found, skipping.
)

echo.
echo [7/7] Cleaning Yarn Cache...
where yarn >nul 2>&1
if %errorlevel% equ 0 (
    call yarn cache clean
) else (
    echo Yarn not found, skipping.
)

echo.
echo ===============================================================================
echo                              Cleanup Complete!
echo ===============================================================================
echo.
pause
