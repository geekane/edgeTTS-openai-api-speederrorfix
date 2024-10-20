# OpenAI 通用的微软 Edge TTS API

这个项目提供了一个基于微软 Edge TTS 的 OpenAI TTS API 替代品。它允许用户通过 API 调用将文本转换为语音,支持多种语音和音频格式。

## 功能特点

- 兼容 OpenAI TTS API 的接口
- 支持多种语音和语言
- 可调节语音速度
- 支持多种音频输出格式(mp3, opus, aac, flac, wav, pcm)
- 提供模型和可用语音列表的 API 端点
- 可选的 API 密钥认证
- Huggingface 支持,便于部署

## 安装

### 方法 1: 
打开 Huggingface 页面，点击 `复制空间` 按钮，直接部署。

[Huggingface 部署链接](https://huggingface.co/spaces/fuliai/edgetts-api-openai)

最简单的方法。

### 方法 2: 复制Dockerfile文件内容，在Huggingface上新建空间后，新建Dockerfile文件，粘贴内容,保存就`部署`了。

### 方法 3: 本地安装

1. 克隆仓库:
bash
git clone https://github.com/aigem/edgeTTS-openai-api.git
cd edgeTTS-openai-api/src/api


2. 安装依赖:

bash
pip install -r requirements.txt

3. 配置环境变量:

复制 `.env.example` 文件为 `.env`,并根据需要修改其中的设置:
bash
cp .env.example .env

2. 服务器将在 http://localhost:PORT 上运行(具体查看 .env 文件)

## 使用 API:

   - 文本转语音: POST `/v1/audio/speech`
   - 获取可用模型列表: GET/POST `/v1/models`
   - 获取可用语音列表: GET/POST `/v1/voices`
   - 获取所有可用语音: GET/POST `/v1/voices/all`

### API 使用示例

#### 文本转语音

bash:README.md
curl http://localhost:5050/v1/audio/speech \
-H "Authorization: Bearer your_api_key_here" \
-H "Content-Type: application/json" \
-d '{
"model": "tts-1",
"input": "Hello, world!",
"voice": "alloy",
"response_format": "mp3",
"speed": 1.0
}' \
--output speech.mp3


#### 获取可用模型列表
bash
curl http://localhost:5050/v1/models \
-H "Authorization: Bearer your_api_key_here"

## 环境变量

- `API_KEY`: API 密钥(默认: 'your_api_key_here')
- `PORT`: 服务器端口(默认: 5050)
- `DEFAULT_VOICE`: 默认语音(默认: 'en-US-AndrewNeural')
- `DEFAULT_RESPONSE_FORMAT`: 默认音频格式(默认: 'mp3')
- `DEFAULT_SPEED`: 默认语音速度(默认: 1.0)
- `DEFAULT_LANGUAGE`: 默认语言(默认: 'en-US')
- `REQUIRE_API_KEY`: 是否要求 API 密钥认证(默认: true)

## 贡献

欢迎提交问题报告和拉取请求。对于重大更改,请先开issue讨论您想要改变的内容。

## 许可证

[MIT](https://choosealicense.com/licenses/mit/)

## 相关链接

- [视频教程](https://www.youtube.com/@all.ai.)
- [项目 GitHub 仓库](https://github.com/aigem/edgeTTS-openai-api)
