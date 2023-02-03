FROM ubuntu:latest as builder
RUN apt update && \
    apt install -y --no-install-recommends curl build-essential g++ && \
    rm -rf /var/lib/apt/lists/* && \
    curl http://www.devin.com/lookbusy/download/lookbusy-1.4.tar.gz | tar xvz && \
    cd lookbusy-1.4 && \
    ./configure && \
    make && \
    make install && \
    apt remove -y curl build-essential g++ && \
    apt autoremove --purge -y && \
    cd .. && \
    rm -rf lookbusy-1.4

FROM ubuntu:latest as nostr
ENV LANG=C.UTF-8 \
    MIN=15 \
    MAX=50 \
    MEM=4GB
COPY --from=builder /usr/local/bin/lookbusy /usr/local/bin/nostr
ENTRYPOINT ["/bin/sh","-lc"]
CMD ["nostr -c $MIN-$MAX -r curve -m $MEM -M 2000"]
