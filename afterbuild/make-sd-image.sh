#!/bin/bash

# CONFIG
ROOTFS_IMG=./output/images/rootfs.ext2
SD_IMG=$1
PROGRAM_SIZE_MB=$2

# CALCULATE
PROGRAM_SIZE="$(($PROGRAM_SIZE_MB * 1024 * 1024))"
ROOTFS_SIZE="$(ls -l $ROOTFS_IMG | awk '{print $5}')"
PROGRAM_CYLINDERS="$(($PROGRAM_SIZE / 512 / 255 / 63  + 1))"
ROOTFS_CYLINDERS="$(($ROOTFS_SIZE / 512 / 255 / 63  + 1))"
PROGRAM_ROUND_SIZE="$(($PROGRAM_CYLINDERS * 512 * 255 * 63))"
ROOTFS_ROUND_SIZE="$(($ROOTFS_CYLINDERS * 512 * 255 * 63))"
SD_SIZE="$((512 * 63 + $PROGRAM_ROUND_SIZE + $ROOTFS_ROUND_SIZE))"

# CREATE FILE
dd if=/dev/zero of=$SD_IMG bs=512 count="$(($SD_SIZE / 512))"

# PARTITIONING AND FATING
MTOOLSRC="./mtools.conf"
echo "drive a: file=\"$SD_IMG\" mformat_only partition=1 heads=255 sectors=63 cylinders=$PROGRAM_CYLINDERS" > $MTOOLSRC
echo "drive b: file=\"$SD_IMG\" mformat_only partition=2 heads=255 sectors=63 cylinders=$ROOTFS_CYLINDERS" >> $MTOOLSRC
mpartition -I a:
mpartition -c a:
mpartition -c b:
mformat a: -v LIN_PROGRAM
rm $MTOOLSRC

# COPY READY ROOTFS IMAGE
PART2_START="$(fdisk -lu $SD_IMG  | grep sd.img2 | awk '{print $2}')"
dd if=$ROOTFS_IMG of=$SD_IMG bs=512 seek=$PART2_START
