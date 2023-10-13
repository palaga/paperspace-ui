# syntax = docker/dockerfile:1
FROM pytorch

#
# Ensure deb packages are cached
#
RUN rm -f /etc/apt/apt.conf.d/docker-clean \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-debs

#
# Install python
#
# TODO: probably not necessary
# RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
#     --mount=type=cache,target=/var/lib/apt,sharing=locked \
#     apt update \
#     && DEBIAN_FRONTEND=noninteractive apt install -yqq software-properties-common \
#     && add-apt-repository ppa:deadsnakes/ppa -y \
#     && apt update \
#     && DEBIAN_FRONTEND=noninteractive apt install -yqq \
#       python3-pip \
#       python${PYTHON_VERSION} \
#       python${PYTHON_VERSION}-dev \
#       python${PYTHON_VERSION}-venv \
#     && ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python3 \
#     && ln -s /usr/bin/python${PYTHON_VERSION} /usr/local/bin/python


#
# Install basic tools
#
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      build-essential \
      curl \
      ffmpeg \
      gcc \
      git \
      libboost-all-dev \
      libsm6 \
      libxext6 \
      make \
      openssh-client \
      pkg-config \
      unrar \
      unzip \
      zip

#
# Install xformers
#
RUN --mount=type=cache,target=/opt/conda/pkgs,sharing=locked \
    conda install -y xformers -c xformers

#
# Install jupyterlab
#
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    python3 -m pip install \
      jupyterlab==4.0.7
