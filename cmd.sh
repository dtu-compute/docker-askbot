#!/usr/bin/bash

mkdir -p /data/log /data/upfiles /app
touch /data/log/askbot.log

cd /askbot-devel

cat askbot_requirements.txt

pip install python-daemon
pip install django-appconf
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

python setup.py develop
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

# workaround as celery 4.0.0rc3 is buggy and askbot can't build with it
pip uninstall --yes celery && pip install celery==3.1.18
pip uninstall --yes six && pip install six==1.10.0
pip freeze > /app/installed_python_packages

askbot-setup --dir-name=/app --db-engine=2 --db-name=/data/askbot.db
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "config"
/app/config.sh

cd /app

echo "collect static"
python manage.py collectstatic --noinput --ignore /data/
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

echo "syncdb"
python manage.py syncdb --noinput
rc=$?; if [[ $rc != 0 ]]; then exit $rc; fi

mv /data /data-default

