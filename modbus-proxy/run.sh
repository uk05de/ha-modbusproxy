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
CONFIG_ENABLEHOST2=$(bashio::config 'enablehost2') 
CONFIG_HOST2=$(bashio::config 'upstreamhost2')
CONFIG_PORT2=$(bashio::config 'upstreamport2')
CONFIG_LISTENPORT2=$(bashio::config 'listenport2')
CONFIG_TIMEOUT2=$(bashio::config 'timeout2')
CONFIG_CONNECTIONTIME2=$(bashio::config 'connection_time2')

# Create third Config
CONFIG_ENABLEHOST3=$(bashio::config 'enablehost3') 
CONFIG_HOST3=$(bashio::config 'upstreamhost3')
CONFIG_PORT3=$(bashio::config 'upstreamport3')
CONFIG_LISTENPORT3=$(bashio::config 'listenport3')
CONFIG_TIMEOUT3=$(bashio::config 'timeout3')
CONFIG_CONNECTIONTIME3=$(bashio::config 'connection_time3')

echo "Preparing configuration to run modbus-proxy"
echo "Loglevel: $CONFIG_LOGLEVEL"
echo " "
echo "Preparing Upstream Host 1"
echo "Upstream: $CONFIG_HOST:$CONFIG_PORT"
echo "Listen: $CONFIG_LISTENPORT"
echo "Timeout: $CONFIG_TIMEOUT"
echo "Connection Time: $CONFIG_CONNECTIONTIME"

echo "devices:" > ./modbus.txt
echo "  - modbus:" >> ./modbus.txt
echo "      url: ${CONFIG_HOST}:${CONFIG_PORT} # device url (mandatory)" >> modbus.txt
echo "      timeout: ${CONFIG_TIMEOUT} # communication timeout (s) (optional, default: 10)" >> modbus.txt
echo "      connection_time: ${CONFIG_CONNECTIONTIME} # delay after connection (s) (optional, default: 0)" >> modbus.txt
echo "    listen:" >> modbus.txt
echo "      bind: 0:${CONFIG_LISTENPORT} # listening address (mandatory)" >> modbus.txt
# Create Filters
if [ "$(bashio::config 'filter')" ]; then
    echo "    filter:" >> modbus.txt
    echo "      allow:" >> modbus.txt
    for filter in $(bashio::config 'filter|keys'); do
        SLAVE=$(bashio::config "filter[${filter}].slave")
        FUNCTION=$(bashio::config "filter[${filter}].function")
        START=$(bashio::config "filter[${filter}].address_start")
        END=$(bashio::config "filter[${filter}].address_end")
        {
            echo "        - slave: ${SLAVE}"
            echo "          function: ${FUNCTION}"
            echo "          address_start: ${START}"
            echo "          address_end: ${END}"
        } >> modbus.txt
    done
fi

if [ $CONFIG_ENABLEHOST2 = true ]
then
    echo " "
    echo "Preparing Upstream Host 2"
    echo "Upstream 2: $CONFIG_HOST2:$CONFIG_PORT2"
    echo "Listen 2: $CONFIG_LISTENPORT2"
    echo "Timeout 2: $CONFIG_TIMEOUT2"
    echo "Connection Time 2: $CONFIG_CONNECTIONTIME2"
    echo "Filter 2: $CONFIG_FILTER2"

    echo "  - modbus:" >> ./modbus.txt
    echo "      url: ${CONFIG_HOST2}:${CONFIG_PORT2} # device url (mandatory)" >> modbus.txt
    echo "      timeout: ${CONFIG_TIMEOUT2} # communication timeout (s) (optional, default: 10)" >> modbus.txt
    echo "      connection_time: ${CONFIG_CONNECTIONTIME2} # delay after connection (s) (optional, default: 0)" >> modbus.txt
    echo "    listen:" >> modbus.txt
    echo "      bind: 0:${CONFIG_LISTENPORT2} # listening address (mandatory)" >> modbus.txt
    # Create Filters2
    if [ "$(bashio::config 'filter2')" ]; then
        echo "    filter:" >> modbus.txt
        echo "      allow:" >> modbus.txt
        for filter in $(bashio::config 'filter2|keys'); do
            SLAVE=$(bashio::config "filter2[${filter}].slave")
            FUNCTION=$(bashio::config "filter2[${filter}].function")
            START=$(bashio::config "filter2[${filter}].address_start")
            END=$(bashio::config "filter2[${filter}].address_end")
            {
                echo "        - slave: ${SLAVE}"
                echo "          function: ${FUNCTION}"
                echo "          address_start: ${START}"
                echo "          address_end: ${END}"
            } >> modbus.txt
        done
    fi
fi

if [ $CONFIG_ENABLEHOST3 = true ] 
then
    echo " "
    echo "Preparing Upstream Host 3"
    echo "Upstream 3: $CONFIG_HOST3:$CONFIG_PORT3"
    echo "Listen 3: $CONFIG_LISTENPORT3"
    echo "Timeout 3: $CONFIG_TIMEOUT3"
    echo "Connection Time 3: $CONFIG_CONNECTIONTIME3"
    echo "Filter 3: $CONFIG_FILTER3"

    echo "  - modbus:" >> ./modbus.txt
    echo "      url: ${CONFIG_HOST3}:${CONFIG_PORT3} # device url (mandatory)" >> modbus.txt
    echo "      timeout: ${CONFIG_TIMEOUT3} # communication timeout (s) (optional, default: 10)" >> modbus.txt
    echo "      connection_time: ${CONFIG_CONNECTIONTIME3} # delay after connection (s) (optional, default: 0)" >> modbus.txt
    echo "    listen:" >> modbus.txt
    echo "      bind: 0:${CONFIG_LISTENPORT3} # listening address (mandatory)" >> modbus.txt
    # Create Filters3
    if [ "$(bashio::config 'filter3')" ]; then
        echo "    filter:" >> modbus.txt
        echo "      allow:" >> modbus.txt
        for filter in $(bashio::config 'filter3|keys'); do
            SLAVE=$(bashio::config "filter3[${filter}].slave")
            FUNCTION=$(bashio::config "filter3[${filter}].function")
            START=$(bashio::config "filter3[${filter}].address_start")
            END=$(bashio::config "filter3[${filter}].address_end")
            {
                echo "        - slave: ${SLAVE}"
                echo "          function: ${FUNCTION}"
                echo "          address_start: ${START}"
                echo "          address_end: ${END}"
            } >> modbus.txt
        done
    fi
fi


echo "logging:" >> modbus.txt
echo "  version: 1" >> modbus.txt
echo "  formatters: " >> modbus.txt
echo "    standard:" >> modbus.txt
echo '      format: "%(asctime)s %(levelname)8s %(name)s: %(message)s"' >> modbus.txt
echo "  handlers:" >> modbus.txt
echo "    console:" >> modbus.txt
echo "      class: logging.StreamHandler" >> modbus.txt
echo "      formatter: standard" >> modbus.txt
echo "  root:" >> modbus.txt
echo "    handlers: ['console']" >> modbus.txt
echo "    level: ${CONFIG_LOGLEVEL}" >> modbus.txt


echo "Generated Config:"
cat modbus.txt > ./modbus.config.yaml
cat ./modbus.config.yaml

if [ -f "./venv/bin/activate" ] ; then
    source ./venv/bin/activate
fi
modbus-proxy -c ./modbus.config.yaml

