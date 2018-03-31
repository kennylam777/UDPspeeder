FROM alpine:3.6 as builder

WORKDIR /

COPY . udpspeeder
RUN apk add --no-cache git  build-base linux-headers && \
 cd udpspeeder && \
 make all

FROM alpine:3.6
RUN apk add --no-cache libstdc++ iptables
COPY --from=builder /udpspeeder/udpspeeder_all /bin/udpspeeder
ENTRYPOINT [ "/bin/udpspeeder" ]
