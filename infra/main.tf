locals {
  startup_script = file("../scripts/startup.sh")
}
resource "google_compute_instance" "server" {
    name = "terraria-server"
    machine_type = "e2-small"

    # Zone marked as optional in documentation but seems required
    zone = "europe-north2-a" 
    boot_disk {
      initialize_params {
        image = "ubuntu-os-cloud/ubuntu-2404-noble-amd64-v20250924"
      }
    }

    # Network tags?
    tags = ["https-server", "http-server"]

    network_interface {
        # What does this mean?
        network = "default" 
    }

    metadata = {
        startup-script = local.startup_script
    }
}