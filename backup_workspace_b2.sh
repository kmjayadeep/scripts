#!/bin/bash
rclone sync /home/jayadeep/workspace b2:jayadeep-pc-backup/workspace -P --exclude-from /home/jayadeep/workspace/backup_exclude_config.conf -v
