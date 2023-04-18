terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = <oAuth token>
  cloud_id  = <ID облака>
  folder_id = <ID каталога>
  zone = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2004-lts"
}


resource "yandex_vpc_network" "network_terraform" {
  name = "net_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.15.0/24"]
}

output "lb_ip_address" {
  value = yandex_compute_instance.vm-test1.network_interface
}