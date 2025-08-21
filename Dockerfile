ARG APP_CMD="clojure -M:production:server start -m prod"
ARG APP_PORT=8080
ARG APP_SOURCE_PATH=../app/my-app

FROM clojure:temurin-17-tools-deps-alpine as builder

WORKDIR /app

# Copy application code
COPY ${APP_SOURCE_PATH} .

# Install dependencies and build
RUN clojure -P && \
    npm install && \
    npm run vite-prod

# Runtime stage
FROM clojure:temurin-17-tools-deps-alpine

WORKDIR /app

# Copy built app
COPY --from=builder /app/ .

EXPOSE ${APP_PORT}

CMD ${APP_CMD} -p ${APP_PORT}


