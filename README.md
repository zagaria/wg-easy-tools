# wg-easy-tools
Useful tools for [WG Easy](https://github.com/wg-easy/wg-easy)

## Metrics

This is a Telegraf image with a configuration to parse data from the WG Easy API and send it to an InfluxDB endpoint. 

Additionally, the Prometheus endpoint is enabled by default on port 9273."

## Watchdog

Some devices (such as routers) can't connect back to WG after a reboot. This can be fixed by disabling and enabling the client again in the WG Easy UI.

This image has a script to automate this action: if the client's last handshake time was over 300 seconds, the client will be automatically disabled and enabled back.