# Rasm bazasi sifatida eng yengil Node.js versiyasini tanlaymiz
FROM node:16-alpine  

# Ishchi katalogni yaratamiz
WORKDIR /app  

# Paketlar faylini (package.json va package-lock.json) konteynerga ko‘chiramiz
COPY package*.json ./  

# NPM orqali kerakli bog‘liqliklarni o‘rnatamiz
RUN npm install  

# Loyiha barcha fayllarini ko‘chiramiz
COPY . .  

# Portni ochamiz (Agar React bo‘lsa: 3000, Next.js bo‘lsa: 3001 yoki o‘zgartirilgan port)
EXPOSE 3000  

# Konteyner ishga tushirish buyrug‘ini belgilaymiz
CMD ["npm", "start"]
