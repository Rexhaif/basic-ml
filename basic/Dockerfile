ARG BASE_IMAGE=nvidia/cuda:11.6.0-cudnn8-devel-ubuntu20.04
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="Daniil Larionov rexhaif.io@gmail.com"
LABEL org.opencontainers.image.title="Basic ML - base image"

SHELL ["/bin/bash", "-c"]

ENV PIP_ROOT_USER_ACTION=ignore

RUN ln -snf /usr/share/zoneinfo/Europe/Moscow /etc/localtime && echo "Europe/Moscow" > /etc/timezone

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv A4B469963BF863CC
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        software-properties-common \
        wget && \ 
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \ 
    apt-get install --yes --no-install-recommends \
        python3.10 \
        python3.10-dev \
        python3.10-distutils

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

RUN wget --progress=dot:mega https://bootstrap.pypa.io/get-pip.py && python ./get-pip.py

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc /tini.asc
RUN gpg --batch --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
 && gpg --batch --verify /tini.asc /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]