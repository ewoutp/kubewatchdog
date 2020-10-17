package cmd

import (
	"context"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/rs/zerolog"
	"github.com/spf13/cobra"
	corev1 "k8s.io/api/core/v1"
	"k8s.io/client-go/kubernetes/scheme"
	"sigs.k8s.io/controller-runtime/pkg/client"
	"sigs.k8s.io/controller-runtime/pkg/client/config"
)

var (
	// RootCmd is the root (and only) command of this service
	RootCmd = &cobra.Command{
		Use:   "kubewatchdog",
		Short: "Kubernetes Watchdog",
		Run:   runRootCmd,
	}
	cliLog = zerolog.New(zerolog.NewConsoleWriter())
	flags  struct {
		PodName            string
		PodNamespace       string
		WatchdogPath       string
		UpdateInterval     time.Duration
		InspectionInterval time.Duration
		MaxErrors          int
	}
)

func init() {
	f := RootCmd.Flags()
	f.StringVar(&flags.PodName, "pod", "", "Name of pod to monitor")
	f.StringVar(&flags.PodNamespace, "namespace", "", "Namespace of pod to monitor")
	f.StringVar(&flags.WatchdogPath, "watchdog", "/dev/watchdog", "Filename of watchdog device")
	f.DurationVar(&flags.UpdateInterval, "update-interval", time.Second*5, "Interval between watchdog writes")
	f.DurationVar(&flags.InspectionInterval, "inspection-interval", time.Second*15, "Interval between inspecting Kubernetes connection")
	f.IntVar(&flags.MaxErrors, "max-errors", 3, "Number of recent errors before giving up")
}

func runRootCmd(cmd *cobra.Command, args []string) {
	// Prepare kubernetes client
	scheme := scheme.Scheme
	config, err := config.GetConfig()
	if err != nil {
		cliLog.Fatal().Err(err).Msg("Failed to get kubernetes config")
	}
	k8sClient, err := client.New(config, client.Options{Scheme: scheme})
	if err != nil {
		cliLog.Fatal().Err(err).Msg("Failed to create kubernetes client")
	}

	// Run monitoring
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	connectionGood := make(chan bool)
	go monitorKubernetes(ctx, cliLog, k8sClient, flags.PodName, flags.PodNamespace, flags.InspectionInterval, connectionGood)
	go updateWatchdog(ctx, cliLog, flags.WatchdogPath, flags.UpdateInterval, flags.MaxErrors, connectionGood)

	// Wait until termination signal
	done := make(chan os.Signal, 1)
	signal.Notify(done, os.Interrupt, syscall.SIGINT, syscall.SIGTERM)

	<-done
}

// monitorKubernetes inspects the kubernetes connection and reports on
// it over the given channel.
func monitorKubernetes(ctx context.Context, log zerolog.Logger, c client.Client,
	podName, podNamespace string, interval time.Duration, connectionGood chan bool) {
	log = log.With().Str("name", podName).Str("namespace", podNamespace).Logger()
	for {
		select {
		case <-ctx.Done():
			// Context canceled
			return
		case <-time.After(interval):
			// Run test
		}
		var pod corev1.Pod
		key := client.ObjectKey{Name: podName, Namespace: podNamespace}
		if err := c.Get(ctx, key, &pod); err != nil {
			log.Debug().Err(err).Msg("Failed to get pod")
			connectionGood <- false
		} else {
			connectionGood <- true
		}
	}
}

// updateWatchdog keeps updating the watchdog until the connection has been not good for too long.
func updateWatchdog(ctx context.Context, log zerolog.Logger, watchdogPath string,
	interval time.Duration, maxErrors int, connectionGood <-chan bool) {
	log = log.With().Str("path", watchdogPath).Logger()
	wdog, err := os.Create(watchdogPath)
	if err != nil {
		log.Error().Err(err).Msg("Failed to access watchdog")
		return
	}
	defer wdog.Close()

	nextTrigger := time.Now().Add(time.Second)
	recentErrors := 0
	for {
		select {
		case <-ctx.Done():
			// Context canceled
			return
		case good := <-connectionGood:
			if good {
				if recentErrors > 0 {
					recentErrors = 0
					log.Info().Msg("Connection good")
				}
			} else {
				recentErrors++
				if recentErrors > maxErrors {
					log.Error().Int("recentErrors", recentErrors).Msg("Too many recent errors, terminating")
					return
				}
				log.Warn().Int("recentErrors", recentErrors).Msg("Connection not good")

			}
		case <-time.After(time.Until(nextTrigger)):
			if _, err := wdog.WriteString("WATCH, DOG!\n"); err != nil {
				log.Error().Err(err).Msg("Failed to write to watchdog")
				return
			}
			nextTrigger = time.Now().Add(interval)
		}
	}
}
