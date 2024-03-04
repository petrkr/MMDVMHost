FROM alpine as builder

RUN apk add --update --no-cache \
    cmake \
    make \
    g++ \
    git \
    libsamplerate-dev \
    linux-headers \
  && rm -rf /var/cache/apk/*

ADD ./ /MMDVMHost
WORKDIR /MMDVMHost
RUN make

FROM alpine

RUN apk add --update --no-cache libstdc++ libsamplerate && \
    rm -rf /var/cache/apk/*

WORKDIR /MMDVMHost

COPY --from=builder /MMDVMHost/MMDVMHost /usr/local/bin/MMDVMHost
ADD MMDVM.ini /MMDVMHost/MMDVM.ini


CMD ["MMDVMHost", "/MMDVMHost/MMDVM.ini"]

