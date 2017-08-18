FROM zabbix/zabbix-server-mysql
RUN apt-get install -y mc
ENTRYPOINT ["/bin/bash"]