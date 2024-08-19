#
# Override these variables with environment variables
# e.g.
#
#   IMAGE_ROS_DISTRO=iron docker buildx bake
#
# or
#
#   export IMAGE_ROS_DISTRO=iron
#   docker buildx bake
#
variable "IMAGE_ROS_DISTRO" { default = "rolling" }
variable "IMAGE_GITHUB_REPO" { default = "apl-ocean-engineering/foxglove-bridge" }

group "default" {
  targets = ["foxglove-bridge"]
}

#
# All images can pull cache from the images published at Github
# or local storage (within the Buildkit image)
#
# ... and push cache to local storage
#
target "foxglove-bridge" {
  dockerfile = "Dockerfile"
  context = "."
  args = {
    ROS_DISTRO = "${IMAGE_ROS_DISTRO}"
  }
  tags = [
    "ghcr.io/${IMAGE_GITHUB_REPO}:${IMAGE_ROS_DISTRO}"
  ]
  cache_from =[
    "ghcr.io/${IMAGE_GITHUB_REPO}:${IMAGE_ROS_DISTRO}",
    "type=local,dest=.docker-cache"
  ]
  cache_to = [
    "type=local,dest=.docker-cache"
  ]
  platforms = ["linux/amd64"]
}
