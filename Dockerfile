FROM registry.cn-hangzhou.aliyuncs.com/yumtown_x/python:3.10-slim-bookworm AS base
LABEL authors="zfanswer"

WORKDIR /app
COPY . /app

# 修改apt源
RUN cp sources.list /etc/apt && mv /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.bak

# 安装系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# 安装python依赖
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install --no-cache-dir -r requirements.txt \
    && rm -rf /root/.cache/pip

CMD ["python", "app.py"]