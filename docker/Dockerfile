# syntax = docker/dockerfile:1
FROM cuda_img as cuda_base

RUN rm -f /etc/apt/apt.conf.d/docker-clean \
    echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-debs

# Update apt
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update

# Install dependencies
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    DEBIAN_FRONTEND=noninteractive apt-get install -yqq \
      build-essential \
      curl \
      ffmpeg \
      gcc \
      git \
      haproxy \
      libboost-all-dev \
      libsm6 \
      libxext6 \
      make \
      openssh-client \
      pkg-config \
      python3 \
      python3-pip \
      software-properties-common \
      unrar \
      unzip \
      zip

# Install jupyterlab and ipywidgets
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    python3 -m pip install \
      jupyterlab==4.0.7 \
      ipywidgets==8.1.1


#
# Automatic1111 image
#
FROM cuda_base as torch_base

ARG TORCH_VERSION

# Install torch
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    python3 -m pip install \
      torch \
      torchvision \
      torchaudio \
      --extra-index-url https://download.pytorch.org/whl/cu$TORCH_VERSION


#
# Automatic1111 image
#
FROM torch_base as automatic1111

# Clone automatic1111
ADD --keep-git-dir=true https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /opt/A1111

# Install recent version of git, necessary for the fetch --refetch flag
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    add-apt-repository ppa:git-core/ppa \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yqq git

# Install pip requirements and prepare the environment with the dirty
# hack below.
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/A1111 \
    && python3 -m pip install -r requirements_versions.txt \
    && python3 -m pip install rich \
    && python3 -c '__import__("sys").argv.extend(["--skip-torch-cuda-test"]);__import__("modules.launch_utils").launch_utils.prepare_environment()'



#
# Kohya_ss image
#
# Note: cuda_base is used, as it likes to install its own version of torch
FROM cuda_base as kohya_ss

# Clone Kohya_ss
ADD --keep-git-dir=true https://github.com/bmaltais/kohya_ss.git /opt/kohya_ss

# Modify requirements_linux_docker.txt and setup.sh to make it work:
# - Use existing versions of xformers and accelerate when available
# - Skip python3-tk check, as we'll be using it headless
# - Force the `inDocker` check to `true`, to disable venv creation
# - Always use the requirements_linux_docker.txt file
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/kohya_ss \
    # && sed -i 's/^xformers==.*/xformers/' requirements_linux_docker.txt \
    # && sed -i 's/^accelerate==.*/accelerate/' requirements_linux_docker.txt \
    # && cp requirements_linux_docker.txt requirements_linux.txt \
    && sed -i 's/\[.*dpkg-query.*python3-tk.*\]/false \&\& &/' setup.sh \
    # && sed -i 's/inDocker;/true;/' setup.sh \
    # && sed -i 's/python.*requirements_.*\.txt/python3 -m pip install -r requirements_linux_docker.txt/' setup.sh \
    # && printf '%s\n%s\n%s\n' ------------------------ "$(cat setup.sh)" ------------------------ \
    && bash -x setup.sh



#
# ComfyUI image
#
FROM torch_base as comfyui

# Clone ComfyUI
ADD --keep-git-dir=true https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui

# Clone plugins
ADD --keep-git-dir=true https://github.com/Fannovel16/comfyui_controlnet_aux /opt/comfyui/custom_nodes/comfyui_controlnet_aux
ADD --keep-git-dir=true https://github.com/Gourieff/comfyui-reactor-node /opt/comfyui/custom_nodes/comfyui-reactor-node
ADD --keep-git-dir=true https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved /opt/comfyui/custom_nodes/ComfyUI-AnimateDiff-Evolved
ADD --keep-git-dir=true https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite /opt/comfyui/custom_nodes/ComfyUI-VideoHelperSuite
ADD --keep-git-dir=true https://github.com/WASasquatch/was-node-suite-comfyui /opt/comfyui/custom_nodes/was-node-suite-comfyui
ADD --keep-git-dir=true https://github.com/civitai/civitai_comfy_nodes /opt/comfyui/custom_nodes/civitai_comfy_nodes
ADD --keep-git-dir=true https://github.com/coreyryanhanson/ComfyQR /opt/comfyui/custom_nodes/ComfyQR
ADD --keep-git-dir=true https://github.com/cubiq/ComfyUI_IPAdapter_plus /opt/comfyui/custom_nodes/ComfyUI_IPAdapter_plus
ADD --keep-git-dir=true https://github.com/ltdrdata/ComfyUI-Impact-Pack /opt/comfyui/custom_nodes/ComfyUI-Impact-Pack
ADD --keep-git-dir=true https://github.com/ltdrdata/ComfyUI-Manager /opt/comfyui/custom_nodes/ComfyUI-Manager

# Install requirements
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/comfyui && \
    python3 -m pip install -r requirements.txt

RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    sh -c 'for r in $(find /opt/comfyui/custom_nodes/ -name requirements.txt); do python3 -m pip install -r "$r"; done'

#
# SDNext image
#
FROM torch_base as sdnext

# Clone SDNext
ADD --keep-git-dir=true https://github.com/vladmandic/automatic.git /opt/sdnext


# Install requirements
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/sdnext && \
    python3 -m pip install -r requirements.txt
