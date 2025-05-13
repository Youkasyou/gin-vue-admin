# 前端构建阶段
FROM node:20-slim AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable
WORKDIR /app
COPY . /app

FROM base AS prod-deps
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod

FROM base AS build
COPY --from=prod-deps /app/node_modules /app/node_modules
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install && pnpm run build

# 最终部署阶段
FROM nginx:1.27-alpine
LABEL MAINTAINER="bypanghu@163.com"

# 拷贝 Nginx 配置
COPY --from=base /app/.docker-compose/nginx/conf.d/nginx.conf /etc/nginx/conf.d/default.conf

# 拷贝前端构建产物（注意不要加 /dist）
COPY --from=build /app/dist/ /usr/share/nginx/html/

# 可选：调试查看构建内容
RUN ls -al /usr/share/nginx/html
