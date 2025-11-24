#!/bin/bash
# Update system and install Apache
yum update -y
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create a simple HTML page showing instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
cat << EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>TechCorp Web Server</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 800px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; }
        .instance-id { background-color: #f5f5f5; padding: 10px; border-radius: 3px; font-family: monospace; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to TechCorp Web Application</h1>
        <p>This is served from web server instance:</p>
        <div class="instance-id">Instance ID: $INSTANCE_ID</div>
        <p>Availability Zone: $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        <hr>
        <p><em>Deployed via Terraform - Month 1 Assessment</em></p>
    </div>
</body>
</html>
EOF

# Set proper permissions
chmod 644 /var/www/html/index.html

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
