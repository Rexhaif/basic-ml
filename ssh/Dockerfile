ARG BASE_IMAGE="rexhaif/basic-ml:base-cuda11.6-cudnn8-devel"
FROM ${BASE_IMAGE}

LABEL org.opencontainers.image.authors="Daniil Larionov"
LABEL org.opencontainers.image.title="Basic ML - SSH container"


RUN apt update && \
    apt install --yes --no-install-recommends \
        jq \
        git \
        neovim \
        openssh-client \
        openssh-server \
        screen \
        bat \
        curl \
        aria2 \
        htop \
        build-essential

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
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    rm -rf  ~/install.sh

RUN chsh -s /bin/bash root
ENV SHELL /bin/bash

EXPOSE 22
WORKDIR /root
RUN mkdir -p ./code && mkdir -p ./data
RUN mkdir -p /run/sshd

COPY ./run.sh /etc/ssh/run.sh
RUN chmod +x /etc/ssh/run.sh

CMD /etc/ssh/run.sh
