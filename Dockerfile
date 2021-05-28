# syntax = docker/dockerfile:1.2

FROM node:14

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

# https://render.com/docs/docker-secrets
# RUN --mount=type=secret,id=_secret_env,dst=/ephemeral/.filename cat /ephemeral/.filename

# Open a port for the application
EXPOSE $PUBLIC_PORT

# Start the application. (This will be overridden by the dockerCommand in render.yaml)
CMD [ "node", "server.js" ]
