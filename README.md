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

---

## Desafio 4: Pipeline Declarativa no Jenkins para CI/CD

### Tarefa  
Crie um **Jenkinsfile** que implemente um **CI/CD** contendo os seguintes estágios:  

1. **Checkout**
2. **Build**
3. **Test**
4. **Code Quality**
5. **Package(empacotamento do artefato)**
6. **Deploy(um deploy simples em docker)**
   - Se for ambiente **não produção**, faça o deploy;
   - Se for **produção**, solicite uma autorização.

## Requisitos
- A app simples deve ser em Node.js
- Utilize pipelines declarativas
- Explique no próprio jenkinsfile caso você entenda que o time de SRE terá alguma dificuldade de entender pontos específicos
- Utilize variáveis de ambiente

---

## Desafio 5: Dockerfile e Docker Compose  

### Tarefa  
Crie um **Dockerfile** e um **docker-compose.yml** para uma aplicação simples em Node.js.

## Requisitos
1. **Dockerfile:**
   - Criar uma imagem baseada em **Alpine Linux**.
   - Instalar as dependências
   - Expor a porta necessária para rodar

2. **docker-compose.yml:**
   - Criar um serviço para a aplicação.
   - Criar um serviço de banco de dados **MySQL**
   - Configurar variáveis de ambiente para conexão ao banco de dados

3. **Execução:**
   - A aplicação deve ser iniciada corretamente com `docker-compose up -d`.

---

## Desafio 6: IaC AWS com Terraform  

### Tarefa  
Crie um projeto no Terraform que provisione a seguinte infraestrutura **AWS**

1. **Instância EC2**  
   - SO: **Amazon Linux 2**.  
   - Instalar e configurar um **nginx** para servir uma página estática com a mensagem `"Eu quero ser um Printer"`.
   - Expor a porta **80** para acesso público.

2. **Application Load Balancer (ALB)**  
   - Criar um **ALB** direcionando tráfego para a instância EC2

3. **Registro no Route 53**
   - Criar um domínio e registro fazendo apontamento para o ALB
   - O domínio pode ser simulado, sem necessidade de um domínio real
