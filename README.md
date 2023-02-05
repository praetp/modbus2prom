# modbus2prom
Example project to expose modbus data to prometheus

My SAJ Sununo 3K-M solar inverter did not come with a dongle to capture the data.
Therefore, I bought a cheap RS232 to USB converter to read in the data.
Only after I discovered this [document](https://github.com/wimb0/home-assistant-saj-modbus/blob/main/saj-plus-series-inverter-modbus-protocal.pdf),
describing the modbus protocol, I was able to get the data.
Then I wrote this small script to convert it into a Prometheus compatible format.
The output can be put in a Prometheus dropzone.

## Architecture
```
┌──────────────────┐                    ┌───────────────┐                   ┌───────────────┐      ┌────────────┐
│                  │                    │               │                   │               │      │            │
│   SAJ inverter   ├────────────────────┤  modbus2prom  ├──────────────────►│ node_exporter │◄─────┤ Prometheus │
│                  │  Modbus-over-RS232 │               │ Write .prom file  │               │Scrape│            │
└──────────────────┘                    └───────────────┘ for               └───────────────┘      └────────────┘
                                                          node_exporter
                                                          to filesystem
```