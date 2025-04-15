# Jenkinsfile

## Como Jenkins é algo novo para mim, achei o desafio díficil mesmo assim pesquisei uma base de como se cria esse arquivo e vou explica-lo abaixo

### pipeline {
Seria o ínicio da pipeline aonde tudo dentro {} representa o que deve e será feito. Dessa maneira, estamos criando uma sintaxe declarativa com uma maneira mais estruturada, aonde contém estrutura fixa e pré-definida. Outra sintaxe que pode ser usada, seri a sintaxe scriptada, aonde é uma maneira mais flexível, podendo usar loops, condições, funções.

### agent any
Mostra aonde o pipeline será executado. O "any" significa que será escolhido qualquer máquina disponível que esteja configurada no sistema.

### environment {
Lugar aonde definimos as variáveis que serão usadas dentro da pipeline

### APP_NAME = 'my-node-app'
Nome que será dado a aplicação

### stages {
Bloco aonde contém os estágios da pipeline. Aqui é aonde será configurado a parte de compilar o código, rodar testes ou fazer o deploy.

### stage('Build') {
Inicia um estágio chamado Build, aonde irá ser construido ou preparado a aplicação

### steps {
Seria os passos que serão executados

### sh 'npm install'
Executa o comando 'npm install' aonde instala as dependencias que estão no arquivo package.json

### Esse é apenas um arquivo bem básico do Jenkins, podemos ainda acrescentar mais stages como Test, Deploy, ainda sim deu pra ter uma noção de como funciona o arquivo e como é configurado.