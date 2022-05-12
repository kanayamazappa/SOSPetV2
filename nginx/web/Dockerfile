FROM nginx:latest
EXPOSE 80
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/web/nginx.conf /etc/nginx/conf.d/default.conf