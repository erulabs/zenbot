FROM node:latest

RUN mkdir -p /app
WORKDIR /app

COPY package.json /app/
RUN npm install -g node-gyp && npm install --unsafe-perm

COPY . /app
RUN ln -s /app/zenbot.sh /usr/local/bin/zenbot

COPY scripts ./scripts
RUN cd scripts/auto_backtester && yarn && yarn cache clean

ENV NODE_ENV production

ENTRYPOINT ["/usr/local/bin/node", "zenbot.js"]
CMD [ "trade", "--paper" ]
