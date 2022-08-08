# Example Docker app with secrets on Render

This is an example Node.js app in Docker, with an environment variable and a secret file, deployed on Render.

This is based on a guide for Node.js:
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/

The official Docker reference was also super helpful:
https://docs.docker.com/engine/reference/builder/

## How to deploy on Render

1. Make a copy of this repository in your GitHub account:  
https://github.com/jimthoburn/render-example-node-docker-secret-file/generate

2. Sign in to Render and create a new Blueprint using your repository URL:  
https://dashboard.render.com/select-repo?type=blueprint

3. Open the `render-example-node-docker-secret-file` service

4. Under the `Environment` tab, create a secret file named `.secret-env` with the following contents:
```
SECRET_PORT=5678
```

5. You can also change the `PUBLIC_PORT` to any value you wish

6. The service will automatically deploy with your changes to the environment

7. After the deployment is finished, the logs should show something like this, with the public and secret port numbers that you chose.
```
Hello from the Dockerfile 🐳
The value of the PUBLIC_PORT environment variable is: 80
Hello from the shell 🐚
The value of the SECRET_PORT environment variable is: 5678

> docker_web_app@1.0.0 start /usr/src/app
> node server.js

Running on http://0.0.0.0:80
Hello from the app 📦
The value of the SECRET_PORT environment variable is: 5678
```

## How to test locally

1. Rename `.secret-env.example` to `.secret-env`, and add a secret port number to the file
```
SECRET_PORT=5678
```

_You can also rename `.dockerignore.example` to `.dockerignore`, and add any [files you’d like to be ignored](https://docs.docker.com/engine/reference/builder/#dockerignore-file)._

2. Open a terminal and set an environment variable for `PUBLIC_PORT`
```
export PUBLIC_PORT=80
```

3. Uncomment these two lines in the `Dockerfile`:
```
ARG PUBLIC_PORT
ENV PUBLIC_PORT=$PUBLIC_PORT
```

4. Build the container (replace `<USERNAME>` with your favorite username)
```
DOCKER_BUILDKIT=1 \
docker build \
  --secret id=_secret_env,src=.secret-env \
  --build-arg PUBLIC_PORT \
  . \
  -t <USERNAME>/node-web-app
```

5. Run the container (replace `<USERNAME>` with the username you chose in step 4)
```
docker run \
  -p 4000:$PUBLIC_PORT \
  -d <USERNAME>/node-web-app
```

Note: You can replace `4000` with any port number you’d like.

6. Get the container ID
```
docker ps
```

7. Check the logs for your container (Replace `<CONTAINER_ID>` with what you found in the previous step)
```
docker logs <CONTAINER_ID>
```

8. Connect to your container’s shell. You can poke around in the files with `ls -al`, and exit the shell with `exit`
```
docker exec -it <CONTAINER_ID> /bin/bash
```

9. You can also visit the application in your web browser with the port number you chose in step 4

http://localhost:4000/

There’s no step 10! 🎉

Note that with this process `.secret-env` will be included in the image. So if you have an actual secret in the file, you may not want to share or publish your Docker image.
