from alpine as litestream

ENV LITESTREAM_VERSION=v0.3.13

ADD https://github.com/benbjohnson/litestream/releases/download/$LITESTREAM_VERSION/litestream-$LITESTREAM_VERSION-linux-amd64.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz

FROM nexryai/ariax:nightly

COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream
COPY litestream.yml /etc/litestream.yml
COPY run.sh ./

USER root
RUN mkdir /data && chown -R app:app /data && chmod +x run.sh

USER app
ENV DATABASE_PATH=file:/data/data.db

CMD ["/app/run.sh"]