#!/usr/bin/env bash

show_dashboard_time() {
	sampler -c "${CONFIG_PATH}/sampler/time.yml"
}

show_dashboard_usage() {
	sampler -c "${CONFIG_PATH}/sampler/usage.yml"
}

show_dashboard_graphics() {
	sampler -c "${CONFIG_PATH}/sampler/graphics.yml"
}

