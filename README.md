# render-example-node-docker-secret-file

Based on the guide from:
https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
https://docs.docker.com/engine/reference/builder/

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

## How to test locally

1. Rename `.secret-env.example` to `.secret-env`, and a secret port number to the file
```
SECRET_PORT=5678
```

2. Open a terminal and set an environment variable for `PUBLIC_PORT`
```
export PUBLIC_PORT=80
```

3. Build your Docker container (replace <USERNAME> with your favorite username)
```
DOCKER_BUILDKIT=1 docker build --secret id=_secret_env,src=.secret-env --build-arg PUBLIC_PORT . -t <USERNAME>/node-web-app
```

4. Run container Docker container
```
docker run -p 49162:$PUBLIC_PORT -d jimthoburn/node-web-app
```

5. Get the container ID
```
docker ps
```

6. Check the logs for your container (Replace <CONTAINER_ID> with what you found with step 4)
```
docker logs <CONTAINER_ID>
```

7. Connect to your container’s shell
```
docker exec -it <CONTAINER_ID> /bin/bash
```

8. Exit the shell with `exit`
