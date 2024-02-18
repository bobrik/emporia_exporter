# Emporia Vue Prometheus Exporter

This is a prometheus exporter for [Emporia](https://emporiaenergy.com) products,
mainly for the Emporia Vue energy monitor used by the author:

![emporia vue](https://shop.emporiaenergy.com/cdn/shop/products/Vue-Utility-Connect-2_d8ddfcf6-1348-4c23-aeea-4398fe77faa7_1024x1024@2x.jpg?v=1696978145)

## Usage

1. Clone the repo.

2. Build it:

```
go build -v -o emporia_exporter .
```

3. Run it:

```
EMPORIA_USERNAME=xxx EMPORIA_PASSWORD=yyy ./emporia_exporter -addr 127.0.0.1:12345
```

4. Check it:

```
$ curl -s http://127.0.0.1:12345/metrics
# HELP emporia_usage_watts Current usage in watts
# TYPE emporia_usage_watts gauge
emporia_usage_watts{channel_name="Main",device_name="Meter"} -33.9388
```
