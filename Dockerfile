FROM cmusei/fixbuf:2 AS build
LABEL maintainer="maheckathorn@cert.org"

ARG SILK_VERSION=3.23.1

# Pre-reqs:
# curl for downloading
# build-essentials for build tools
# ca-certs to download https
# 
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
        pkg-config \
        ca-certificates \
        libglib2.0-dev \
        libssl-dev \
        liblzo2-dev \
        libpcap-dev \
        libsnappy-dev \
        && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

WORKDIR /netsa

RUN curl https://tools.netsa.cert.org/releases/silk-$SILK_VERSION.tar.gz | \
        tar -xz && cd silk-* && \
        ./configure --prefix=/netsa \
        --enable-data-rootdir=/data/ \
        --enable-ipv6 \
        --with-libfixbuf=/netsa/lib/pkgconfig \
        --disable-packing-tools && \
        make && \
        make install && \
        cd ../ && rm -rf silk-$SILK_VERSION

FROM debian:11-slim
LABEL maintainer="maheckathorn@cert.org"

RUN apt-get update && apt-get install -y --no-install-recommends \
        liblzo2-2 \
        libsnappy1v5 \
        libpcap0.8 \
        zlib1g \
        libgnutls30 \
        python3 \
        libglib2.0-0 && apt-get clean && \
        rm -rf /var/lib/apt/lists/*

ENV PATH=$PATH:/netsa/bin

COPY --from=build /netsa/ /netsa/