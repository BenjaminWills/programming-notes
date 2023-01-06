- [What is docker](#what-is-docker)
- [Docker commands](#docker-commands)
  - [Running containers](#running-containers)
  - [Manage containers](#manage-containers)
  - [Manage images](#manage-images)
  - [Info and stats](#info-and-stats)

REFERENCES:

- [[Docker compose]]
- [[Dockerfiles]]

# What is docker

Docker is an application that allows for the creation of `containers` that run applications, these containers are `virtual machines` meaning that they act like a machine even though they are just a partition of your pc. This is mega useful, as it allows us to create `images` that `containers` are built off of. For instance, you could run a whole application out of a cluster of `docker containers`, one for each element such as API, frontend, backend etc.

# Docker commands

## Running containers

Running a `container` from an `image`

```sh
docker run IMAGE \
--name container_name \
-p host:container \ # mapping a single port
-P \ # mapping all ports
-d \ # stands for detatched, runs containers in background, logs not sent to terminal
--hostname host_name \
--add-host host_name \ # adding a dns entry
-v host_dir:target_dir \ # adding volumes
--entrypoint executable.sh \ # upon building image into container run script
```

## Manage containers

- Listing containers

```sh
docker ps \ # shows a list of all RUNNING containers
-a # will show  a list of ALL containers
```

- Deleting containers

```sh
docker rm container_name
```

- Delete stopped containers

```sh
docker container prune
```

- Stopping and starting containers

```sh
docker stop|start container
```

- Copy a file from a container to the host

```sh
docker cp container:source target_dir
```

- Copy a file from the host to the container

```sh
docker cp target_dir container:source
```

- Start a shell inside of a running container

```sh
docker exec -it container executable
```

- Rename a container

```sh
docker rename old_name new_name
```

- Create an image out of a container

```sh
docker commit container
```

## Manage images

Note that a `tag` is optional, it is usually used to version/identify the images.

- Download an image

```sh
docker pull image:tag
```

- Upload an image to a repository

```sh
docker push image:tag
```

- Delete an image

```sh
docker rmi image:tag
```

- Show all images

```sh
docker images
```

- Delete dangling (untagged and unused) images

```sh
docker image prune
```

- Delete unused images

```sh
docker image prune -a
```

- Build an image from a `dockerfile`

```sh
docker build path_to_dockerfile
```

- Tag an image

```sh
docker tag image new_image
```

- Build and tag an image from a dockerfle

```sh
docker build -t image_name path_to_dockerfile
```

- Save an image to a file (preferably `.tar`)

```sh
docker save image > file
```

- load an image from a file

```sh
docker load -i file
```

## Info and stats

- Show logs of a container

```sh
docker logs container
```

- Show stats of running containers

```sh
docker stats
```

- Show processes of container

```sh
docker top container
```

- Show installed docker version

```sh
docker version
```

- Get detailed info about an object/image

```sh
docker inspect name
```

- Show all modified files of a container

```sh
docker diff container
```

- Show mapped ports of a container

```sh
docker port container
```
