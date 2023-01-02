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
