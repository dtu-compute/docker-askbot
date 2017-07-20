#!/usr/bin/bash

source /app/askbot.env

# The setting names can be found by looking into files askbot/conf/*.py
# To place them into settings.py a prefix ASKBOT_ must be added.
# E.g. for setting APP_URL it will be
# ASKBOT_APP_URL = 'http://example.com/'
cat << EOF >> /app/settings.py

DEBUG = False

ASKBOT_APP_URL = ''
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

ASKBOT_FOOTER_MODE = disable
ASKBOT_RSS_ENABLED = False
ASKBOT_ENABLE_SHARING_TWITTER = False
ASKBOT_ENABLE_SHARING_FACEBOOK = False
ASKBOT_ENABLE_SHARING_LINKEDIN = False
ASKBOT_ENABLE_SHARING_IDENTICA = False
ASKBOT_ENABLE_SHARING_GOOGLE = False

ASKBOT_MIN_REP_TO_AUTOAPPROVE_USER = 0
ASKBOT_MIN_REP_TO_UPLOAD_FILES = 0
ASKBOT_MIN_REP_TO_INSERT_LINK = 0
ASKBOT_MIN_REP_TO_SUGGEST_LINK = 0

ENABLE_MATHJAX = True
ASKBOT_ENABLE_MATHJAX = True
MATHJAX_BASE_URL = '/MathJax'
ASKBOT_MATHJAX_BASE_URL = '/MathJax'

ADMINS = (
    ('DTU Admin', 'test@dtu.dk'),
    ('DTU Test Admin', 'enotema@dtu.dk'),
)

TIME_ZONE = 'Europe/Copenhagen'

ASKBOT_ALLOWED_UPLOAD_FILE_TYPES = ('.jpg', '.jpeg', '.png')

EOF

r=$(od -vAn -N16 -tx < /dev/urandom | tr -d " ")

echo SECRET_KEY = \'$r\' >> /app/settings.py

