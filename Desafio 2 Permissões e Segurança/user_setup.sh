#!/bin/bash

# Variáveis
USERNAME="devops_user"
DIRECTORY="/home/$USERNAME/restricted_data"
SSH_KEY_PATH="/home/$USERNAME/.ssh/authorized_keys"

sudo mkdir -p "$DIRECTORY"
sudo chown "$USERNAME:$USERNAME" "$DIRECTORY"
sudo chmod 700 "$DIRECTORY"
echo "Diretório $DIRECTORY criado com permissões restritas."

sudo usermod -aG sudo "$USERNAME"
echo "Usuário $USERNAME adicionado ao grupo sudo."

sudo mkdir -p "/home/$USERNAME/.ssh"
sudo touch "$SSH_KEY_PATH"
sudo chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
sudo chmod 700 "/home/$USERNAME/.ssh"
sudo chmod 600 "$SSH_KEY_PATH"

if ! grep -q "^PasswordAuthentication no" /etc/ssh/sshd_config; then
    echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config
    sudo systemctl restart sshd
fi

echo "Acesso SSH para $USERNAME configurado apenas via chave pública."
echo "Adicione a chave pública do usuário em $SSH_KEY_PATH para permitir o acesso."