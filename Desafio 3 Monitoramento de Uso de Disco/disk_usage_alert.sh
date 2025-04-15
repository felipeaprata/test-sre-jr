#!/bin/bash

LOG_FILE="disk_alert.log"

USAGE=$(df -h / | grep '/' | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt 80 ]; then
    echo "$(date): ALERTA: Uso do disco em / está em $USAGE%, acima de 80%." >> $LOG_FILE
else
    echo "$(date): INFO: Uso do disco em / está em $USAGE%, abaixo de 80%." >> $LOG_FILE
fi
