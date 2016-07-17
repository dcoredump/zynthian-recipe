# Full mod-ui test:
cd "${HOME}/zynthian/zynthian-sw/mod-ui"
sudo service zynthian stop
sudo skill jackd
sudo skill ttymidi
sudo /usr/local/bin/jackd -P70 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2 &
sudo /usr/local/bin/ttymidi -s /dev/ttyAMA0 -b 38400 &
sudo /usr/bin/a2jmidid --export-hw &
sudo LV2_PATH="/home/pi/zynthian/zynthian-plugins/lv2" /usr/local/bin/mod-host 
sudo LV2_PATH="/home/pi/zynthian/zynthian-plugins/lv2" MOD_DEV_ENVIRONMENT=0 ./server.py
# Now you can connect to <Zynthian-IP>:8888
