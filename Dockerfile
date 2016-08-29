FROM fedora:23

RUN dnf -y update
RUN dnf -y install python2 python2-devel gcc uwsgi python-wsgiref uwsgi-plugin-python PyYAML \
                   git libjpeg-turbo-devel libjpeg-turbo zlib zlib-devel redhat-rpm-config \
                   mailcap

# The develop option will not install askbot into the python site packages directory
#RUN git clone -b 0.7.x https://github.com/dtu-compute/askbot-devel && \
RUN git clone -b 0.7.x https://github.com/ASKBOT/askbot-devel.git && \
    rm -rf /askbot-devel/.git

COPY mycas.py uwsgi.ini config.sh cmd.sh /app/

#USER uwsgi

CMD ["/app/cmd.sh"]

