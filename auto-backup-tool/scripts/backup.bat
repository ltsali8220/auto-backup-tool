@echo off
setlocal

:: Load configuration from backup-config.txt
set "configFile=..\config\backup-config.txt"
for /f "tokens=1,2 delims==" %%A in ('type "%configFile%"') do (
    set "%%A=%%B"
)

:: Create log file with timestamp
set "logFile=..\logs\backup_%date:~-4,4%_%date:~-10,2%_%date:~-7,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%.log"
echo Backup started at %date% %time% > "%logFile%"

:: Perform backup
echo Backing up from %sourceDir% to %destDir% >> "%logFile%"
xcopy "%sourceDir%\*" "%destDir%\" /E /I /Y >> "%logFile%" 2>&1

if %errorlevel% neq 0 (
    echo Backup failed with error code %errorlevel% >> "%logFile%"
) else (
    echo Backup completed successfully >> "%logFile%"
)

:: Handle log retention
forfiles /p ..\logs /s /m backup_*.log /d -%retentionDays% /c "cmd /c del @path"

endlocal
exit /b 0