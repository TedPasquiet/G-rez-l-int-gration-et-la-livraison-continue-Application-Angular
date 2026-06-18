# Etape 1 on build

# LTS active, la plus récente et stable pour angular 20
FROM node:22-alpine AS build
WORKDIR /frontend
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Etape 2 on serve nginx
FROM nginx:1.27-alpine
COPY --from=build /frontend/dist/olympic-games-starter/browser /app
COPY nginx/nginx.conf /etc/nginx/nginx.conf
EXPOSE 80