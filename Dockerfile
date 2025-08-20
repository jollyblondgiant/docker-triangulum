# Build stage for frontend
FROM node:18-alpine as frontend-builder
WORKDIR /app/sig-app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run vite-prod

# Build stage for backend
FROM clojure:temurin-17-tools-deps-alpine as backend-builder
WORKDIR /app/sig-app
COPY deps.edn .
RUN clojure -P #parse deps but don't execute
COPY . .
RUN clojure -M:production:server start -m prod -p 8080

# Runtime stage
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Install nginx
RUN apk add --no-cache nginx

# Copy built artifacts
COPY --from=frontend-builder /app/dist ./dist
COPY --from=backend-builder /app/target/app.jar ./app.jar

# Copy nginx configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/sites-available/sig-app.conf /etc/nginx/sites-available/sig-app.conf

# Create nginx site symlink
RUN ln -s /etc/nginx/sites-available/sig-app.conf /etc/nginx/sites-enabled/sig-app.conf && \
    rm -f /etc/nginx/sites-enabled/default

# Create startup script
COPY entrypoint.sh /app/sig-app.sh
RUN chmod +x /app/sig-app.sh

EXPOSE 8080

ENTRYPOINT ["/app/sig-app.sh"]
