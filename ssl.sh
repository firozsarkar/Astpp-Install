#!/bin/bash

# ===============================
# ASTPP Auto SSL Installer Script
# ===============================

# Check if domain argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 yourdomain.com"
  exit 1
fi

DOMAIN="$1"
EMAIL="admin@$DOMAIN"

echo "======================================"
echo " ASTPP Auto SSL Installer Starting "
echo " Domain: $DOMAIN"
echo " Email: $EMAIL"
echo "======================================"

# Update system
echo "[1/5] Updating system..."
sudo apt update -y

# Install certbot and webserver plugin
echo "[2/5] Installing Certbot..."
if command -v nginx >/dev/null 2>&1; then
  sudo apt install -y certbot python3-certbot-nginx
  WEBSERVER="nginx"
elif command -v apache2 >/dev/null 2>&1; then
  sudo apt install -y certbot python3-certbot-apache
  WEBSERVER="apache"
else
  echo "Error: Neither Nginx nor Apache found. Install one webserver first."
  exit 1
fi

echo "[3/5] Detected Webserver: $WEBSERVER"

# Run certbot auto SSL
echo "[4/5] Installing SSL for $DOMAIN..."
if [ "$WEBSERVER" = "nginx" ]; then
  sudo certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect
else
  sudo certbot --apache -d "$DOMAIN" --non-interactive --agree-tos -m "$EMAIL" --redirect
fi

# Check SSL status
echo "[5/5] SSL Installation Completed!"
sudo systemctl status certbot.timer --no-pager

echo "======================================"
echo " SSL for $DOMAIN is now active! "
echo " Access your site with https://$DOMAIN"
echo "======================================"
