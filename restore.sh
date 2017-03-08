#!/bin/bash

export BORG_PASSPHRASE=`cat /etc/borg_passphrase`
DIR="Documents"
LOCAL_REPO="/home/ngrogan/backups/$DIR"
REMOTE_REPO="remote:/backups/$DIR"
DATE=`date +%Y-%m-%d-%H%M%S`
RESTORE_DIR="/tmp/restore/$DATE/$DIR"

echo "Making directory locally to restore in to: $RESTORE_DIR"
mkdir -p $RESTORE_DIR

echo "Starting to sync backup from the cloud..."
rclone sync $REMOTE_REPO $RESTORE_DIR/raw

echo "Starting to extract the latest backup..."
backups=($(borg list $RESTORE_DIR/raw))
cd $RESTORE_DIR
borg extract $RESTORE_DIR/raw::${backups[-4]}

