#!/bin/bash

export BORG_PASSPHRASE=`cat /etc/borg_passphrase`
DIR="Documents"
BACKUP_TARGET="/home/ngrogan/Dropbox/$DIR"
LOCAL_REPO="/home/ngrogan/backups/$DIR"
REMOTE_REPO="remote:/backups/$DIR"

borg init $LOCAL_REPO
borg create --compression lz4 -v --stats $LOCAL_REPO::$HOSTNAME-`date +%Y-%m-%d-%H%M%S` $BACKUP_TARGET

borg prune -v --list $LOCAL_REPO --keep-within 2d --keep-daily=10 --keep-weekly=4 --keep-monthly=12 --keep-yearly=100

rclone sync $LOCAL_REPO $REMOTE_REPO

