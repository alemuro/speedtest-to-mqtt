# Speedtest to Mqtt

Execute speedtest-cli test and send results to MQTT.

I developed this script to send speedtest data from different Pi nodes to a centralized MQTT. Then, I get this information from a home assistant instance.

## Install

Copy `config.json.sample` file to `config.json` and fill all fields. Then execute `make install`. This will install `jq`, `speedtest-cli` and `mqtt-cli`. 

This will configure cron to execute ths script every 15 minutes.

## Contributors

All contributors are welcome :tada: !!