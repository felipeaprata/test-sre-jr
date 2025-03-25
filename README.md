# Seja bem vindo
Parabéns, você está fazendo parte de um teste para concorrer a uma vaga de SRE jr e se tornar um Printer.

# Regras
- Você terá até 24 horas para entregar o teste
- Terá que criar um repositório público no github e nos enviar apenas o link com o teste concluído para o email devops@printi.com.br
- Resolva os desafios criando os scripts mencionados
- Boa sorte

# Questões teóricas
1. Informe os comandos relacionados a procesos no linux que já utilizou na prática e o porque de cada um deles
2. Explique o significado completo da seguinte saída do comando ls -l (-rwxr-x--- 1 devops users 1024 Mar 25 12:00 script.sh)
3. Quais comandos você utiliza para avaliar possíveis problemas em cpu,memória,disco,rede em sistemas operacionais linux
4. Explique a diferença entre topologia física e topologia lógica de uma rede. Dê um exemplo de cada uma.
5. Quais são as principais características das topologias de rede estrela, anel e malha? Cite vantagens e desvantagens de cada uma.
6. Por que a topologia em malha é frequentemente utilizada em ambientes críticos, como data centers e infraestrutura de nuvem? Como ela contribui para a resiliência da rede?
7. Explique a diferença entre EC2, S3 e RDS na AWS. Para que tipo de aplicação cada um é mais adequado?
8. O que é um Auto Scaling Group (ASG) e como ele funciona em conjunto com um Load Balancer (ELB) para melhorar a disponibilidade de uma aplicação?
9. O que são IAM Roles e IAM Policies na AWS? Qual a diferença entre uma policy gerenciada pela AWS e uma policy personalizada (custom policy)?
10. O que é o shebang (#!) em um script shell? Dê um exemplo de como ele deve ser usado em um script Bash.
11. Explique a diferença entre os comandos if, case e while em um script shell. Dê um exemplo prático de uso para cada um.
12. Qual a diferença entre $1, $@ e $# em um Shell Script? Dê um exemplo de um script que utilize essas variáveis para manipular argumentos passados na linha de comando.
13. Explique como você faria um dump de um banco de dados Mysql e quais informações precisaria para isso.
14. Explique como faria o controle de acesso em um banco de dados Mysql e quais informações precisaria para essa demanda.

# Questões práticas

# Desafios Práticos de Linux para SRE Júnior

Este repositório contém três desafios práticos para avaliar competências técnicas em **Linux**.

---

## Desafio 1: Gerenciamento de Processos e Logs

### Tarefa  
- Crie um **script Bash** chamado `monitor_processes.sh` que:  
  - Liste os 5 processos que mais consomem **CPU** e os 5 que mais consomem **memória**.  
  - Registre essa informação em um arquivo de log chamado `process_monitor.log`.  
  - Faça o script rodar automaticamente a cada **5 minutos** usando o `cron`.  

### Entrega  
- Suba o script `monitor_processes.sh` no GitHub.  
- Adicione um arquivo `README.md` explicando como configurar o `cron` para rodar o script.  

---

## Desafio 2: Permissões e Segurança

### Tarefa  
- Crie um **script Bash** chamado `user_setup.sh` que:  
  - Crie um usuário chamado **devops_user**.  
  - Configure um diretório `/home/devops_user/restricted_data/` acessível **apenas pelo dono** do diretório.  
  - Adicione o usuário ao grupo `sudo` e restrinja seu acesso SSH apenas via **chave pública**.  

### Entrega  
- Suba o script `user_setup.sh` no GitHub.  
- Adicione um arquivo `README.md` explicando o que o script faz e como usá-lo.  

---

## Desafio 3: Monitoramento de Uso de Disco

### Tarefa  
- Crie um **script Bash** chamado `disk_usage_alert.sh` que:  
  - Verifique o uso do disco em **`/`**.  
  - Caso o uso esteja acima de **80%**, registre um alerta em um arquivo `disk_alert.log`.  
  - Caso o uso esteja abaixo de **80%**, registre uma mensagem informando que o disco está com espaço suficiente.  

### Entrega  
- Suba o script `disk_usage_alert.sh` no GitHub.
- Adicione um arquivo `README.md` explicando o script e mostrando um exemplo de saída do log.
