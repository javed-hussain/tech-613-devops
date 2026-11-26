FROM node:20-alpine

WORKDIR /app

COPY app/ .

RUN npm ci --omit=dev

WORKDIR /app


USER node

EXPOSE 3000

CMD ["node", "index.js"]
