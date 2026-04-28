FROM node:20-alpine

WORKDIR /app

COPY worker-v0.02.js.gz.b64 /app/worker-v0.02.js.gz.b64
RUN base64 -d /app/worker-v0.02.js.gz.b64 | gunzip > /app/worker-v0.02.js \
  && rm /app/worker-v0.02.js.gz.b64

ENV NODE_ENV=production
ENV SFL_MARKET_WATCH_HOST=0.0.0.0
ENV SFL_MARKET_WATCH_PORT=8790
ENV SFL_MARKET_WATCH_DIR=/data/.state

CMD ["node", "/app/worker-v0.02.js"]
