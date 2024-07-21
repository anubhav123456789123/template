#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/animated.sh
printf "\n##############################################\n#                                            #\n#          Provisioning container            #\n#                                            #\n#         This will take some time           #\n#                                            #\n# Your container will be ready on completion #\n#                                            #\n##############################################\n\n"
function download() {
    wget -q --show-progress -e dotbytes="${3:-4M}" -O "$2" "$1"
}

## Set paths
nodes_dir=/opt/ComfyUI/custom_nodes
models_dir=/opt/ComfyUI/models
checkpoints_dir=${models_dir}/checkpoints
vae_dir=${models_dir}/vae
controlnet_dir=${models_dir}/controlnet
loras_dir=${models_dir}/loras
upscale_dir=${models_dir}/upscale_models

### Install custom nodes

# ComfyUI-Manager
this_node_dir=${nodes_dir}/ComfyUI-Manager
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/ltdrdata/ComfyUI-Manager $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI_IPAdapter_plus
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI-Crystools
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/crystian/ComfyUI-Crystools.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/rgthree-comfy
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/rgthree/rgthree-comfy.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI-Impact-Pack
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI-Inspire-Pack
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/ltdrdata/ComfyUI-Inspire-Pack.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUi_NNLatentUpscale
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Ttl/ComfyUi_NNLatentUpscale.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi


this_node_dir=${nodes_dir}/ComfyUI_UltimateSDUpscale
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/comfyui_controlnet_aux
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI_ADV_CLIP_emb
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/BlenderNeko/ComfyUI_ADV_CLIP_emb.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI-Advanced-ControlNet
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Kosinkadink/ComfyUI-Advanced-ControlNet.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI_essentials
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/cubiq/ComfyUI_essentials.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/ComfyUI_InstantID
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/cubiq/ComfyUI_InstantID.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/comfyui-reactor-node
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Gourieff/comfyui-reactor-node.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/img2txt-comfyui-nodes
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/christian-byrne/img2txt-comfyui-nodes.git $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

this_node_dir=${nodes_dir}/was-node-suite-comfyui
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git$this_node_dir
else
    (cd $this_node_dir && git pull)
fi



# ComfyUI-AnimateDiff-Evolved
this_node_dir=${nodes_dir}/ComfyUI-AnimateDiff-Evolved
if [[ ! -d $this_node_dir ]]; then
    git clone https://github.com/Kosinkadink/ComfyUI-AnimateDiff-Evolved $this_node_dir
else
    (cd $this_node_dir && git pull)
fi

animated_models_dir=${nodes_dir}/ComfyUI-AnimateDiff-Evolved/models

### Download checkpoints

## Animated
# mm_sd_v15
model_file=${animated_models_dir}/mm_sd_v15.ckpt
model_url=https://huggingface.co/guoyww/animatediff/resolve/main/mm_sd_v15.ckpt
if [[ ! -e ${model_file} ]]; then
    printf "mm_sd_v15.ckpt...\n"
    download ${model_url} ${model_file}
fi

## Standard
# v1-5-pruned-emaonly
model_file=${checkpoints_dir}/v1-5-pruned-emaonly.ckpt
model_url=https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt

if [[ ! -e ${model_file} ]]; then
    printf "Downloading Stable Diffusion 1.5...\n"
    download ${model_url} ${model_file}
fi

### Download controlnet

## example

model_file=${controlnet_dir}/control_canny-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_canny-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading Canny...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_depth-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_depth-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading Canny...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/diff_control_sd15_depth_fp16.safetensors
model_url=https://huggingface.co/kohya-ss/ControlNet-diff-modules/resolve/main/diff_control_sd15_depth_fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading diff_control_sd15_depth_fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_hed-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_hed-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_hed-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_mlsd-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_mlsd-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_mlsd-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_normal-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_normal-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_normal-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_openpose-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_openpose-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_openpose-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_scribble-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_scribble-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_scribble-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/control_seg-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/control_seg-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading control_seg-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_canny-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_canny-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_canny-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_color-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_color-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_color-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_depth-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_depth-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_depth-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_keypose-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_keypose-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_keypose-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_openpose-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_openpose-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_openpose-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_seg-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_seg-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_seg-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_sketch-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_sketch-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_sketch-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

model_file=${controlnet_dir}/t2iadapter_style-fp16.safetensors
model_url=https://huggingface.co/webui/ControlNet-modules-safetensors/resolve/main/t2iadapter_style-fp16.safetensors
if [[ ! -e ${model_file} ]]; then
   printf "Downloading t2iadapter_style-fp16.safetensors...\n"
   download ${model_url} ${model_file}
fi

### Download loras

## example

model_file=${loras_dir}/epi_noiseoffset2.safetensors
model_url=https://civitai.com/api/download/models/16576

if [[ ! -e ${model_file} ]]; then
   printf "Downloading epi_noiseoffset2 lora...\n"
   download ${model_url} ${model_file}
fi