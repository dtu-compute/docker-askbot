#!/usr/bin/bash

mkdir -p /data/log /data/upfiles /app 
touch /data/log/askbot.log

cd /askbot-devel

python setup.py develop

# workaround as celery 4.0.0rc3 is buggy and askbot can't build with it
pip uninstall --yes celery && pip install celery==3.1.18
pip freeze > /app/installed_python_packages


if [ ! -f /data/askbot.db ]; then
  askbot-setup --dir-name=/app --db-engine=2 --db-name=/data/askbot.db

  echo "config"
  /app/config.sh

  cd /app
  echo "collect static"
  python manage.py collectstatic --noinput --ignore /data/
  echo "syncdb"
  python manage.py syncdb --noinput
fi


cd /app
echo "migrate"
python manage.py migrate --noinput

cat  /data/log/askbot.log

/usr/sbin/uwsgi /app/uwsgi.ini

