terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.23.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "fastapi_tuto" {
  name = "fastapi_tuto"
  build {
    path = "."
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "app/*") : filesha1(f)]))
  }
}

resource "docker_container" "fastapi_tuto" {
  image = docker_image.fastapi_tuto.image_id
  name  = "fastapi_tuto"
  ports {
    internal = 80
    external = 8000
  }
}