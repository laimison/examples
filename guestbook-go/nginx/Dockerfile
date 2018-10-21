FROM nginx
COPY html/* /usr/share/nginx/html/
COPY default.conf /etc/nginx/conf.d/default.conf

ENV APP_ROOT /usr/share/nginx/html
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT

# RUN apt-get update
# RUN apt-get update && apt-get install vim curl lsof tcpdump iputils-ping -y
