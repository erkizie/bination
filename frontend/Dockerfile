FROM node:13.12.0-alpine

ENV APP_ROOT /frontend
RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

COPY package.json ./
RUN npm install --silent

COPY . .

CMD ["npm", "start"]