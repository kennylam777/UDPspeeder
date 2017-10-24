FROM alpine:3.6 as builder

RUN apk add --no-cache git build-base linux-headers
ADD . /UDPspeeder
WORKDIR /UDPspeeder
RUN make -j

FROM alpine:3.6
RUN apk add --no-cache libstdc++ iptables
COPY --from=builder /UDPspeeder/speederv2 /bin/
ENTRYPOINT [ "/bin/speederv2" ]
