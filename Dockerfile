
FROM clojure:temurin-17-tools-deps-alpine AS builder

ARG GIT_REPO
ARG GIT_BRANCH
ARG APP_NAME

RUN apk add --no-cache git nodejs npm
WORKDIR /app
RUN git clone $GIT_REPO --branch $GIT_BRANCH $APP_NAME

WORKDIR /app/sig-app
RUN npm install && npm run vite-prod
RUN clojure -P


FROM clojure:temurin-17-tools-deps-alpine

ARG APP_NAME
ARG APP_PORT
ARG APP_CMD

WORKDIR /app
COPY --from=builder /app/$APP_NAME/ ./
EXPOSE $APP_PORT
CMD ["sh", "-c", "${APP_CMD} -p ${APP_PORT}"]

