# Example Docker app with secrets on Render

This is example Node.js app in Docker, with an environment variable and a secret file, deployed on Render.

This is based on a guide for Node.js:
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/

Docker reference:
https://docs.docker.com/engine/reference/builder/

Docker build secrets and private npm packages:
https://www.alexandraulsh.com/2019/02/24/docker-build-secrets-and-npmrc/

## How to deploy on Render

Quick start:
https://render.com/deploy?repo=https://github.com/jimthoburn/render-example-node-docker-secret-file

Step-by-step:

1. Fork this repository (optional):
https://github.com/jimthoburn/render-example-node-docker-secret-file

2. Sign in to Render and create a new YAML group:
https://dashboard.render.com/select-repo?type=iac

3. Open the `render-example-node-docker-secret-file` service

4. Under the `Environment` tab, set an environment variable for `PUBLIC_PORT` with any value (For example: `80`).

5. Create a secret file named `.secret-env` with the following contents:
```
SECRET_PORT=5678
```

6. Choose `Manual Deploy > Deploy latest commit`

7. After the deployment is finished, the logs should show something like this, with the public and secret port numbers that you chose.
```
Running on http://0.0.0.0:1234
The value of the “SECRET_PORT” environment variable is: 5678
```

<img width="727" alt="log" src="https://user-images.githubusercontent.com/926616/119920784-bc5d7700-bf21-11eb-91eb-b15551ceeefe.png">


## How to test locally

1. Rename `.secret-env.example` to `.secret-env`, and add a secret port number to the file
```
SECRET_PORT=5678
```

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
DOCKER_BUILDKIT=1 docker build --secret id=_env,src=secrets/.env --build-arg PUBLIC_PORT . -t <USERNAME>/node-web-app
```

5. Run the container
```
docker run --mount type=volume,source=secrets,destination=/etc/secrets/ -p 4000:$PUBLIC_PORT -d <USERNAME>/node-web-app
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
