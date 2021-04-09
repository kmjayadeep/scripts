#!/bin/bash
rclone sync /home/jayadeep/workspace home-ftp:jayadeep-workspace-backup -P -v --transfers 1 --ftp-concurrency 1 --exclude-from /home/jayadeep/workspace/backup_exclude_config.conf
