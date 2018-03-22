apt update && apt dist-upgrade -y
apt autoremove
apt install -y --no-install-recommends python3-jack-client python3-liblo python3-requests python3-websocket python3-jsonpickle

pip3 install tornado
pip3 install tornadostreamform
pip3 install alsaseq
