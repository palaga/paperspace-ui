# syntax = docker/dockerfile:1
FROM base


RUN mkdir -p /opt/A1111/repositories


#
# Clone Automatic1111
#
ADD --keep-git-dir=true https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /opt/A1111


#
# Install requirements
#

# Install pip requirements and prepare the environment with the dirty
# hack below.
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/A1111 \
    && python3 -m pip install -r requirements_versions.txt \
    && python3 -c '__import__("sys").argv.extend(["--skip-torch-cuda-test"]);__import__("modules.launch_utils").launch_utils.prepare_environment()'
