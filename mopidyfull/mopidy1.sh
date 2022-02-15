#!/bin/bash
 mkdir -p /home/mopidy/.config/mopidy/
# exec rm -f /home/mopidy/.config/mopidy/mopidy.conf && echo "removed"
if [ ! -f /home/mopidy/.config/mopidy/mopidy.conf ]; then
    cp /mopidy_default.conf /home/mopidy/.config/mopidy/mopidy.conf
fi
echo "/home/mopidy/.config/mopidy/mopidy.conf file:"
cat /home/mopidy/.config/mopidy/mopidy.conf
systemd fs.protected_fifos=0
if [ -f /home/mopidy/.config/mopidy/mopidy.conf ]; then
    cat /mopidy_default.conf | tee /home/mopidy/.config/mopidy/mopidy.conf
fi
if [ ${APT_PACKAGES:+x} ]; then
    echo "-- INSTALLING APT PACKAGES $APT_PACKAGES --"
    sudo apt-get update
    sudo apt-get install -y $APT_PACKAGES
fi
if  [ ${PIP_PACKAGES:+x} ]; then
    echo "-- INSTALLING PIP PACKAGES $PIP_PACKAGES --"
    pip3 install $PIP_PACKAGES
fi
if [ ${UPDATE:+x} ]; then
    echo "-- UPDATING ALL PACKAGES --"
    sudo apt-get update
    sudo apt-get upgrade -y
    pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U # Upgrade all pip packages
fi

# exec mopidy --config /home/mopidy/.config/mopidy/mopidy.conf "$@"
exec mopidy --config /home/mopidy/.config/mopidy/mopidy.conf "$@"
