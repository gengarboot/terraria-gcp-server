locals {
  startup_script = file("../scripts/startup.sh")
}
resource "google_compute_instance" "server" {
    name = "terraria-server"
    # micro around 6$ monthly
    # small around 12$ monthly
    machine_type = "e2-micro"

    # Zone marked as optional in documentation but seems required
    zone = "europe-north2-a" 
    boot_disk {
      initialize_params {
        image = "ubuntu-minimal-2404-noble-amd64-v20250923a"
      }
    }

    # Network tags?
    # TODO - can probably remove these
    tags = ["https-server", "http-server"]

    network_interface {
        # What does this mean?
        network = "default" 

        access_config {
            # Here to give machine external ip to access internet? 
        }
    }

    metadata = {
        startup-script = local.startup_script
    }
}