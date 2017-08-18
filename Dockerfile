FROM zabbix/zabbix-server-mysql
LABEL maintainer "Dmytro Kanarskyi <dmitriy.kanarskiy@gmail.com>"

ARG APT_FLAGS_COMMON="-qq -y"
ARG APT_FLAGS_PERSISTANT="${APT_FLAGS_COMMON} --no-install-recommends"
ARG APT_FLAGS_DEV="${APT_FLAGS_COMMON} --no-install-recommends"
RUN whereis apt-get
RUN apt-get update && apt-get -y install libwww-perl libjson-xs-perl 1>/dev/null
RUN apt-get ${APT_FLAGS_COMMON} autoremove
RUN apt-get ${APT_FLAGS_COMMON} clean
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /etc/appdir/

COPY ./zabbix-notify-master/* etc/appdir/
WORKDIR etc/appdir/
RUN perl Makefile.PL INSTALLSITESCRIPT=/usr/lib/zabbix/alertscripts && make install