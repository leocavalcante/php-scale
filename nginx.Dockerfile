FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY index.php /var/www/html/index.php
