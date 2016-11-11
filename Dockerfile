FROM mhart/alpine-node:6
MAINTAINER code.vire@gmail.com

RUN npm install -g yarn

COPY package.json /tmp
RUN cd /tmp &&\
    yarn &&\
    mkdir /app &&\
    mv node_modules /app/node_modules &&\
    rm package.json

WORKDIR /app
COPY . /app

ARG REACT_APP_BACKEND_URL # env variable to specify API URL durin build
ENV CONTAINER true # important for tests not run in watch mode

RUN yarn build
RUN yarn test
CMD ["yarn", "start:prod"]
