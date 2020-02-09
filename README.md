# gdrive-backup

A Google Drive backup script runner for Linux.

## Usage

Create a `.env` file with the following environment variables:
```
SRC_STARTDIR=/
DST_REMOTE=remote-name
DST_STARTDIR=backup-dir
HOME=/home/user-name
```
where:
* `SRC_STARTDIR` - local directory where files will be searched from, i.e. /
* `DST_REMOTE` - rclone remote name.
* `DST_STARTDIR` - directory in the remote, i.e. backup
* `HOME` - user home directory (to fix https://forum.rclone.org/t/config-file-used-under-sudo-changed/12072/12)

Create a `watch-directories.txt` with a list of Linux paths to watch for changes, for example:
```
/data/mydata
```

Create a `include-directories.txt` with a list of files to include in backup (similar to watch-directories), using RClone syntax (https://rclone.org/filtering/). For example:
```
/data/mydata/**
```

Can optionally modify `.config`.

Copy dependencies and enable the service:
```./setup.sh```

Start the service:
```./start.sh```

Stop the service:
```./stop.sh```

Check status and logs of service:
```./status.sh```

Restart with environment variable changes:
```./reload.sh```

## Linux dependencies

* systemd
* inotify-tools
* rclone
    * Need a Google Drive remote set up.
