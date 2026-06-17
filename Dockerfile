# Etape 1 on build

# LTS active, la plus récente et stable pour angular 20
FROM node:22-alpine AS build
WORKDIR /frontend
COPY package.json ./
RUN npm install
RUN npm ci
COPY . .
RUN npm i baseline-browser-mapping@latest -D
RUN npm run build

# Etape 2 on serve nginx
