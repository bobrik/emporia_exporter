package main

import (
	"flag"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/cnovak/emporia"
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
	"golang.org/x/exp/maps"
)

func main() {
	log.SetFlags(log.Flags() &^ (log.Ldate | log.Ltime))

	addr := flag.String("addr", "", "address to listen on")
	flag.Parse()

	if *addr == "" {
		flag.PrintDefaults()
		os.Exit(1)
	}

	username := os.Getenv("EMPORIA_USERNAME")
	password := os.Getenv("EMPORIA_PASSWORD")

	if username == "" || password == "" {
		log.Printf("EMPORIA_USERNAME and EMPORIA_PASSWORD must be set")
		os.Exit(1)
	}

	client, err := emporia.NewClient(username, password)
	if err != nil {
		log.Fatalf("Error creating emporia client: %v", err)
	}

	log.Printf("Successfully authenticated as %q", username)

	devicesResponse, err := client.GetDevices()
	if err != nil {
		log.Fatalf("Error getting emporia devices: %v", err)
	}

	devices := map[uint64]emporia.Device{}

	for _, device := range devicesResponse.Devices {
		devices[device.DeviceGID] = device
	}

	mux := http.ServeMux{}
	mux.HandleFunc("/metrics", func(w http.ResponseWriter, r *http.Request) {
		registry := prometheus.NewRegistry()

		usage := prometheus.NewGaugeVec(prometheus.GaugeOpts{
			Namespace: "emporia",
			Name:      "usage_watts",
			Help:      "Current usage in watts",
		}, []string{"device_name", "channel_name"})

		registry.MustRegister(usage)

		usages, err := client.GetDeviceListUsages(maps.Keys(devices), emporia.Second, emporia.KilowattHours, time.Now())
		if err != nil {
			log.Fatalf("Error getting device usages: %v", err)
		}

		for _, device := range usages.Devices {
			for _, channel := range device.ChannelUsages {
				usage.WithLabelValues(devices[device.DeviceGid].LocationProperties.DeviceName, channel.Name).Set(channel.Usage * 3600 * 1000)
			}
		}

		promhttp.HandlerFor(registry, promhttp.HandlerOpts{}).ServeHTTP(w, r)
	})

	log.Printf("Listening on %q for metrics", *addr)

	err = http.ListenAndServe(*addr, &mux)
	if err != nil {
		log.Fatalf("Error listening on %q: %v", *addr, err)
	}
}
