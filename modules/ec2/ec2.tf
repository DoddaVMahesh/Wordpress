resource "aws_instance" "wordpress" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]

  user_data = <<-EOF
              #!/bin/bash -v
              adduser -p "$(openssl passwd -6 $passwrd)" testuser
              sudo usermod -aG wheel testuser
              # Update packages
              sudo yum update -y

              # Install Apache, MySQL, and PHP
              sudo yum install httpd mariadb105-server.x86_64 mariadb105.x86_64 php8.1.x86_64 php8.1-mysqlnd.x86_64 php8.1-xml.x86_64 php8.1-xml.x86_64 -y

              # Start and enable services
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo systemctl start mariadb
              sudo systemctl enable mariadb
              sudo systemctl start php-fpm
              sudo systemctl enable php-fpm

              # Download WordPress
              cd /var/www/html
              wget https://wordpress.org/latest.tar.gz
              tar -xvf latest.tar.gz
              rm latest.tar.gz

              # Set permissions
              chmod 777 /var/www/html

              # Create MySQL database and user
              mysql -u root -e "CREATE DATABASE wordpress;"
              mysql -u root -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
              mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpressuser'@'localhost';"

              # Configure WordPress
              cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
              
              sed -i "s/database_name_here/wordpress/" /var/www/html/wordpress/wp-config.php
              sed -i "s/username_here/wordpressuser/" /var/www/html/wordpress/wp-config.php
              sed -i "s/password_here/password/" /var/www/html/wordpress/wp-config.php

              # Enable .htaccess
              sed -i "s/AllowOverride None/AllowOverride All/" /etc/httpd/conf/httpd.conf

              # Restart services
              sudo systemctl restart httpd
              sudo systemctl restart mariadb
              sudo systemctl restart php-fpm

            EOF
    

  tags = {
    Name = "WordPressInstance"
  }

  
}

output "instance_id" {
  value = aws_instance.wordpress.id
}

output "public_ip" {
  value = aws_instance.wordpress.public_ip
}
