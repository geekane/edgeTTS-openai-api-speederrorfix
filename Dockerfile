FROM nikolaik/python-nodejs:python3.10-nodejs20

ENV USER=pn \
    HOMEDIR=/home/pn \
    PORT=7860 \
    SSHX_INSTALL=true \
    OPENAI_EDGE_TTS_INSTALL=true

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    libpq-dev \
    neofetch \
    git \
    curl \
    vim \
    && rm -rf /var/lib/apt/lists/*

WORKDIR ${HOMEDIR}

# 复制文件
RUN git clone https://github.com/aigem/edgeTTS-openai-api.git ${HOMEDIR}

# 给所有 .sh 文件添加执行权限
RUN chmod +x ${HOMEDIR}/src/*.sh \
    && ls -la ${HOMEDIR}/src \
    && ls -la ${HOMEDIR}

# 运行 setup.sh、sshx.sh 和 remix.sh
RUN ${HOMEDIR}/src/setup.sh \
    && if [ "$SSHX_INSTALL" = true ]; then ${HOMEDIR}/src/sshx.sh; fi \
    && if [ "$OPENAI_EDGE_TTS_INSTALL" = true ]; then ${HOMEDIR}/src/openai-edge-tts.sh; fi

# 暴露 Remix 端口
EXPOSE ${PORT}

ENTRYPOINT ["/home/pn/src/startup.sh"]
