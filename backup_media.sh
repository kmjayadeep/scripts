
# backup_media: backup media folder to b2

#!/bin/bash
rclone copy /home/jayadeep/Media b2-media:jd-media/ -P -v --s3-upload-concurrency 10 --s3-no-head-object --s3-no-head
