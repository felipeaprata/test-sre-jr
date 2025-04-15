# Explicando o Script

### Criação do arquivo
LOG_FILE="disk_alert.log"

### Busca a porcentagem de uso do disco na raiz e joga em uma variável
df -h /: Mostra as informações do disco na raiz
grep '/': Filtra a linha da raiz
awk '{print $5}': Extrai a coluna que corresponde a porcentagem de uso
sed 's/%//': Retira o % para que fique apenas o numero
USAGE=$(df -h / | grep '/' | awk '{print $5}' | sed 's/%//')

### Verifica se o uso está acima de 80 e grava a informação no arquivo disk_alert.log
"$USAGE" -gt 80: Verifica se o valor da variável é maior que 80
if [ "$USAGE" -gt 80 ]; then
    echo "$(date): ALERTA: Uso do disco em / está em $USAGE%, acima de 80%." >> $LOG_FILE
else
    echo "$(date): INFO: Uso do disco em / está em $USAGE%, abaixo de 80%." >> $LOG_FILE
fi