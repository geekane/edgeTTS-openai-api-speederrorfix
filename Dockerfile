FROM nikolaik/python-nodejs:python3.10-nodejs20

# 添加 CACHEBUST 参数
ARG CACHEBUST=1

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

# 使用 CACHEBUST 参数来强制更新
RUN git clone https://github.com/aigem/edgeTTS-openai-api.git && echo "Cache bust: ${CACHEBUST}"

# 给所有 .sh 文件添加执行权限
RUN chmod +x ${HOMEDIR}/edgeTTS-openai-api/src/*.sh \
    && ls -la ${HOMEDIR}/edgeTTS-openai-api/src \
    && ls -la ${HOMEDIR}/edgeTTS-openai-api

# 运行 setup.sh、sshx.sh 和 remix.sh
RUN --mount=type=secret,id=apikey,mode=0444,required=true \
    ${HOMEDIR}/edgeTTS-openai-api/src/setup.sh \
    && if [ "$SSHX_INSTALL" = true ]; then ${HOMEDIR}/edgeTTS-openai-api/src/sshx.sh; fi \
    && if [ "$OPENAI_EDGE_TTS_INSTALL" = true ]; then ${HOMEDIR}/edgeTTS-openai-api/src/openai-edge-tts.sh; fi

# 暴露 Remix 端口
EXPOSE ${PORT}

ENTRYPOINT ["/home/pn/edgeTTS-openai-api/src/startup.sh"]
