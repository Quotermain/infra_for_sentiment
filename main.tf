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

# Виртуальные машины
resource "yandex_compute_instance" "nginx_proxy" {
  name = "nginx-proxy"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8m5ohveheh58p7ajhl"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    nat_ip_address = var.external_ip
    ip_address     = "192.168.10.10"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "app_level_balancer" {
  name = "app-level-balancer"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8m5ohveheh58p7ajhl"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    ip_address     = "192.168.10.20"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "sentiment_estimator" {
  name = "sentiment-estimator"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8m5ohveheh58p7ajhl"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    ip_address     = "192.168.10.21"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "elasticsearch" {
  name = "elasticsearch"
  resources {
    cores  = 8
    memory = 8
  }
  boot_disk {
    initialize_params {
      image_id = "fd8m5ohveheh58p7ajhl"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    ip_address     = "192.168.10.30"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "monitoring" {
  name = "monitoring"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8m5ohveheh58p7ajhl"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet-1.id
    nat            = true
    ip_address     = "192.168.10.40"
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
