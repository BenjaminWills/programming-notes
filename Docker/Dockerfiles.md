- [What is a dockerfile](#what-is-a-dockerfile)
- [Dockerfiles](#dockerfiles)

# What is a dockerfile

A dockerfile is a YAML file, that contains instructions to create a docker image. This saves us having to write them in the terminal every time that we want to. Futher we can go more in depth and create custom images if we so choose, or even build atop existing ones.

# Dockerfiles

General form:

```dockerfile
FROM image

RUN executable_command # Will execute a command

CMD executable_command # Default command to be run

EXPOSE port # informs runtime that the container listens on a specific port

ENV var # sets an environment variable

ADD path # copies files to container (bad version of copy)

COPY path # copies files to a container

ENTRYPOINT executable_command # will run upon build of the container, and will
							    override CMD statements

VOLUME dir_name # creates a volume in the container with name dir_name

USER name # sets a username for following run/cmd/entrypoint commands

WORKDIR path # sets the directory in which things happen by default in
		       the container

ARG var # defines a BUILD TIME variable

ONBUILD executable # provides a function when the image is used as the base
					 for another build

STOPSIGNAL signal # specifies the signal code that will be sent to the container
					to stop it from running

LABEL key=value # metadata for the image
```

- ENV variables can be specified in the dockerfile or in the docker compose from which they shall be built and run. They are referenced by name by writing `${env_var}`.
- We can add a .dockerignore that will ignore specific files from being copied into the image if required.
