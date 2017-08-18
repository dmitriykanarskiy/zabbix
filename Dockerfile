FROM zabbix/zabbix-server-mysql
LABEL maintainer "Dmytro Kanarskyi <dmitriy.kanarskiy@gmail.com>"

ARG APT_FLAGS_COMMON="-qq -y"
ARG APT_FLAGS_PERSISTANT="${APT_FLAGS_COMMON} --no-install-recommends"
ARG APT_FLAGS_DEV="${APT_FLAGS_COMMON} --no-install-recommends"

RUN apt-get ${APT_FLAGS_COMMON} update && \
    apt-get ${APT_FLAGS_PERSISTANT} install \
            libwww-perl \
            libjson-xs-perl >/dev/null && \
    apt-get ${APT_FLAGS_COMMON} autoremove && \
    apt-get ${APT_FLAGS_COMMON} clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/appdir/

COPY ./zabbix-notify-master/* etc/appdir/

WORKDIR etc/appdir/

RUN perl Makefile.PL INSTALLSITESCRIPT=/usr/lib/zabbix/alertscripts && make install

ENTRYPOINT ["/bin/bash"]