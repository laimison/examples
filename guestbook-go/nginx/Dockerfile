FROM nginx
COPY html/* /usr/share/nginx/html/

ENV APP_ROOT /usr/share/nginx/html
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
