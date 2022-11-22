# Basic ML
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/rexhaif/basic-ml/Build?style=for-the-badge)
![GitHub](https://img.shields.io/github/license/rexhaif/basic-ml?style=for-the-badge)
![GitHub last commit](https://img.shields.io/github/last-commit/rexhaif/basic-ml?style=for-the-badge)

Base images with cuda support for varioud ML-related python workloads:
- Inference APIs
- Jupyter Environments
- Cluster Workers

---
## Structure
All images are divided into two categories:
1. Base images
    Provide basic image with python, tini, gpg and CUDA-drivers if applicable

    [![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/rexhaif/basic-ml/tags?page=1&name=base)
    
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cuda11.6-runtime?label=CUDA%20runtime&style=for-the-badge)
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cuda11.6-devel?label=CUDA%20DEVEL&style=for-the-badge)
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cuda11.6-cudnn8-devel?label=CUDNN%20DEVEL&style=for-the-badge)
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cuda11.6-cudnn8-runtime?label=CUDNN%20Runtime&style=for-the-badge)
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cuda11.6?label=CUDA%20Base%20%20%20&style=for-the-badge)
    ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/rexhaif/basic-ml/base-cpu?label=CPU%20Base&style=for-the-badge)

2. Target images
    Provide task-specific software and configuration

    2.1 Jupyter environments
        Image with pre-installed jupyter as well as multiple useful utilities. Jupyter Server is protected with password by default. You could either use default password or set your own via `docker run -e PASSWORD="..." ...`. Exposed port is 8888.

    [![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/rexhaif/basic-ml/tags?page=1&name=jupyter)
    2.2 SSH-accessible environemnts
        Image with pre-installed and configured openssh-server and a script, that populates the system with either authentication option: password, single public key or whole ~/.ssh/authroized_keys file
    [![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://hub.docker.com/r/rexhaif/basic-ml/tags?page=1&name=ssh)


--
## Quick Start:

To run those images you will need Docker or any other container platform. In case of gpu system - docker must be configured with nvidia-docker2. Example script to run container is below:
```bash
docker run \
    --gpus=all \
    --ipc=host \
    -p 8888:8888 \
    -v `pwd`/notebooks:/workspace/notebooks \
    -v `pwd`/data:/workspace/data \
    -d \
    --name basic-ml \
        rexhaif/basic-ml:jupyter-cuda11.6-cudnn8-devel
```

To run SSH-accessible container use this script:
```bash
docker run \
    --gpus=all \
    --ipc=host \
    -p 2222:22 \
    -e AUTHORIZED_KEYS="`cat ~/.ssh/authorized_keys`" \
    -e PUBLIC_KEY="ssh-ec25519 ..." \
    -e PASSWORD="the-password" \
    -v `pwd`/projects:/workspace/code \
    -v `pwd`/data:/workspace/data \
    -d \
    --name basic-ml \
        rexhaif/basic-ml:ssh-cuda11.6-cudnn8-devel
```
You can choose any suitable option to configure authentication, either with one of AUTHORIZED_KEYS / PUBLIC_KEY / PASSWORD, or with all of them simultaneously. Port 2222 from `-p 2222:22` can be changed to any port of your choice.
