FROM runpod/pytorch:2.6.0-cuda12.4.0-devel-ubuntu22.04

RUN apt-get update && \
    apt-get install -y git wget curl ffmpeg libgl1 libglib2.0-0 python3 python3-pip python3-venv && \
    apt-get clean

RUN pip3 install --upgrade pip setuptools wheel

WORKDIR /workspace
RUN git clone https://github.com/comfyanonymous/ComfyUI.git /workspace/ComfyUI

RUN pip3 install -r /workspace/ComfyUI/requirements.txt
RUN pip3 install xformers==0.0.26.post1 --extra-index-url https://download.pytorch.org/whl/cu118

EXPOSE 8188

CMD ["python3", "/workspace/ComfyUI/main.py", "--listen", "--port", "8188", "--output-directory", "/workspace/output", "--input-directory", "/workspace/input"]