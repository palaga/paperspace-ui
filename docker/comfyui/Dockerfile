# syntax = docker/dockerfile:1
FROM base


#
# Clone ComfyUI
#
ADD --keep-git-dir=true https://github.com/comfyanonymous/ComfyUI.git /opt/comfyui


#
# Install requirements
#
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/comfyui && \
    python3 -m pip install -r requirements.txt
