FROM node:21.7.1-alpine3.19

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run test

EXPOSE 8000

CMD ["node", "app.js"]
