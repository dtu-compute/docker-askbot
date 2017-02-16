FROM fedora:24

RUN dnf -y update
RUN dnf -y install python2 python2-devel gcc uwsgi python-wsgiref uwsgi-plugin-python PyYAML \
                   git libjpeg-turbo-devel libjpeg-turbo zlib zlib-devel redhat-rpm-config \
                   mailcap

# The develop option will not install askbot into the python site packages directory
#RUN git clone -b 0.7.x https://github.com/dtu-compute/askbot-devel && \
RUN echo foo>cachebust
RUN git clone -b 0.7.x https://github.com/ASKBOT/askbot-devel.git && \
    rm -rf /askbot-devel/.git

COPY askbot.env run.sh mycas.py uwsgi.ini config.sh cmd.sh /app/

#USER uwsgi

RUN "/app/cmd.sh"

CMD [ "/app/run.sh" ]
