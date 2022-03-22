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

RUN export VERSION=3.9.6 \
    && wget https://github.com/sylabs/singularity/releases/download/v$VERSION/singularity-ce-$VERSION.tar.gz \
    && tar -xzf singularity-ce-$VERSION.tar.gz && mv singularity-ce-$VERSION singularity \
    && cd singularity \
    && ./mconfig -p /usr/local/singularity \
    && cd builddir \
    && make \
    && make install \
    && cp /usr/share/zoneinfo/UTC /etc/localtime

WORKDIR /work
ENTRYPOINT ["/usr/local/singularity/bin/singularity"]
