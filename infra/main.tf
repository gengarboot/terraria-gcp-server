locals {
  startup_script = file("../scripts/startup.sh")
}

resource "google_compute_instance" "server" {
    name = "terraria-server"
    # micro around 6$ monthly
    # small around 12$ monthly
    machine_type = "e2-small"

    zone = "europe-north2-a" 
    boot_disk {
      initialize_params {
        image = "ubuntu-minimal-2404-noble-amd64-v20250923a"
      }
    }

    # Used for applying my custom firewall rules
    tags = ["terraria"]

    network_interface {
        network = google_compute_network.terraria-vpc.id
        
        # Here to give machine external ip
        access_config {}
    }

    metadata = {
        startup-script = local.startup_script
    }

    # RUNNING or TERMINATED
    desired_status = "TERMINATED"
}