#!/bin/bash

cd /app

if [ ! -r "/users.yaml" ]; then
  echo "course file /users.yaml not readable"
  exit 1
fi

touch  /data/log/askbot.log

if [ ! -w "/data/log/askbot.log" ]; then
  echo "logfile /data/log/askbot.log not writeable"
  exit 1
fi

if [ ! -f "/data/askbot.db" ]; then
  echo "No DB! Copying clean one..."
  cp /data-default/askbot.db /data/askbot.db 
fi

if [ ! -w "/data/askbot.db" ]; then
  echo "db file /data/askbot.db not writeable"
  exit 1
fi

echo "creating settings"

cat /app/settings.py | sed 's,^ASKBOT_APP_URL = \(.*\)$,ASKBOT_APP_URL = \"https:\/\/'"$ASKBOT_URL"'\/askbot\",g' > /app/settings_configged.py
mv /app/settings_configged.py /app/settings.py

echo "migrate"
cat askbot_requirements.txt
python manage.py migrate --noinput

cat  /data/log/askbot.log

#
# Temp hack.  We shouldn't need sudo or to do this, except the first time
# we run after the fix for running as a normal user: https://github.com/dtu-compute/dtu-enote-askbot/issues/6
#
sudo chown -R `whoami`:`whoami` /data/

echo "running uwsgi at ${ASKBOT_URL}..."

/usr/sbin/uwsgi /app/uwsgi.ini
