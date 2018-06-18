# convox-utils
Maintenace utilities for convox racks

## Install
This is meant to be a convox app (gen2).  Create this app, set the environment and deploy the app.

## Global Environment

* API_URL: https://YOUR_RACK_HOSTNAME/instances
* API_KEY: Convox API key  (base64 of rack password?)

## Timers

### instance-restarter

Nightly restarts a the single oldest EC2 instance.  This is born from a problem I experience where my dockerd CPU usage gradually increases over time.

* INSTANCE_AGE_DAYS: number of days before instances are eligible for termination.  Default: 3.
