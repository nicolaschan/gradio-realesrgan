#!/usr/bin/env bash

wget https://github.com/xinntao/Real-ESRGAN/releases/download/v0.1.0/RealESRGAN_x4plus.pth -P weights
podman build -t gradio-realesrgan .

# Then run like:
# podman run -p 10003:7860 --gpus all -d localhost/gradio-realesrgan
