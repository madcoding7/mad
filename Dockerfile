FROM node:20-alpine

ENV NODE_ENV=production
ARG NPM_BUILD="npm install --omit=dev"
EXPOSE 8080/tcp

LABEL maintainer="Mercury Workshop"
LABEL summary="Scramjet Demo Image"
LABEL description="Example application of Scramjet"

WORKDIR /app

COPY ["package.json", "pnpm-lock.yaml", "./"]
# Install system dependencies
RUN apk add --upgrade --no-cache python3 py3-pip make g++

# Force install the wisp-python package
RUN python3 -m pip install --break-system-packages wisp-python
RUN $NPM_BUILD

COPY . .

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
