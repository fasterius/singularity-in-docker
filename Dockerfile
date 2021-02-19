FROM golang:1.16.0-alpine3.13

WORKDIR $GOPATH/src/github.com/sylabs
RUN apk update \
    && apk add --no-cache ca-certificates \
                          gawk \
                          gcc \
                          git \
                          libc-dev \
                          linux-headers \
                          libressl-dev \
                          libuuid \
                          libseccomp-dev \
                          make \
                          openssl \
                          squashfs-tools \
                          tzdata \
                          util-linux-dev \
                          wget

RUN export VERSION=3.7.1 \
    && wget https://github.com/sylabs/singularity/releases/download/v$VERSION/singularity-$VERSION.tar.gz \
    && tar -xzf singularity-$VERSION.tar.gz \
    && cd singularity \
    && ./mconfig -p /usr/local/singularity \
    && cd builddir \
    && make \
    && make install \
    && cp /usr/share/zoneinfo/UTC /etc/localtime

WORKDIR /work
ENTRYPOINT ["/usr/local/singularity/bin/singularity"]
