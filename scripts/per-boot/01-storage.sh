#!/bin/bash
###
### Script to find all disks that are not already formatted or mounted
###
# Create /etc/cloud/scripts/per-boot/01-storage.sh

# Make sure that /etc/cloud/scipts/per-boot exists
mkdir -p /data

# Create array of disks to ignore
IGNORE=(sda floppy loop sr cdrom dvdrom fd)

# Find all disks except those in the ignore array
DISKS=$(lsblk -d -n -o NAME | grep -v -E "$(
    IFS="|"
    echo "${IGNORE[*]}"
)")

# Print the disks found
echo "Disks found: $DISKS"

# Loop through the disks found and list any disks that are not mounted and also not formatted
for DISK in $DISKS; do
    if [ -z "$(lsblk -d -n -o MOUNTPOINT /dev/$DISK)" ] && [ -z "$(lsblk -d -n -o FSTYPE /dev/$DISK)" ]; then
        # Announce that the disk is not formatted or mounted
        echo
        echo "Disk $DISK is not formatted or mounted"
        # Find the highest numbered /data/mount mount point
        MOUNTID=$(ls -d /data/mount[1-9] | sort -n | tail -1 | sed 's/.*\([1-9]\)/\1/')
        # If no mount points exist, use 1
        if [ -z "$MOUNTID" ]; then
            MOUNTID=1
        else
            # Increment the mount point number
            MOUNTID=$((MOUNTID + 1))
        fi
        # Create the mount point
        echo
        echo "Creating mount point /data/mount$MOUNTID"
        mkdir -p /data/mount$MOUNTID

        # Format the disk
        echo
        echo "Formatting disk $DISK"
        mkfs.xfs -q -L mount$MOUNTID /dev/$DISK

        # Mount the disk
        echo
        echo "Mounting disk $DISK"
        mount -o noatime,nodiratime,inode64,logbsize=256k,logbufs=8,allocsize=16m /dev/$DISK /data/mount$MOUNTID
    else
        # Announce that the disk is formatted or mounted
        echo
        echo "Disk $DISK is already formatted or mounted"
    fi
done

exit 0

# EOF
