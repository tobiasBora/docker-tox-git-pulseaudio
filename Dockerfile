FROM ubuntu:14.04
MAINTAINER Terje Larsen

# Install Spotify and PulseAudio.
WORKDIR /usr/src
RUN apt-get update \
    && apt-get install -y xdg-utils libxss1 pulseaudio \
    && apt-get clean \
    && echo enable-shm=no >> /etc/pulse/client.conf

RUN apt-get install -y firefox

# PulseAudio server.
ENV PULSE_SERVER /run/pulse/native

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["firefox"]
