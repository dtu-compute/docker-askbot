#!/bin/bash

cd /app

if [ ! -f /data/askbot.db ]; then
  echo "No DB! Copying clean one..."
  cp /data-default/askbot.db /data/askbot.db 
fi


echo "migrate"
python manage.py migrate --noinput

cat  /data/log/askbot.log

echo "running uwsgi at ${ASKBOT_URL}..."

/usr/sbin/uwsgi /app/uwsgi.ini