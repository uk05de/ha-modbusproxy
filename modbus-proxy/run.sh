#!/usr/bin/with-contenv bashio

set +x

# Create main config
CONFIG_HOST=$(bashio::config 'upstreamhost')
CONFIG_PORT=$(bashio::config 'upstreamport')
CONFIG_LISTENPORT=$(bashio::config 'listenport')
CONFIG_TIMEOUT=$(bashio::config 'timeout')
CONFIG_CONNECTIONTIME=$(bashio::config 'connection_time')
CONFIG_LOGLEVEL=$(bashio::config 'loglevel')

# Create second Config
CONFIG_HOST2=$(bashio::config 'upstreamhost2')
CONFIG_PORT2=$(bashio::config 'upstreamport2')
CONFIG_LISTENPORT2=$(bashio::config 'listenport2')
CONFIG_TIMEOUT2=$(bashio::config 'timeout2')
CONFIG_CONNECTIONTIME2=$(bashio::config 'connection_time2')

# Create third Config
CONFIG_HOST3=$(bashio::config 'upstreamhost3')
CONFIG_PORT3=$(bashio::config 'upstreamport3')
CONFIG_LISTENPORT3=$(bashio::config 'listenport3')
CONFIG_TIMEOUT3=$(bashio::config 'timeout3')
CONFIG_CONNECTIONTIME3=$(bashio::config 'connection_time3')

echo "Preparing to run modbus-proxy"
echo "Upstream: $CONFIG_HOST:$CONFIG_PORT"
echo "Listen: $CONFIG_LISTENPORT"
echo "Timeout: $CONFIG_TIMEOUT"
echo "Connection Time: $CONFIG_CONNECTIONTIME"
echo "Loglevel: $CONFIG_LOGLEVEL"

echo "Upstream 2: $CONFIG_HOST2:$CONFIG_PORT2"
echo "Listen 2: $CONFIG_LISTENPORT2"
echo "Timeout 2: $CONFIG_TIMEOUT2"
echo "Connection Time 2: $CONFIG_CONNECTIONTIME2"

echo "Upstream 3: $CONFIG_HOST3:$CONFIG_PORT3"
echo "Listen 3: $CONFIG_LISTENPORT3"
echo "Timeout 3: $CONFIG_TIMEOUT3"
echo "Connection Time 3: $CONFIG_CONNECTIONTIME3"


sed -i "s/__HOST__/${CONFIG_HOST}/g" ./modbus.config.yaml
sed -i "s/__PORT__/${CONFIG_PORT}/g" ./modbus.config.yaml
sed -i "s/__LISTENPORT__/${CONFIG_LISTENPORT}/g" ./modbus.config.yaml
sed -i "s/__TIMEOUT__/${CONFIG_TIMEOUT}/g" ./modbus.config.yaml
sed -i "s/__CONNECTIONTIME__/${CONFIG_CONNECTIONTIME}/g" ./modbus.config.yaml
sed -i "s/__LOGLEVEL__/${CONFIG_LOGLEVEL}/g" ./modbus.config.yaml


sed -i "s/__HOST2__/${CONFIG_HOST2}/g" ./modbus.config.yaml
sed -i "s/__PORT2__/${CONFIG_PORT2}/g" ./modbus.config.yaml
sed -i "s/__LISTENPORT2__/${CONFIG_LISTENPORT2}/g" ./modbus.config.yaml
sed -i "s/__TIMEOUT2__/${CONFIG_TIMEOUT2}/g" ./modbus.config.yaml
sed -i "s/__CONNECTIONTIME2__/${CONFIG_CONNECTIONTIME2}/g" ./modbus.config.yaml


sed -i "s/__HOST3__/${CONFIG_HOST3}/g" ./modbus.config.yaml
sed -i "s/__PORT3__/${CONFIG_PORT3}/g" ./modbus.config.yaml
sed -i "s/__LISTENPORT3__/${CONFIG_LISTENPORT3}/g" ./modbus.config.yaml
sed -i "s/__TIMEOUT3__/${CONFIG_TIMEOUT3}/g" ./modbus.config.yaml
sed -i "s/__CONNECTIONTIME3__/${CONFIG_CONNECTIONTIME3}/g" ./modbus.config.yaml


echo "Generated Config"
cat ./modbus.config.yaml

if [ -f "./venv/bin/activate" ] ; then
    source ./venv/bin/activate
fi
modbus-proxy -c ./modbus.config.yaml

