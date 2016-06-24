import yaml

def get_data():
    users_file = open('users.yaml', 'r')
    return yaml.load(users_file)

def is_user_admitted(login_name):
    return login_name in get_data()

def get_username(login_name):
    return get_data().get(login_name)

def get_email(login_name):
    return '{}@student.dtu.dk'.format(login_name)
EOF

