FROM debian:sid
# FROM ubuntu:14.04
MAINTAINER Tobias Bora

# Install Spotify and PulseAudio.
WORKDIR /usr/src
RUN apt-get update \
    && apt-get install -y xdg-utils libxss1 pulseaudio \
    && apt-get clean \
    && echo enable-shm=no >> /etc/pulse/client.conf

RUN apt-get install -y build-essential libtool autotools-dev automake checkinstall check git yasm libopus-dev libvpx-dev pkg-config libfontconfig1-dev libdbus-1-dev libv4l-dev libxrender-dev libopenal-dev libxext-dev cmake

# Install libsodium
RUN git clone git://github.com/jedisct1/libsodium.git \
    && cd libsodium \
    && git checkout tags/1.0.3 \
    && ./autogen.sh \
    && ./configure && make check \
    && checkinstall --pkgversion=1.0.3 \
    && ldconfig \
    && cd ..

# Install filter_audio
RUN git clone git://github.com/irungentoo/filter_audio.git \
    && cd filter_audio \
    && make \
    && checkinstall \
    && ldconfig \
    && cd ..

# Install c-toxcore.git
RUN git clone git://github.com/TokTok/c-toxcore.git \
    && cd c-toxcore \
    && cmake . \
    && make \
    && checkinstall --pkgversion=$(git rev-list --count HEAD)\
    && ldconfig \
    && cd ..

# Install uTox with the new bootstrap nodes that run only on port 443
COPY files/tox_bootstrap.h /tmp/
RUN git clone git://github.com/uTox/uTox.git \
    && cp /tmp/tox_bootstrap.h uTox/src/ \
    && cd uTox/ \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && checkinstall \
    && ldconfig

# PulseAudio server.
ENV PULSE_SERVER /run/pulse/native

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["utox"]
