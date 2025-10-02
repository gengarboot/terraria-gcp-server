resource "google_compute_network" "terraria-vpc" {
  name = "terraria-vpc"
}

resource "google_compute_firewall" "terraria-firewall" {
    name = "terraria-firewall"
    network = google_compute_network.terraria-vpc.id
    target_tags = ["terraria"]

    # Ping
    allow {
        protocol = "icmp"
    }

    # SSH
    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    # Terraria Server
    allow {
        protocol = "tcp"
        ports = ["7777"]
    }

    allow {
        protocol = "udp"
        ports = ["7777"]
    }

    # Which IP's to allow - replace 0.0.0.0/0 (allow all) with comma separated ip's 
    source_ranges = [
        "35.235.240.0/20", # GCP IAP range https://cloud.google.com/iap/docs/using-tcp-forwarding
        "0.0.0.0/0"
    ]
}