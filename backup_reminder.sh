#!/bin/bash
read -r last_backup_date  < ~/workspace/backups/last_backup_date
current_date=$(date -u +"%Y-%m-%d")
[[ "$last_backup_date" =~ $current_date.* ]] || echo "Last backup was done on $last_backup_date"
