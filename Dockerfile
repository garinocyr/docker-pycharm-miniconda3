# docker build . -t garinocyr/pycharm-miniconda3:latest
# docker run --rm -it built_image_id /bin/bash (to inspect docker content at runtime)

FROM continuumio/miniconda3

LABEL maintainer "Cyrille Garino"

ARG conda_home=/opt/conda
ARG pycharm_source=https://download.jetbrains.com/python/pycharm-community-2018.2.1.tar.gz
ARG pycharm_home=/opt/pycharm
ARG pycharm_local_dir=.PyCharmCE2018.2
ARG developer_home=/home/developer

RUN useradd -ms /bin/bash developer

RUN conda update conda \
&& chown -R developer:developer $conda_home/envs

RUN apt-get update && apt-get install --no-install-recommends -y \
  python python-dev python-setuptools python-pip \
  python3 python3-dev python3-setuptools python3-pip \
  gcc git openssh-client \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir $pycharm_home

WORKDIR $pycharm_home

ADD $pycharm_source $pycharm_home/installer.tgz

RUN tar --strip-components=1 -xzf installer.tgz && rm installer.tgz

RUN /usr/bin/python2 $pycharm_home/helpers/pydev/setup_cython.py build_ext --inplace \
&& /usr/bin/python3 $pycharm_home/helpers/pydev/setup_cython.py build_ext --inplace

USER developer

ENV HOME $developer_home

RUN mkdir $developer_home/.PyCharm \
&& ln -sf $developer_home/.PyCharm $developer_home/$pycharm_local_dir

WORKDIR $developer_home 

CMD [ "sh", "-c", "/opt/pycharm/bin/pycharm.sh" ]
