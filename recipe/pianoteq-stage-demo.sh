# pianoteq-stage-demo
# /zynthian/zynthian-sw/Pianoteq 6 STAGE/arm# ./Pianoteq\ 6\ STAGE --headless --multicore max --internal-rate 22050 --jack-session "Pianoteq" --preset "MKI Tremo" 
#
sudo apt-get -y --no-install-recommends install libfreetype6 libasound2 libx11-6 libxext6 fontconfig-config xauth p7zip-full
cd /zynthian/zynthian-sw
mkdir Pianoteq
mkdir tmp
cd tmp
wget https://www.pianoteq.com/try?q=Zzl0RmJzdGltZW91dD0yMDE4MDEwODE3MDMzOTthY3Rpb249ZG93bmxvYWQ7ZmlsZT1waWFub3RlcV9zdGFnZV9saW51eF90cmlhbF92NjAzLjd6dEZiczMyMWNjNDg37z -x *.7z
mv "Pianoteq 6 STAGE/arm/Pianoteq 6 STAGE.lv2" /zynthian/zynthian-plugins/lv2
mv "Pianoteq 6 STAGE/arm/Pianoteq 6 STAGE" /zynthian/zynthian-sw/Pianoteq
cd ..
rm -r tmp
cd /root
tar xvzf /zynthian/zynthian-recipe/recipe/piantoteq_config.tar.gz
cd /zynthian/zynthian-sw
