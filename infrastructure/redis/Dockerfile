FROM node:11-alpine

RUN mkdir -p /src

WORKDIR /src

COPY package.json /src

RUN npm install

COPY . ./src

EXPOSE 3002

CMD npm start