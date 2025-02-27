FROM litestream/litestream:0.3.13 AS litestream

FROM ghcr.io/nexryai/aria:latest

COPY --from=litestream /usr/local/bin/litestream /usr/local/bin/litestream
COPY litestream.yml /etc/litestream.yml
COPY run.sh ./

USER root
RUN mkdir /data && chown -R app:app /data && chmod +x run.sh

USER app
ENV DATABASE_PATH=file:/data/data.db

CMD ["/app/run.sh"]