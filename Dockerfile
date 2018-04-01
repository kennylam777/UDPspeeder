FROM alpine:3.6 as builder

WORKDIR /
RUN apk add --no-cache git  build-base linux-headers

COPY . udpspeeder

RUN cd udpspeeder && \
 make all

FROM alpine:3.6
RUN apk add --no-cache libstdc++ iptables
COPY --from=builder /udpspeeder/speederv2 /bin/speederv2
ENTRYPOINT [ "/bin/udpspeeder" ]
