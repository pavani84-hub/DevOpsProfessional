FROM ubuntu:22.04

# Install Apache2
RUN apt-get update && apt-get install -y apache2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy website/application files into Apache root directory
COPY . /var/www/html/

# Apache listens on port 85 instead of 80
RUN sed -i 's/80/85/g' /etc/apache2/ports.conf && \
    sed -i 's/:80/:85/g' /etc/apache2/sites-enabled/000-default.conf

# Expose port 85
EXPOSE 85

# Start Apache in foreground
CMD ["apachectl", "-D", "FOREGROUND"]
