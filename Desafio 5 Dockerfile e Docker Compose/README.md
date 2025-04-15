# Dockerfile e docker-compose

## Explicando o arquivo Dockerfile

### Utiliza-se da imagem Alpine aonde é uma versão do Node.js
```bash
FROM node:alpine
```
### Definie o /app como diretorio padrão
```bash
WORKDIR /app
```
### Copia e faz a instalação das dependencias do package.json
```bash
COPY package*.json ./
```
### Faz a copia dos arquivos que estão na pasta aonde o Dockerfile está sendo rodado e copia para o /app
```bash
COPY . .
```
### Expõe a porta 3000
```bash
EXPOSE 3000
```
### Quando a aplicação iniciar, executa o comando npm install
```bash
CMD ["npm", "start"]
```

## Explicando o arquivo Docker Compose

### No "service" é aonde definimos os serviços, no caso app e mysql
### App
### A imagem desse serviço será construida a partir de um Dockerfile que está no diretório atual
```bash
build: .
```
### Aqui é feito o mapeamento da porta 3000 para que possa ser acessada do computador
```bash
- "3000:3000"
```
### O environment define as variáveis que serão utilizadas na aplicação para se conectar ao banco de dados
```bash
environment:
      - DB_HOST=mysql
      - DB_PORT=3306
      - DB_USER=root
      - DB_PASSWORD=senha_root
      - DB_NAME=endpoint-do-banco
```
### A seguir, configuramos o serviço app seja depende do serviço mysql, isso faz com que o mysql seja iniciado antes do conteiner de aplicação
```bash
    depends_on:
      - mysql
```
### Mysql
### Utilizamos a imagem 8.0 do Mysql
```bash
    image: mysql:8.0
```
### Variáveis que serão usadas no Mysql
```bash
    environment:
      - MYSQL_ROOT_PASSWORD=senha_root
      - MYSQL_DATABASE=nome_do_banco
```
### Configura a porta 3306 para permitir acesso do computador
```bash
    ports:
      - "3306:3306"
```