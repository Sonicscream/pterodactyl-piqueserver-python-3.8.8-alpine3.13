FROM        python:3.8.8-alpine3.13
LABEL       author="Sonicscream" maintainer="sonicscream@cryptoclover.cc"
RUN         apk update && \
            apk upgrade && \
            apk add --no-cache --virtual delete_me git cargo libffi-dev g++ zlib-dev jpeg-dev openssl-dev && \
            git --version && \
            python --version && \
            pip --version && \
            export TMPDIR='/var/tmp' && \
            pip install git+git://github.com/piqueserver/piqueserver.git@02a130832400332c94bfcfee7b4bff7b2274659a && \
            apk del delete_me
RUN         adduser -D -h /home/container container
USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container
COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/ash", "/entrypoint.sh"]
