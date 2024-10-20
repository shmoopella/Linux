FROM nginx
WORKDIR /etc/nginx
COPY ./nginx.conf .
# ENTRYPOINT /docker-entrypoint.sh "nginx" "-g" "daemon off;"
# RUN apt -y update && apt -y upgrade && apt -y install gcc && apt -y install spawn-fcgi && apt -y install libfcgi-dev
# WORKDIR /etc
# COPY ./server/hello.c .
# RUN gcc -Wall -Werror -Wextra hello.c -lfcgi