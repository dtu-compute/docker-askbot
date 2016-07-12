#!/usr/bin/bash


# The setting names can be found by looking into files askbot/conf/*.py
# To place them into settings.py a prefix ASKBOT_ must be added.
# E.g. for setting APP_URL it will be
# ASKBOT_APP_URL = 'http://example.com/'

cat << EOF >> /app/settings.py


DEBUG = False

ASKBOT_APP_URL = "http://enote.compute.dtu.dk/"

ASKBOT_CAS_USER_FILTER = 'mycas.is_user_admitted'
ASKBOT_CAS_USER_FILTER_DENIED_MSG = 'Sorry, access allowed only to Students of group XYZ'

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

SECRET_KEY = 'eb0aa30e79f2800cebc58b73ae06f08c'

ADMINS = (
    ('DTU Admin', 'test@dtu.dk'),
)

TIME_ZONE = 'Europe/Copenhagen'

ASKBOT_ALLOWED_UPLOAD_FILE_TYPES = ('.jpg', '.jpeg', '.png')

EOF

