terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  cloud {
    organization = "quotermain_org"
    workspaces {
      name = "stage"
    }
  }
}

provider "yandex" {
  token     = var.YC_TOKEN
  cloud_id  = var.YC_CLOUD_ID
  folder_id = var.YC_FOLDER_ID
  zone      = "ru-central1-a"
}

# Переменные для инициализации ресурсов
variable "YC_TOKEN" {
  description = "Creds for YC Cloud"
  type        = string
  sensitive = true
}
variable "YC_CLOUD_ID" {
  description = "Creds for YC Cloud"
  type        = string
  sensitive = true
}
variable "YC_FOLDER_ID" {
  description = "Creds for YC Cloud"
  type        = string
  sensitive = true
}

# Сеть и подсеть
resource "yandex_vpc_network" "default" {
  name = "my-network"
}
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
