# Creating docker image of the pipeline

```bash
$ # build the image
$ docker_dir="/path/to/dockerfile/" # directory where the dockerfile is present
$ docker image build -t glannot:0.0.6 $docker_dir
$ tag glannot:0.0.6 ghcr.io/deeprob/glannot:latest
$ docker push ghcr.io/deeprob/glannot
```

**Note: It is assumed that docker is already installed and on path.**
