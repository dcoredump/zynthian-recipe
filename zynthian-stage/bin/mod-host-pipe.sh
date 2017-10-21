#!/bin/bash
if [ -e /tmp/mod-host ]
then
        rm /tmp/mod-host
fi
/usr/bin/mkfifo /tmp/mod-host
/usr/bin/tail -f /tmp/mod-host | /usr/local/bin/partrt run -f99 rt /usr/local/bin/mod-host -i
