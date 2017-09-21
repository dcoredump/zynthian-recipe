# zynthian-mod-kiosk
. $ZYNTHIAN_DIR/zynthian-recipe/recipe/_zynth_lib.sh
x#apt-get -y install midori chromium-browser matchbox x11-xserver-utils sqlite3 libnss3 xinit fbset 

cat <<EOF >/etc/rc.local
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
A
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

/usr/bin/printf "         My IP address is\033[0;31m `/sbin/ifconfig | grep "inet addr" | grep -v "127.0.0.1" | awk '{ print \$2 }' | awk -F: '{ print \$2 }'` \033[0m\n" > /dev/console

# Wait for the TV-screen to be turned on...
while ! \$( tvservice --dumpedid /tmp/edid | fgrep -qv 'Nothing written!' ); do
        bHadToWaitForScreen=true;
        printf "===> Screen is not connected, off or in an unknown mode, waiting for it to become available...\n"
        sleep 10;
done;

printf "===> Screen is on, extracting preferred mode...\n"
_DEPTH=32;
eval \$( edidparser /tmp/edid | fgrep 'preferred mode' | tail -1 | sed -Ene 's/^.+(DMT|CEA) \(([0-9]+)\) ([0-9]+)x([0-9]+)[pi]? @.+/_GROUP=\1;_MODE=\2;_XRES=\3;_YRES=\4;/p' );

printf "===> Resetting screen to preferred mode: %s-%d (%dx%dx%d)...\n" \$_GROUP \$_MODE \$_XRES \$_YRES \$_DEPTH
tvservice --explicit="\$_GROUP \$_MODE"
sleep 1;

printf "===> Resetting frame-buffer to %dx%dx%d...\n" \$_XRES \$_YRES \$_DEPTH
fbset --all --geometry \$_XRES \$_YRES \$_XRES \$_YRES \$_DEPTH -left 0 -right 0 -upper 0 -lower 0;
sleep 1;

if [ -f /boot/xinitrc ]; then
        ln -fs /boot/xinitrc .xinitrc;
        startx &
fi

exit 0
EOF

cat << EOF >/boot/xinitrc
#!/bin/sh
while true
do
        # Clean up previously running apps, gracefully at first then harshly
        killall -TERM chromium 2>/dev/null;
        killall -TERM matchbox-window-manager 2>/dev/null;
        sleep 2;
        killall -9 chromium 2>/dev/null;
        killall -9 matchbox-window-manager 2>/dev/null;

        # Clean out existing profile information
        rm -rf /home/pi/.cache;
        rm -rf /home/pi/.config;
        rm -rf /home/pi/.pki;

        # Generate the bare minimum to keep Chromium happy!
        mkdir -p /home/pi/.config/chromium/Default
        sqlite3 /home/pi/.config/chromium/Default/Web\ Data "CREATE TABLE meta(key LONGVARCHAR NOT NULL UNIQUE PRIMARY KEY, value LONGVARCHAR); INSERT INTO meta VALUES('version','46'); CREATE TABLE keywords (foo INTEGER);";

        # Disable DPMS / Screen blanking
        xset -dpms
        xset s off

        # Reset the framebuffer's colour-depth
        fbset -depth \$( cat /sys/module/*fb*/parameters/fbdepth );

        # Hide the cursor (move it to the bottom-right, comment out if you want mouse interaction)
        #xwit -root -warp \$( cat /sys/module/*fb*/parameters/fbwidth ) \$( cat /sys/module/*fb*/parameters/fbheight )

        # Start the window manager (remove "-use_cursor no" if you actually want mouse interaction)
        matchbox-window-manager -use_titlebar no -use_cursor no &

        # Start the browser (See http://peter.sh/experiments/chromium-command-line-switches/)
        chromium-browser  --app=http://localhost:8888 --no-sandbox
	#midori -e Fullscreen -a http://localhost:8888
done
EOF
sed -i -r -- '/^# 1900x1200 at 32bit depth, DMT mode/d' /boot/config.txt
sed -i -r -- '/^framebuffer.+/d' /boot/config.txt
sed -i -r -- '/^hdmi_.+/d' /boot/config.txt
sed -i -r -- '/^disable_overscan.+/d' /boot/config.txt
sed -i -r -- '/^max_usb_current.+/d' /boot/config.txt
cat <<EOF >>/boot/config.txt
# 1900x1200 at 16bit depth, DMT mode
disable_overscan=1
framebuffer_width=1900
framebuffer_height=1200
framebuffer_depth=16
framebuffer_ignore_alpha=1
hdmi_pixel_encoding=1
# for Waveshare Display:
max_usb_current=1
hdmi_group=2
hdmi_mode=1
hdmi_mode=87
hdmi_cvt 1280 800 60 6 0 0 0
EOF
sed -i -r -- 's/^gpu_mem=[0-9]+/gpu_mem=64/' /boot/config.txt
