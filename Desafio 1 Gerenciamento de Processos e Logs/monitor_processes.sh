#!/bin/bash

# Caminho para o arquivo de log
LOG_FILE="process_monitor.log"

# Adiciona a data e hora atual ao log
echo "Monitoramento em $(date)" >> $LOG_FILE

# Lista os 5 processos que mais consomem CPU
echo "Top 5 CPU:" >> $LOG_FILE
ps aux --sort=-%cpu | head -n 5 >> $LOG_FILE

# Adiciona uma linha em branco para separação
echo "" >> $LOG_FILE

# Lista os 5 processos que mais consomem memória
echo "Top 5 Memória:" >> $LOG_FILE
ps aux --sort=-%mem | head -n 5 >> $LOG_FILE
