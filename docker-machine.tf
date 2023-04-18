resource "yandex_compute_instance" "vm-test1" {
  name = "docker-machine"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}

resource "yandex_compute_instance" "vm-test2" {
  name = "docker-machine2"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
  
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}