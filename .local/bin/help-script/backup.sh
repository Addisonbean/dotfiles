#!/usr/bin/env bash

source "$HOME/.local/bin/help-script/util.sh"

BACKUP_DRIVE="/mnt/backup"
BACKUP_DIR="$BACKUP_DRIVE/borg"
BORG_MOUNT_POINT="/tmp/borg"

action="$(echo -e "start-backup\nmount-backup\nmount\nunmount" | rofi-selection "Commands")"

# Also TODO
# Detect if the drive is connect and display a helpful error if not

if [ -z "$action" ]; then
	exit
fi

if [ -z "$(grep "$BACKUP_DRIVE" /proc/mounts)" ] && [ "$action" != "unmount" ]; then
	# TODO: abort w/ message if it couldn't mount (like it's not connected...)
	sudo mount "$BACKUP_DRIVE"
fi

case "$action" in
	start-backup)
		st -e zsh -c "time borg create --progress $BACKUP_DIR::$USER-{now:%Y-%m-%d} $HOME; zsh"
	;;
	mount-backup)
		# No no no wait... List the back ups in rofi and pick one, then open it in ranger? Or st?
		choice="$(borg list "$BACKUP_DIR" | awk -e '{ print $1 }' | rofi-selection "Backups")"

		if [ -z "$choice" ]; then
			exit
		fi

		# TODO: send a dunst notification when the mounting is done (w/ the mount point or something. Open it in ranger???)
		# borg mount "/mnt/backup/borg::$choice" "$BORG_MOUNT_POINT"
		# or maybe...
		# borg mount -o uid=1000,gid=1000 "/mnt/backup/borg::$choice" "$BORG_MOUNT_POINT"

		# And then, when the notif is clicked on, have it open the mount point in ranger???

		# dunst

		# $(cd $BACKUP_DIR && st) & disown
	;;
	mount)
		# This has been already done, no action needed...
		notify "Done"
	;;
	unmount)
		sudo umount "$BACKUP_DRIVE"
		sync

		notify "Done"
	;;
esac
