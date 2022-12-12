terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "fastapi-tuto" {
  name = "fastapi-tuto"
  build {
    path = "."
  }
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(path.module, "app/*") : filesha1(f)]))
  }
}

resource "docker_container" "fastapi-tuto" {
  image = docker_image.fastapi-tuto
  name  = "fastapi-tuto"
  ports {
    internal = 80
    external = 8000
  }
}