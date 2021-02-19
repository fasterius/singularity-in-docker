# Singularity-in-Docker

This repository stores a simple setup for getting Singularity inside a Docker
image. The main use-case for this is when you have Docker on your local computer
but want to run an image on a computer cluster (such as Uppmax), for example Mac
users. This setup should only be used for *building* Singularity images, *not*
running them!

## Setup

The first thing you need to do is to create the Docker image containing
Singularity:

```bash
docker build -f Dockerfile -t singularity-in-docker .
```

### Building from Docker images

The main use-case here is building a Singularity image from a local Docker
image. Start by creating your Dockerfile and building your image, just like you
normally would. You then need to save your image to a tarball:

```bash
docker save <IMAGE ID> docker.tar
```

The `<IMAGE ID>` *must* be the exact ID that you see when you list your images
with `docker image ls`, you cannot use *e.g.* `ubuntu:latest` or similar
`repository:tag` pairs. You can now mount and build your Singularity image from
the saved tarball:

```bash
docker run -v $(pwd):/work singularity-in-docker \
    build my-image.sif docker-archive://docker.tar
```

### Building from definition files

You can also build images from Singularity definitions files like normal:

```bash
docker run --privileged -v $(pwd):/work singularity-in-docker \
    build my-image.sif my-image.def
```

## Troubleshooting

If you run into a `wget: unable to resolve host address 'github.com'` error on
Mac OSX, try updating your Docker installation.
