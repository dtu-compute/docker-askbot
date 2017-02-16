#!/usr/bin/bash

source /app/askbot.env

# The setting names can be found by looking into files askbot/conf/*.py
# To place them into settings.py a prefix ASKBOT_ must be added.
# E.g. for setting APP_URL it will be
# ASKBOT_APP_URL = 'http://example.com/'
echo "ASKBOT_APP_URL = 'https://${ASKBOT_URL}'" >> /app/settings.py
tail /app/settings.py
cat << EOF >> /app/settings.py

#DEBUG = True
DEBUG = False

#ASKBOT_APP_URL = ''
ASKBOT_URL = 'askbot/'

ASKBOT_CAS_USER_FILTER = 'mycas.is_user_admitted'
ASKBOT_CAS_USER_FILTER_DENIED_MSG = 'Access only allowed for students taking the course'
CAS_USER_FILTER_DENIED_MSG = 'Access only allowed for students taking the course'

ASKBOT_CAS_GET_USERNAME = 'mycas.get_username'
ASKBOT_CAS_GET_EMAIL = 'mycas.get_email'

ASKBOT_CAS_ONE_CLICK_REGISTRATION_ENABLED = True

ASKBOT_CAS_SERVER_NAME = 'DTU CampusNet'
ASKBOT_CAS_SERVER_URL = 'https://auth.dtu.dk/dtu/'

ASKBOT_SIGNIN_CAS_ENABLED = True
ASKBOT_SIGNIN_YAHOO_ENABLED = False
ASKBOT_SIGNIN_AOL_ENABLED = False
ASKBOT_SIGNIN_OPENID_ENABLED = False
ASKBOT_SIGNIN_FLICKR_ENABLED = False
ASKBOT_SIGNIN_TECHNORATI_ENABLED = False
ASKBOT_SIGNIN_WORDPRESS_ENABLED = False
ASKBOT_SIGNIN_BLOGGER_ENABLED = False
ASKBOT_SIGNIN_LIVEJOURNAL_ENABLED = False
ASKBOT_SIGNIN_CLAIMID_ENABLED = False
ASKBOT_SIGNIN_VIDOOP_ENABLED = False
ASKBOT_SIGNIN_VERISIGN_ENABLED = False
ASKBOT_SIGNIN_LOCAL_ENABLED = False

ADMINS = (
    ('DTU Admin', 'test@dtu.dk'),
)

TIME_ZONE = 'Europe/Copenhagen'

ASKBOT_ALLOWED_UPLOAD_FILE_TYPES = ('.jpg', '.jpeg', '.png')

EOF

r=$(od -vAn -N16 -tx < /dev/urandom | tr -d " ")

echo SECRET_KEY = \'$r\' >> /app/settings.py

