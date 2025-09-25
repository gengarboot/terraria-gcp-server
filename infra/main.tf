resource "google_compute_instance" "server" {
    name = "terraria-server"
    machine_type = "e2-micro"
    zone = "Any"
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-minimal-2504-plucky-amd64-v20250923"
      }
    }
    network_interface {
      
    }
}