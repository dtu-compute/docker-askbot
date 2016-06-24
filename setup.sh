#!/usr/bin/bash

mkdir -p /data/log /data/upfiles /app 
touch /data/log/askbot.log

cd /askbot-devel

python setup.py develop

if [ ! -f /data/askbot.db ]; then
  askbot-setup --dir-name=/app --db-engine=2 --db-name=/data/askbot.db

  /app/config.sh

  cd /app
  python manage.py collectstatic --noinput --ignore /data/
  python manage.py syncdb --noinput
fi

cd /app
python manage.py migrate --noinput

