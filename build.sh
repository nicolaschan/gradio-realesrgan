#!/usr/bin/env bash

if [ ! -f weights/RealESRGAN_x4plus.pth ]; then
  wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P weights
fi
podman build -t gradio-realesrgan .

# Then run like:
# podman run -p 10003:7860 --gpus all -d localhost/gradio-realesrgan
