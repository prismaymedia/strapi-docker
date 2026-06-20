FROM node:20-alpine

RUN apk add --no-cache libc6-compat tini

WORKDIR /app

COPY . /app/

ENV NODE_OPTIONS="--max-old-space-size=2048"

RUN npm install
RUN npm run build

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

EXPOSE 1337

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node", "./node_modules/@strapi/strapi/bin/strapi.js", "start"]
