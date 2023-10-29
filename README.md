# Introduction

**CAUTION**: This repository is still a Work in Progress!

This repository contains a [Paperspace
Gradient](https://www.paperspace.com/ "Paperspace") setup for some
popular Stable Diffusion apps, such as automatic1111 and kohya_ss.

Each app has its own, specialized docker image and jupyter
notebook. The notebooks contain all steps necessary to start the
respective apps.

# Run on Gradient

| App             | Link                                                                                                                                                                                                |
|-----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| *automatic1111* | [![Run on Gradient](https://assets.paperspace.io/img/gradient-badge.svg)](https://console.paperspace.com/github/palaga/paperspace-ui/blob/main/a1111.ipynb?container=palaga/gradient-automatic1111) |
| *kohya_ss*      | [![Run on Gradient](https://assets.paperspace.io/img/gradient-badge.svg)](https://console.paperspace.com/github/palaga/paperspace-ui/blob/main/kohya_ss.ipynb?container=palaga/gradient-kohya_ss)   |


# Building from source

## Building the images

This setup uses a docker bake file to build all images and push them
to docker hub.

```bash
    cd docker/
    sudo ACCOUNT=your-docker-account docker buildx bake --push
```

## Building the notebooks

Convert the orgmode files to jupyter notebooks.

```bash
    make
```

