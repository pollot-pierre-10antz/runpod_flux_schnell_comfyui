#!/bin/bash
cd /ComfyUI/models/unet
wget https://huggingface.co/Comfy-Org/flux1-schnell/resolve/main/flux1-schnell-fp8.safetensors

cd ../clip
wget https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/clip_l.safetensors \
    https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp16.safetensors \
    https://huggingface.co/comfyanonymous/flux_text_encoders/resolve/main/t5xxl_fp8_e4m3fn.safetensors

cd ../vae
wget https://huggingface.co/black-forest-labs/FLUX.1-schnell/resolve/main/ae.safetensors


cd /ComfyUI
if [[ "$DEVICE" == "CPU" ]]; then
    echo "run on CPU"
    python main.py --cpu --listen --port $PORT
else
    python main.py --listen --port $PORT
fi