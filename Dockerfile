# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail RES4LYF --mode remote
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.2.8
RUN git clone https://github.com/beautyaiRGS/comfyui-beautyai.git /comfyui/custom_nodes/comfyui-beautyai

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b.safetensors --relative-path models/clip --filename qwen_2.5_vl_7b.safetensors
RUN comfy model download --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/resolve/main/v20/Qwen-Rapid-AIO-NSFW-v20.safetensors --relative-path models/checkpoints --filename Qwen-Rapid-AIO-NSFW-v20.safetensors
# RUN # Could not find URL for Qwen/qwen_2509_Unchained-XXX.safetensors
RUN comfy model download --url https://huggingface.co/beautyaiclub/qwen_2509_Unchained-XXX.safetensors/resolve/main/qwen_2509_Unchained-XXX.safetensors --relative-path models/loras/Qwen --filename qwen_2509_Unchained-XXX.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
