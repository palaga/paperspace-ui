# syntax = docker/dockerfile:1
FROM base

#
# Clone Kohya_ss
#
ADD --keep-git-dir=true https://github.com/bmaltais/kohya_ss.git /opt/kohya_ss

# # Kohya requires python tk for some reason
# # TODO: Probably not necessary anymore
# RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
#     --mount=type=cache,target=/var/lib/apt,sharing=locked \
#     DEBIAN_FRONTEND=noninteractive apt install -yqq software-properties-common \
#     && add-apt-repository ppa:deadsnakes/ppa -y \
#     && apt update \
#     && DEBIAN_FRONTEND=noninteractive apt install -yqq \
#       python3.10-tk

#     && sed -i 's/python3-tk/python3.10-tk/g' setup.sh \

# Modify requirements_linux_docker.txt and setup.sh to make it work:
# - Use existing versions of xformers and accelerate when available
# - Skip python3-tk check, as we'll be using it headless
# - Force the `inDocker` check to `true`, to disable venv creation
# - Always use the requirements_linux_docker.txt file
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/kohya_ss \
    && sed -i 's/^xformers==.*/xformers/' requirements_linux_docker.txt \
    && sed -i 's/^accelerate==.*/accelerate/' requirements_linux_docker.txt \
    && sed -i 's/\[.*dpkg-query.*python3-tk.*\]/false \&\& &/' setup.sh \
    && sed -i 's/inDocker;/true;/' setup.sh \
    && sed -i 's/python.*requirements_.*\.txt/python3 -m pip install -r requirements_linux_docker.txt/' setup.sh \
    && printf '%s\n%s\n%s\n' ------------------------ "$(cat setup.sh)" ------------------------ \
    && bash -x setup.sh
