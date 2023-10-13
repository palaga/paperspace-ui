#
# Variables
#
variable "ACCOUNT" {
  default = "username"
}

variable "IMAGE_PREFIX" {
  default = "gradient-"
}

variable "PYTORCH" {
  default = "2.1.0"
}

variable "CUDA" {
  default = "12.1"
}

variable "CUDNN" {
  default = "8"
}

variable "BASE_IMAGE_TAG" {
  default = "${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-runtime"
}


#
# Targets
#
target "base" {
  dockerfile = "base/Dockerfile"

  contexts = {
    pytorch = "docker-image://pytorch/pytorch:${BASE_IMAGE_TAG}"
  }

  tags = ["docker.io/${ACCOUNT}/${IMAGE_PREFIX}base:latest"]
}

target "automatic1111" {
  dockerfile = "automatic1111/Dockerfile"

  contexts = {
    base = "target:base"
  }

  tags = ["docker.io/${ACCOUNT}/${IMAGE_PREFIX}automatic1111:latest"]
}

target "kohya_ss" {
  dockerfile = "kohya_ss/Dockerfile"

  contexts = {
    base = "target:base"
  }

  tags = ["docker.io/${ACCOUNT}/${IMAGE_PREFIX}kohya_ss:latest"]
}


#
# Groups
#
group "default" {
  targets = [
    "automatic1111",
    "kohya_ss"
  ]
}
