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

# Secret files can be accessed within a Dockerfile
# https://render.com/docs/docker-secrets
#
# RUN --mount=type=secret,id=_secret_env cat .secret-env

# Define a variable that can be passed in at build-time
# It will be available for use in this Dockerfile
#
# Environment variables that you set in the Render dashboard
# are automatically translated to Docker build args by Render:
# https://render.com/docs/docker
#
ARG PUBLIC_PORT

RUN echo "Hello from the Dockerfile 🐳" >> /usr/src/app/dockerfile-log.txt
RUN echo "The value of the PUBLIC_PORT environment variable is: $PUBLIC_PORT" >> /usr/src/app/dockerfile-log.txt

# Set an environment variable for the running application
#
# Environment variables that you set in the Render dashboard
# are automatically made available to your application:
# https://render.com/docs/configure-environment-variables
#
# But this line is useful for local testing:
#
ENV PUBLIC_PORT=$PUBLIC_PORT

# Open a port for the running application to listen on
EXPOSE $PUBLIC_PORT

# Start the application
CMD /bin/bash -c 'bash ./start.sh'
