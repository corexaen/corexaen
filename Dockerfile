# ---- base ----
FROM node:20-alpine AS base
WORKDIR /app
ENV NODE_ENV=production

# ---- deps ----
FROM base AS deps
COPY package*.json ./
RUN npm ci --omit=dev

# ---- build (TS 쓰면 여기서 빌드) ----
FROM base AS build
COPY package*.json ./
RUN npm ci
COPY . .
# 예: TS라면 RUN npm run build

# ---- runtime ----
FROM base AS runtime
USER node
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY --from=build /app ./
EXPOSE 3000
CMD ["node", "index.js"]
