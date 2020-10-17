# Kubernetes Watchdog

Kubernetes Watchdog tracks a Kubernetes connection and updates a watchdog
file as long as the connection is reasonable ok.

It is intended to automatically reboot tiny (and somewhat unstable) ARM devices
running in an Kubernetes home automation cluster.
