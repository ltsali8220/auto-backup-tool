#!/bin/bash

# Load configuration
CONFIG_FILE="../config/backup-config.txt"
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found!"
    exit 1
fi

source "$CONFIG_FILE"

# Function to perform backup
perform_backup() {
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_DIR="$DESTINATION/$TIMESTAMP"
    
    mkdir -p "$BACKUP_DIR"
    
    # Copy files
    cp -r "$SOURCE"/* "$BACKUP_DIR"
    
    # Log the backup
    echo "Backup completed at $TIMESTAMP" >> "../logs/backup.log"
}

# Check backup schedule
case "$SCHEDULE" in
    daily)
        perform_backup
        ;;
    weekly)
        if [ "$(date +%u)" -eq 1 ]; then
            perform_backup
        fi
        ;;
    monthly)
        if [ "$(date +%d)" -eq 1 ]; then
            perform_backup
        fi
        ;;
    *)
        echo "Invalid schedule specified in configuration."
        exit 1
        ;;
esac

# Log retention
find "../logs" -type f -name "*.log" -mtime +$RETENTION_TIME -exec rm {} \;