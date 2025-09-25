resource "google_compute_instance" "server" {
    name = "terraria-server"
    machine_type = "e2-micro"
    
    # Zone marked as optional in documentation but seems required
    zone = "europe-north2-a" 
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-minimal-2504-plucky-amd64-v20250923"
      }
    }
    network_interface {
      
    }
}