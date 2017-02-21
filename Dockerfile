FROM fedora:25

# For busting the cache in the event of changes to the askbot project upon which we depend.
# this should be the hash of the HEAD commit, so when that changes we'll rebuild the container
# https://github.com/dtu-compute/dtu-enote-askbot/issues/6
ARG DEPENDENCY_HASH=1

RUN dnf -y update
RUN dnf -y install python2 python2-devel gcc uwsgi python-wsgiref uwsgi-plugin-python PyYAML \
                   git libjpeg-turbo-devel libjpeg-turbo zlib zlib-devel redhat-rpm-config \
                   mailcap

# to handle running as a normal user
#
# Temp hack.  We shouldn't need sudo or to do this, except the first time
# we run after the fix for running as a normal user: https://github.com/dtu-compute/dtu-enote-askbot/issues/6
#
RUN dnf -y install sudo

# The develop option will not install askbot into the python site packages directory
#RUN git clone -b 0.7.x https://github.com/dtu-compute/askbot-devel && \

RUN git clone -b 0.7.x https://github.com/ASKBOT/askbot-devel.git && \
    rm -rf /askbot-devel/.git

COPY askbot.env run.sh mycas.py uwsgi.ini config.sh cmd.sh /app/

RUN "/app/cmd.sh"

# run as a non-root user
RUN adduser dtuuser && \
    echo "dtuuser ALL=(root) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /askbot-devel/ /data-default && \
    chown -R dtuuser:dtuuser /askbot-devel && \
    chown -R dtuuser:dtuuser /data-default && \
    chown -R dtuuser:dtuuser /app

USER dtuuser

CMD [ "/app/run.sh" ]
