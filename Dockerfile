FROM runpod/pytorch:2.2.0-py3.10-cuda12.1.1-devel-ubuntu22.04


ARG DEVICE="GPU"
ARG COMFYUI_TAG="v0.1.3"
ARG COMFYUI_MANAGER_TAG="2.50.1"

ENV IP="0.0.0.0"
ENV PORT="7860"
ENV DEVICE=$DEVICE


WORKDIR /
COPY . .
RUN git clone --branch $COMFYUI_TAG https://github.com/comfyanonymous/ComfyUI
# change the default workflow
RUN mv index-CaD4RONs.js ComfyUI/web/assets/


WORKDIR /ComfyUI
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

WORKDIR /ComfyUI/custom_nodes
RUN git clone --branch $COMFYUI_MANAGER_TAG https://github.com/ltdrdata/ComfyUI-Manager.git


WORKDIR /
RUN chmod +x post_start.sh

EXPOSE ${PORT}

CMD [ "./start.sh" ]