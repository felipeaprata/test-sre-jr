# Script de criação do usuário devops_user

## Explicação

Criação das variáveis para facilitar o processo
USERNAME="devops_user"
DIRECTORY="/home/$USERNAME/restricted_data"
SSH_KEY_PATH="/home/$USERNAME/.ssh/authorized_keys"

Cria o diretório "restricted_data" e concede as permissões necessárias
sudo mkdir -p "$DIRECTORY"
sudo chown "$USERNAME:$USERNAME" "$DIRECTORY"
sudo chmod 700 "$DIRECTORY"
echo "Diretório $DIRECTORY criado com permissões restritas."

Adiciona o usuário ao grupo sudo
sudo usermod -aG sudo "$USERNAME"
echo "Usuário $USERNAME adicionado ao grupo sudo."

Configura o acesso SSH para permitir acesso pelo chave publica, criando o diretório .ssh e o arquivo authorized_keys na home do usuário. Da as permissões apenas para o usuário.
sudo mkdir -p "/home/$USERNAME/.ssh"
sudo touch "$SSH_KEY_PATH"
sudo chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
sudo chmod 700 "/home/$USERNAME/.ssh"
sudo chmod 600 "$SSH_KEY_PATH"

Retira o acesso do login pela senha editando o arquivo sshd_config e reinicia o serviço
if ! grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config
    sudo systemctl restart sshd
fi

Texto de finalização do processo
echo "Acesso SSH para $USERNAME configurado apenas via chave pública."
echo "Adicione a chave pública do usuário em $SSH_KEY_PATH para permitir o acesso."

## Com usar

Criar uma arquivo e dar as permissões
chmod +x user_setup.sh

Execute o scritp
./user_setup.sh

For fim, editar o arquivo /home/devops_user/.ssh/authorized_keys para adicionar a chave pública.