# Pull base image
FROM arm64v8/ubuntu:18.04
MAINTAINER Tanmay Bangalore <tanmaybangalore@gmail.com>

# Setup external package-sources
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn
ENV INFLUX_VER=1.5.4
RUN apt-get update && apt-get install -y \
    wget ca-certificates \
    --no-install-recommends && \
    cd /tmp && wget https://dl.influxdata.com/influxdb/releases/influxdb_${INFLUX_VER}_arm64.deb && \
    dpkg -i influxdb_${INFLUX_VER}_arm64.deb && \
    rm -rf /var/lib/apt/lists/*

COPY influxdb.conf /etc/influxdb/influxdb.conf

ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV PRE_CREATE_DB **None**

# HTTP API
EXPOSE 8086

VOLUME ["/data"]

CMD ["/run.sh"]

