FROM node:20-alpine

WORKDIR /app

COPY worker-v0.02.js /app/worker-v0.02.js

ENV NODE_ENV=production
ENV SFL_MARKET_WATCH_HOST=0.0.0.0
ENV SFL_MARKET_WATCH_PORT=8790
ENV SFL_MARKET_WATCH_DIR=/data/.state

CMD ["node", "/app/worker-v0.02.js"]
