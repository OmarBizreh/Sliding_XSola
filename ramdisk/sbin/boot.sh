#!/sbin/sh
setprop service.adb.root 1

if [ -e /sbin/bootrec-device.sh ]
then
  /sbin/bootrec-device.sh
fi

if [ -s /dev/keycheck -o -e /cache/recovery/boot ]
then
  rm /cache/recovery/boot
# trigger vibration
  echo 50 > /sys/class/timed_output/vibrator/enable
  echo 0 > /sys/class/android_usb/android0/enable
  echo 0fce > /sys/class/android_usb/android0/idVendor
  echo 6146 > /sys/class/android_usb/android0/idProduct
  echo mass_storage,adb > /sys/class/android_usb/android0/functions
  echo 1 > /sys/class/android_usb/android0/enable
  echo "Sony Ericsson" > /sys/class/android_usb/android0/iManufacturer
  echo LT22i > /sys/class/android_usb/android0/iProduct
  stop adbd

  sleep 2
  mount -o remount,rw rootfs /
  umount -l /system
  umount -l /data
  umount -l /cache
  umount -l /sdcard
  umount -l /mnt/sdcard
  rm -r /sdcard
  rm -r /not/sdcard
  mkdir /sdcard
  mkdir /tmp
  rm /etc
  mkdir /etc
  cp /recovery.fstab /etc/recovery.fstab
  mount /dev/block/mmcblk0p14 /sdcard
  /sbin/recovery&
fi
#continue booting
