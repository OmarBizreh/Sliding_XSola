#!/sbin/sh

#Vengeance Boot-rec
# trigger cyan LED
echo '255' > /sys/class/leds/blue/brightness
echo '255' > /sys/class/leds/green/brightness

# trigger button-backlight
echo '255' > /sys/class/leds/so34-led0/brightness
echo '255' > /sys/class/leds/so34-led1/brightness
echo '255' > /sys/class/leds/so34-led2/brightness
cat /dev/input/event1 > /dev/keycheck&
sleep 3

# trigger off cyan LED
echo '0' > /sys/class/leds/blue/brightness
echo '0' > /sys/class/leds/green/brightness
echo '0' > /sys/class/leds/red/brightness


# trigger button-backlight
echo '0' > /sys/class/leds/so34-led0/brightness
echo '0' > /sys/class/leds/so34-led1/brightness
echo '0' > /sys/class/leds/so34-led2/brightness

kill -9 $!
