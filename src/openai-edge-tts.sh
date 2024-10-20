#!/bin/sh
set -e

echo "开始安装 openai-edge-tts..."

# 检查 openai-edge-tts 文件夹是否存在
if [ ! -d "$HOMEDIR/edgeTTS-openai-api/src/api" ]; then
    echo "openai-edge-tts 文件夹不存在"
    exit 1
fi

# 进入 openai-edge-tts 文件夹并安装依赖
cd $HOMEDIR/edgeTTS-openai-api/src/api
pip install -r requirements.txt

# .env 文件
cp .env.example .env

# 替换 .env 文件中的 API_KEY
sed -i "s|API_KEY=your_api_key_here|API_KEY=$(cat /run/secrets/apikey)|g" $HOMEDIR/edgeTTS-openai-api/src/api/.env

echo "openai-edge-tts 安装完成"
