# Build l'application
## Image de base
FROM node:26-alpine AS build

## Définir un répertoire de travail
WORKDIR /app

## Installer les dépendences
COPY package*.json .
RUN npm ci

## Copier le code et build
COPY . .
RUN npm run build


# Serveur Nginx
## Image de base
FROM nginx:alpine AS Nginx

## Cleanup
RUN rm -rf /usr/share/nginx/html/*

## Copier le resultat du build (et ...)
COPY --from=build /app/dist /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

## Documentation du port exposé
EXPOSE 10000