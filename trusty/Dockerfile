FROM ubuntu:trusty

LABEL \
  maintainer="Peter Evans <mail@peterevans.dev>" \
  org.opencontainers.image.title="osrm-backend:trusty" \
  org.opencontainers.image.description="Docker image for the Open Source Routing Machine (OSRM) osrm-backend." \
  org.opencontainers.image.authors="rollbrettler <rollbrettler@googlemail.com>, Peter Evans <mail@peterevans.dev>" \
  org.opencontainers.image.url="https://github.com/peter-evans/osrm-backend-docker" \
  org.opencontainers.image.vendor="https://peterevans.dev" \
  org.opencontainers.image.licenses="MIT"

ENV OSRM_VERSION 5.22.0

# Let the container know that there is no TTY
ARG DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get -y update \
 && apt-get install -y software-properties-common \
 && add-apt-repository ppa:ubuntu-toolchain-r/test \
 && apt-get update \
 && apt-get install -y -qq --no-install-recommends \
    g++-6 \
    gcc-6 \
    build-essential \
    cmake3 \
    curl \
    ca-certificates \
    libbz2-dev \
    libstxxl-dev \
    libstxxl1 \
    libxml2-dev \
    libzip-dev \
    libboost-all-dev \
    lua5.2 \
    liblua5.2-dev \
    libtbb-dev \
    libluabind-dev \
    pkg-config \
    gcc \
    python-dev \
    python-setuptools \
 && apt-get clean \
 && easy_install -U pip \
 && pip install -U crcmod \ 
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/*

ENV CPP=cpp-6
ENV CC=gcc-6
ENV CXX=g++-6
ENV AR=gcc-ar-4.9
ENV NM=gcc-nm-4.9
ENV RANLIB=gcc-ranlib-4.9

# Build osrm-backend
RUN mkdir /osrm-src \
 && cd /osrm-src \
 && curl --silent -L https://github.com/Project-OSRM/osrm-backend/archive/v$OSRM_VERSION.tar.gz -o v$OSRM_VERSION.tar.gz \
 && tar xzf v$OSRM_VERSION.tar.gz \
 && cd osrm-backend-$OSRM_VERSION \
 && mkdir build \
 && cd build \
 && cmake .. -DCMAKE_BUILD_TYPE=Release \
 && cmake --build . \
 && cmake --build . --target install \
 && mkdir /osrm-data \
 && mkdir /osrm-profiles \
 && cp -r /osrm-src/osrm-backend-$OSRM_VERSION/profiles/* /osrm-profiles \
 && rm -rf /osrm-src

# Set the entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5000
