#!/usr/bin/env bash

echo "Logging to: $LOG_DIR"
echo "Log level: $LOG_LEVEL"
echo "Including directories from: $INCLUDE_FILE"
echo "Starting from local directory: $SRC_STARTDIR"
echo "Writing to remote: $DST_REMOTE"
echo "Writing to remote's subdirectory: $DST_STARTDIR"

echo "Watching for File System events: $WATCH_EVENTS"
echo "Watcher timer set to: $WATCH_TIMEOUT"
echo "Watching from list of files in: $WATCH_FILE"


if [ ! -z "$LOG_DIR" ]
then
    LOG_FILE=$LOG_DIR/`date '+%Y_%m_%d_%H_%M_%N_%z'`.backup.log
fi
touch $LOG_FILE


doBackup() {
    rclone sync \
           --filter-from $INCLUDE_FILE \
           --create-empty-src-dirs \
           $SRC_STARTDIR $DST_REMOTE:$DST_STARTDIR \
           --drive-chunk-size=256M --transfers=10 --drive-pacer-burst=600 \
           $LOG_LEVEL \
           --log-file=$LOG_FILE
}


doBackup # first backup
while [ true ]
do
    # backup only if file system changes
    STATUS=$(inotifywatch -e $WATCH_EVENTS -t $WATCH_TIMEOUT --fromfile $WATCH_FILE)
    echo "Notify status: $STATUS"
    if [ ! -z "$STATUS" ] # if STATUS is not an empty string
    then
        echo "Logging to file: $LOG_FILE"
        echo "Backing up..."
        doBackup
        echo "Done"
    fi
done
