#!/bin/bash

SPEEDTEST_FILE=/tmp/speedtest_result.json
USER=$(cat $(dirname $0)/config.json | jq -r '.USER')
PASSWORD=$(cat $(dirname $0)/config.json | jq -r '.PASSWORD')
HOST=$(cat $(dirname $0)/config.json | jq -r '.HOST')
PORT=$(cat $(dirname $0)/config.json | jq -r '.PORT')
SYSTEM=$(cat $(dirname $0)/config.json | jq -r '.SYSTEM')

echo -n "Executing speedtest-cli... "
/usr/local/bin/speedtest-cli --json > ${SPEEDTEST_FILE}
echo "OK"

download_bits=$(cat ${SPEEDTEST_FILE} | jq -r '.download')
upload_bits=$(cat ${SPEEDTEST_FILE} | jq -r '.upload')
ping=$(cat ${SPEEDTEST_FILE} | jq -r '.ping')

download_mbits=$(echo "scale=2; ${download_bits} / 1000 / 1000" | bc)
upload_mbits=$(echo "scale=2; ${upload_bits} / 1000 / 1000" | bc)

/usr/bin/mqtt-cli ${USER}:${PASSWORD}@${HOST}:${PORT} system/${SYSTEM}/speedtest/download ${download_mbits}
/usr/bin/mqtt-cli ${USER}:${PASSWORD}@${HOST}:${PORT} system/${SYSTEM}/speedtest/upload ${upload_mbits}
/usr/bin/mqtt-cli ${USER}:${PASSWORD}@${HOST}:${PORT} system/${SYSTEM}/speedtest/ping ${ping}

echo "download => ${download_mbits} Mbps"
echo "upload => ${upload_mbits} Mbps"
echo "ping => ${ping} ms"