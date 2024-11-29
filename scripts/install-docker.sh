echo "Installing Docker..."

# Vagrant default username
VAGRANT_USER=vagrant

# -------------------------------
# Docker installation
# -------------------------------

## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

## Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# -------------------------------
# Post run installation steps
# -------------------------------

## Add the 'docker' group if it doesn't already exist
if ! grep -q "^docker:" /etc/group; then
    echo "Creating 'docker' group..."
    sudo groupadd docker
else
    echo "Group 'docker' already exists."
fi

## Add the current user to the 'docker' group
echo "Adding $VAGRANT_USER user to 'docker' group..."
sudo usermod -aG docker $VAGRANT_USER

## Activate the new group for the current session
echo "Activating the new 'docker' group..."
newgrp docker || echo "Failed to activate the new 'docker' group. Please restart your session to apply changes."
