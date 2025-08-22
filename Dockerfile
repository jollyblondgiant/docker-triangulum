
FROM node:18-alpine AS node
WORKDIR /app
ARG APP_SOURCE_PATH=../app/sig-app
COPY ${APP_SOURCE_PATH}/package*.json .
RUN npm install
COPY ${APP_SOURCE_PATH}/ ./
RUN npm run vite-prod

FROM clojure:temurin-17-tools-deps-alpine AS clojure
WORKDIR /app
ARG GIT_BRANCH=main
ARG APP_PORT=8080
ARG APP_SOURCE_PATH=../app/sig-app
COPY ${APP_SOURCE_PATH}/deps.edn ./
RUN clojure -P
COPY ${APP_SOURCE_PATH}/ ./
COPY --from=node /app/dist ./dist

FROM clojure:temurin-17-tools-deps-alpine
WORKDIR /app
COPY --from=clojure /app/ ./

ARG APP_PORT=8080
EXPOSE ${APP_PORT}

ARG APP_CMD=["clojure", "-M:production:server",  "start"]

CMD clojure -M:production:server start -p 8080

