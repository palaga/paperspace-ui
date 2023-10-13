# syntax = docker/dockerfile:1
FROM base

#
# Clone Automatic1111
#
ADD --keep-git-dir=true https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /opt/A1111

#
# Install requirements
#
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/A1111 && \
    python3 -m pip install -r requirements_versions.txt
