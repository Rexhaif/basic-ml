ARG BASE_IMAGE="rexhaif/basic-ml:base-cuda11.6-cudnn8-devel"
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="Daniil Larionov"
LABEL org.opencontainers.image.title="Basic ML - Jupyter container"

RUN apt update && apt install --yes --no-install-recommends jq git zsh && pip install -U ipython notebook jupyterlab

SHELL ["/bin/zsh", "-c"]

ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 18.12.1
RUN mkdir -p $NVM_DIR && wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

RUN jupyter notebook --generate-config && \
    pip install ipywidgets && \ 
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter labextension install @jupyter-widgets/jupyterlab-manager

RUN apt install -y bash && \
    chsh -s /bin/bash root && \
    wget -O ~/install.sh --progress=dot:mega https://starship.rs/install.sh && \
    sh ~/install.sh -y && \
    echo 'starship init fish | source' >> ~/.zshrc

RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/* && \
    rm -rf  ~/install.sh
