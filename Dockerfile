FROM node:latest

ENV DEBIAN_FRONTEND noninteractive
ENV HUBOT_NAME hal-9000
ENV HUBOT_OWNER Gerhard Pegel
ENV HUBOT_DESCRIPTION Resistance is futile
ENV EXTERNAL_SCRIPTS "hubot-help,hubot-pugme,hubot-zabbix"
ENV HUBOT_ZABBIX_MIN_SEVERITY 1
ENV HUBOT_ZABBIX_USER hal-9000
ENV HUBOT_ZABBIX_ENDPOINT http://zabbix.gpegel.nl

RUN useradd hubot -m

RUN npm install -g hubot coffeescript yo generator-hubot

USER hubot

WORKDIR /home/hubot

COPY /scripts/* /home/hubot/scripts/
COPY external-scripts.json /home/hubot/
COPY package.json /home/hubot/

RUN npm install coffee-script --save
RUN yo hubot --owner="${HUBOT_OWNER}" --name="${HUBOT_NAME}" --description="${HUBOT_DESCRIPTION}" --defaults && sed -i /heroku/d ./external-scripts.json && sed -i /redis-brain/d ./external-scripts.json && npm install hubot-scripts && npm install hubot-slack --save

VOLUME ["/home/hubot/scripts"]

CMD bin/hubot -n $HUBOT_NAME --adapter slack
