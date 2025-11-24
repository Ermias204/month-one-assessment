#!/bin/bash
# Update system and install PostgreSQL
yum update -y
amazon-linux-extras enable postgresql14
yum install -y postgresql-server postgresql-contrib

# Initialize PostgreSQL database
postgresql-setup initdb

# Start and enable PostgreSQL
systemctl start postgresql
systemctl enable postgresql

# Create database and user
sudo -u postgres psql -c "CREATE DATABASE techcorp_app;"
sudo -u postgres psql -c "CREATE USER techcorp_user WITH PASSWORD 'passwd';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE techcorp_app TO techcorp_user;"

# Configure PostgreSQL to allow connections
echo "host techcorp_app techcorp_user 10.0.0.0/16 md5" >> /var/lib/pgsql/data/pg_hba.conf
echo "listen_addresses = '*'" >> /var/lib/pgsql/data/postgresql.conf

# Restart PostgreSQL to apply changes
systemctl restart postgresql

# Install SSH server and configure password authentication
yum install -y openssh-server
systemctl start sshd
systemctl enable sshd

# Create a user for SSH access and set password
useradd -m -s /bin/bash techcorp-user
echo "techcorp-user:passwd" | chpasswd

# Configure SSH to allow password authentication
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

# Add techcorp-user to sudoers
echo "techcorp-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
