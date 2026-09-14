# =========================
# Stage 1: Build
# =========================

FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY build.js .
COPY src ./src

RUN npm run build


# =========================
# Stage 2: Production
# =========================

FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/server.js"]