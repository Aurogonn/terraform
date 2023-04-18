resource "yandex_lb_network_load_balancer" "lb-test" {
  name = "lb-test"

  listener {
    name = "listener-docker-machine"
    port = 80
    target_port = 8501
    protocol = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.docker-machine.id

    healthcheck {
      name = "http"
      http_options {
        port = 8501
        path = "/"
      }
    }
  }
}

resource "yandex_lb_target_group" "docker-machine" {
  name = "docker-machine-target-group"

  target {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    address   = yandex_compute_instance.vm-test1.network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    address   = yandex_compute_instance.vm-test2.network_interface.0.ip_address
  }
}