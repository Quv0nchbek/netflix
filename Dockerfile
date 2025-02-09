# 1. Builder image'ini yaratish
FROM node:16.17.0-alpine as builder

# Ishchi katalogni o'rnatish
WORKDIR /app

# Tizimning kerakli fayllarini ko'chirish
COPY ./package.json ./yarn.lock ./

# Yarnni o'rnatish (versiyani aniqlash)
RUN yarn install --frozen-lockfile

# Ilovani barcha fayllar bilan ko'chirish
COPY . .

# API kalitini va boshqa o'zgaruvchilarni olish
ARG TMDB_V3_API_KEY
ENV VITE_APP_TMDB_V3_API_KEY=${TMDB_V3_API_KEY}
ENV VITE_APP_API_ENDPOINT_URL="https://api.themoviedb.org/3"

# Yaratish jarayonini bajarish
RUN yarn build

# 2. Nginx image'ini yaratish
FROM nginx:stable-alpine

# Nginx ishlash joyini sozlash
WORKDIR /usr/share/nginx/html

# Nginxning mavjud fayllarini o'chirish
RUN rm -rf ./*

# Builder image'idan dist fayllarini ko'chirish
COPY --from=builder /app/dist .

# 80-portni ochish
EXPOSE 80

# Nginxni ishga tushirish
ENTRYPOINT ["nginx", "-g", "daemon off;"]
