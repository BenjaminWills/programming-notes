- [How to use](#how-to-use)
- [General structure](#general-structure)
	- [Docker volumes](#docker-volumes)

# How to use

A docker compose is a composition of individual dockerfiles that you can run at once from a `root directory`, this can be done in a few ways.

- start and stop

```sh
docker-compose start
docker-compose stop
```

- pause and unpause

```sh
docker-compose pause
docker-compose unpause
```

- up and down

```sh
docker-compose up -d (for background running)
docker-compose down
```

`up` builds, recreates, starts and attatches the containers for a service.

- run from specific file

```sh
docker-compose -f docker-compose.yml up
```

# General structure

```yml
version: '3'

services:
	service_1:
		build:
			# build from dockerfile
			context: {path}
			dockerfile: {dockerfile name} | image: {image name}

		ports:
			- "host_port:container_port"

		volumes:
			# A volume is essentially a link between the hosts filesystem
			# and the docker container. This is useful for applications like
			# a database running in a docker container.
			- local_data_path:container_data_path

		environment:
			- env_variable=variable

		command: {shell command}

		entrypoint: {a command to run upon initialising the container}

		depends_on:
			# Will only run once the specified services have run
			- service:
				- condition: service_healthy

volumes:
	local_data_path:
		driver:local
```

- Alternatively to specifying a port, one could write `expose` to expose a port to a linked service.
- Instead of environment, you can load in a .env file with the `env_file` command.

## Docker volumes

Declaring volumes can come in three forms,

1. Initiating a docker container on the terminal and reference both directories (like a madman)

```sh
docker run \
-v host_data_path:container_data_path
```

2. Initiating a docker container on the terminal and only referencing the container volumes (`anonymous volume`)

```sh
docker run \
-v container_data_path
```

3. Initialising a docker container on the terminal using `named volumes` which simply names the directory to dump the data in.

```sh
docker run \
-v name:container_data_path
```

On mac the `docker volumes` path is:

```sh
/var/lib/docker/volumes
```
