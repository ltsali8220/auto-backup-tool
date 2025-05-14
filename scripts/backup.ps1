# PowerShell Backup Script

# Load configuration from the backup-config.txt file
$configPath = "..\config\backup-config.txt"
$config = Get-Content $configPath | ConvertFrom-StringData

# Set variables from configuration
$sourcePath = $config['SourcePath']
$destinationPath = $config['DestinationPath']
$backupSchedule = $config['BackupSchedule']
$retentionDays = [int]$config['RetentionDays']
$logPath = "..\logs\backup-log.txt"

# Function to perform backup
function Perform-Backup {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - Starting backup from $sourcePath to $destinationPath"
    Add-Content -Path $logPath -Value $logEntry

    try {
        # Create destination directory if it doesn't exist
        if (-not (Test-Path $destinationPath)) {
            New-Item -ItemType Directory -Path $destinationPath
        }

        # Perform the backup
        Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force

        $logEntry = "$timestamp - Backup completed successfully."
        Add-Content -Path $logPath -Value $logEntry
    } catch {
        $logEntry = "$timestamp - Error during backup: $_"
        Add-Content -Path $logPath -Value $logEntry
    }
}

# Function to manage log retention
function Manage-LogRetention {
    if (Test-Path $logPath) {
        $logAge = (Get-Date) - (Get-Item $logPath).LastWriteTime
        if ($logAge.Days -ge $retentionDays) {
            Remove-Item $logPath -Force
            $logEntry = "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - Old log file deleted."
            Add-Content -Path $logPath -Value $logEntry
        }
    }
}

# Manage log retention
Manage-LogRetention

# Perform backup based on schedule
switch ($backupSchedule) {
    "daily" {
        Perform-Backup
    }
    "weekly" {
        if ((Get-Date).DayOfWeek -eq 'Monday') {
            Perform-Backup
        }
    }
    "monthly" {
        if ((Get-Date).Day -eq 1) {
            Perform-Backup
        }
    }
    default {
        Write-Host "Invalid backup schedule specified."
    }
}