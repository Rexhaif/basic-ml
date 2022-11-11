ARG BASE_IMAGE="rexhaif/basic-ml:base-cuda11.6-cudnn8-devel"
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="Daniil Larionov"
LABEL org.opencontainers.image.title="Basic ML - Jupyter container"

RUN apt update && \
    apt install --yes --no-install-recommends \
        jq \
        git \
        neovim \
        openssh-client \
        screen \
        bat \
        curl \
        aria2 \
        build-essential && \
    pip install -U \
        ipython \
        notebook \
        jupyterlab


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

RUN wget -O ~/install.sh --progress=dot:mega https://starship.rs/install.sh && \
    sh ~/install.sh -y && \
    echo 'eval "$(starship init bash)"' >> ~/.bashrc

ADD ./starship.toml /root/.config/starship.toml
RUN echo "termcapinfo xterm* ti@:te@" >> ~/.screenrc
RUN echo "alias cat='batcat --paging=never'" >> ~/.bashrc

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && echo 'export PATH="/root/.cargo/bin:$PATH"' >> ~/.bashrc
ENV PATH="/root/.cargo/bin:${PATH}"

RUN cargo install exa

RUN apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/* && \
    rm -rf  ~/install.sh
