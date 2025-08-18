FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY sig-app.conf /etc/nginx/sites-enabled/default

# COPY html /path/to/webfiles