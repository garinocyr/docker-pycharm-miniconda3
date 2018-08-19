Docker image containing PyCharm Community Edition and Miniconda3
- https://www.jetbrains.com/pycharm/
- https://conda.io/miniconda.html

Based on https://github.com/rycus86/docker-pycharm

### Usage

```
docker run --rm \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ~/conda/envs:/opt/conda/envs \
  -v ~/.PyCharm:/home/developer/.PyCharm \
  -v ~/.PyCharm.java:/home/developer/.java \
  -v ~/PycharmProjects:/home/developer/PycharmProjects \
  --name pycharm-miniconda3_$(date +'%Y%m%d-%H%M%S') \
  garinocyr/pycharm-miniconda3:latest
```

### Notes

Make sure that:
- host user (who runs docker) uid/gid are the same as docker inner user ones (1000/1000) so as to avoid permission issues when mounting volumes 
- host user is allowed to connect to the host X server (you may have to run "xhost +local:all")

"The actual name can be anything - I used something random to be able to start multiple instances if needed."
