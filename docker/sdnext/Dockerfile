# syntax = docker/dockerfile:1
FROM base


#
# Clone SDNext
#
ADD --keep-git-dir=true https://github.com/vladmandic/automatic.git /opt/sdnext


#
# Install requirements
#
RUN --mount=type=cache,target=/root/.cache/pip,sharing=locked \
    cd /opt/sdnext && \
    python3 -m pip install -r requirements.txt
