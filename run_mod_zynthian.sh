# Full mod-ui test:
cd "${HOME}/zynthian/zynthian-sw/mod-ui"
sudo skill jackd
sudo skill a2jmidid
sudo skill ttymidi
sudo /usr/local/bin/jackd -P70 -t2000 -s -dalsa -dhw:0 -r44100 -p256 -n2 &
#sudo /usr/local/bin/ttymidi -s /dev/ttyAMA0 -b 38400 &
sudo /usr/local/bin/a2jmidid -e -u &
sudo jack_alias "a2j:USB Device 0x170b:0x11 (capture): USB Device 0x170b:0x11 MIDI 1" ttymidi:MIDI_in
sudo /usr/local/bin/mod-host 
export PYTHONPATH="/usr/local/lib/python3.4/dist-packages"
sudo "${HOME}/zynthian/zynthian-sw/mod-ui/server.py"
# Now you can connect to <Zynthian-IP>:8888
