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

# Open a port for the application
EXPOSE $PUBLIC_PORT

# Make the secret file available for this command, and then start the application
CMD --mount=type=secret,id=_secret_env,dst=.secret-env /bin/bash -c 'sh start.sh'
