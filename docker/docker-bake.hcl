#
# Variables
#
variable "ACCOUNT" {
  default = "username"
}

variable "UBUNTU" {
  default = "22.04"
}

variable "CUDA" {
  default = "11.8.0"
}

variable "TORCH" {
  default = "118"
}

variable "CUDNN" {
  default = "cudnn8"
}

variable "BASE_IMAGE" {
  default = "nvidia/cuda"
}

variable "BASE_TAG" {
  default = "${CUDA}-${CUDNN}-runtime-ubuntu${UBUNTU}"
}

variable "A1111_BASE_IMAGE" {
  default = "${BASE_IMAGE}"
}

variable "A1111_BASE_TAG" {
  default = "${BASE_TAG}"
}

variable "SDNEXT_BASE_IMAGE" {
  default = "${BASE_IMAGE}"
}

variable "SDNEXT_BASE_TAG" {
  default = "${BASE_TAG}"
}

variable "COMFYUI_BASE_IMAGE" {
  default = "${BASE_IMAGE}"
}

variable "COMFYUI_BASE_TAG" {
  default = "${BASE_TAG}"
}

variable "KOHYA_SS_BASE_IMAGE" {
  default = "${BASE_IMAGE}"
}

variable "KOHYA_SS_BASE_TAG" {
  default = "${BASE_TAG}"
}


target "default" {
  name = "gradient-${item.app}"

  matrix = {
    item = [
      {
        app = "automatic1111"
        image = "${A1111_BASE_IMAGE}"
        tag = "${A1111_BASE_TAG}"
      }, {
        app = "comfyui"
        image = "${COMFYUI_BASE_IMAGE}"
        tag = "${COMFYUI_BASE_TAG}"
      }, {
        app = "kohya_ss"
        image = "${KOHYA_SS_BASE_IMAGE}"
        tag = "${KOHYA_SS_BASE_TAG}"
      }, {
        app = "sdnext"
        image = "${SDNEXT_BASE_IMAGE}"
        tag = "${SDNEXT_BASE_TAG}"
      }
    ]
  }

  args = {
    TORCH_VERSION = TORCH
  }

  dockerfile = "Dockerfile"
  target = item.app

  contexts = {
    cuda_img = "docker-image://${item.image}:${item.tag}"
  }

  tags = ["docker.io/${ACCOUNT}/gradient-${item.app}:${item.tag}"]
}
