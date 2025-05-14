# Auto Backup Tool

## Overview
The Auto Backup Tool is a cross-platform backup solution designed to automate the backup process for both desktop and server environments. It supports Windows, Linux, and provides a unified configuration file to manage backup settings across different operating systems.

## Features
- **Cross-Platform Support**: Backup scripts available for Windows (Batch and PowerShell) and Linux (Bash).
- **Configuration Management**: A single configuration file to manage retention time, backup schedules, and source/destination paths.
- **Logging**: Automatic logging of backup activities for monitoring and troubleshooting.
- **Retention Policy**: Configurable retention time for both backups and logs.

## Project Structure
```
auto-backup-tool
├── scripts
│   ├── backup.bat        # Windows Batch script for backup
│   ├── backup.sh         # Linux Bash script for backup
│   ├── backup.ps1        # Windows PowerShell script for backup
├── config
│   └── backup-config.txt  # Configuration file for backup settings
├── logs
│   └── .gitkeep          # Keeps the logs directory in version control
├── README.md             # Project documentation
└── LICENSE               # Licensing information
```

## Setup Instructions
1. Clone the repository to your local machine.
2. Navigate to the `config` directory and edit the `backup-config.txt` file to set your backup preferences, including:
   - Source and destination paths
   - Retention time for backups
   - Backup schedule (daily, weekly, monthly)
3. Choose the appropriate script for your operating system:
   - For Windows, use `backup.bat` or `backup.ps1`.
   - For Linux, use `backup.sh`.
4. Schedule the script to run at your desired intervals using Task Scheduler (Windows) or cron jobs (Linux).

## Usage Guidelines
- Ensure that the source and destination directories specified in the configuration file are accessible.
- Review the log files generated in the `logs` directory to monitor backup activities and troubleshoot any issues.

## Examples
### Configuration Example
```
# backup-config.txt
source_path=C:\path\to\source
destination_path=D:\path\to\backup
retention_days=30
backup_schedule=daily
```

### Running the Backup
- For Windows Batch:
  ```
  backup.bat
  ```
- For PowerShell:
  ```
  .\backup.ps1
  ```
- For Linux:
  ```
  ./backup.sh
  ```

## License
This project is licensed under the MIT License. See the LICENSE file for more details.