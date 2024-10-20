#!/bin/sh

# 检查REMIX_INSTALL是否为true
if [ "$REMIX_INSTALL" = true ]; then
    # 使用 PM2 启动 Remix 应用，并传递 PORT 环境变量
    cd ${HOMEDIR}/${REMIX_NAME}
    pm2 start ecosystem.config.cjs
    pm2 save
fi

# 检查 OPENAI_EDGE_TTS_INSTALL是否为true
if [ "$OPENAI_EDGE_TTS_INSTALL" = true ]; then
    cd ${HOMEDIR}/edgeTTS-openai-api/src/api    
    # 先尝试删除已存在的实例
    pm2 delete openai-edge-tts 2>/dev/null || true
    # 启动新的实例
    pm2 start python --name openai-edge-tts -- ${HOMEDIR}/edgeTTS-openai-api/src/api/app/server.py
    pm2 save
fi

cd ${HOMEDIR}

# 列出所有运行的进程
pm2 list

# 只输出日志
pm2 logs --lines 50
