#!/bin/env sh
#
# ---------------------------------------------------------------------
# Docker startup script.
# ---------------------------------------------------------------------
#
# Make sure following directories exist
conda_envs_path=${HOME}/conda/envs
pycharm_config_path=${HOME}/.PyCharm
pycharm_java_config_path=${HOME}/.PyCharm.java
pycharm_projects_path=${HOME}/Documents/dev/python
for path in ${conda_envs_path} ${pycharm_config_path} ${pycharm_java_config_path} ${pycharm_projects_path} 
do
	if [ ! -d "${path}" ]
	then
		echo "${path} does not exist, creating it..."
		mkdir -p "${path}"
	fi
done

# Run docker
docker run --rm \
  -e DISPLAY=${DISPLAY} \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ${conda_envs_path}:/opt/conda/envs \
  -v ${pycharm_config_path}:/home/developer/.PyCharm \
  -v ${pycharm_java_config_path}:/home/developer/.java \
  -v ${pycharm_projects_path}:/home/developer/PycharmProjects \
  --name pycharm-miniconda3_$(date +'%Y%m%d-%H%M%S') \
  garinocyr/pycharm-miniconda3:latest
