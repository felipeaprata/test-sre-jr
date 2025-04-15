# Script Bash que lista os 5 processos que mais consomen CPU e os 5 que mais consomem memória

## Explicando o Script:

Primeiro foi criado a variável LOG_FiLE para que não haja necessidade de colocar "process_monitor.log" o tempo todo
```bash
LOG_FILE="process_monitor.log"
```
Em seguida colocamos a data e horario que o log for rodado na primeira linha
```bash
echo "Monitoramento em $(date)" >> $LOG_FILE
```
Criamos uma linha no script para sabermos do que se trata e depois fazemos a execução do comando aonde irá buscar os 5 processos que mais usam CPU
```bash
echo "Top 5 CPU:" >> $LOG_FILE
ps aux --sort=-%cpu | head -n 5 >> $LOG_FILE
```
Usado o comando a seguir para pular uma linha para que seja mais facil de visualizar
```bash
echo "" >> $LOG_FILE
```
Por últimos, mesma coisa que no CPU mas agora para buscar os 5 processos que mais usam memória.
```bash
echo "Top 5 Memória:" >> $LOG_FILE
ps aux --sort=-%mem | head -n 5 >> $LOG_FILE
```
## Configuração da Cron

Abrimos o arquivo do cron:
```bash
crontab -e
```
Acrescentamos a seguinte linha no final do arquivo para rodar o script a cada 5 minutos
```bash
*/5 * * * * /home/ubuntu/Documents/monitor_processes.sh
```
