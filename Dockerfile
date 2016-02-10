FROM node:5.6.0-slim

RUN mkdir -p /app/
WORKDIR /app

ADD package.json /app/
RUN npm install
ADD . /app/

RUN echo '{ "address": "0.0.0.0", "port": 3000 }' > socket-config.json \
 && npm run-script build \

 && npm install http-server -g \
 && apt-get update && apt-get install -y supervisor \
 && cp misc/supervisord.conf /etc/supervisor/conf.d/supervisord.conf \
 && cp -r web public \
 && rm -Rf public/script/

EXPOSE 80 3000

CMD ["/usr/bin/supervisord"]


