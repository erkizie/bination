FROM node:13.12.0-alpine

RUN mkdir /frontend
WORKDIR /frontend

ENV PATH /frontend/node_modules/.bin:$PATH

COPY package.json ./
RUN npm install --silent

COPY . .

CMD ["npm", "start"]
