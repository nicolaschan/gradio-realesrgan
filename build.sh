#!/usr/bin/env bash

wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P weights
docker build -t gradio-realesrgan .
