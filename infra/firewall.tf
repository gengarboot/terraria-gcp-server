resource "google_compute_network" "terraria-vpc" {
  name = "terraria-vpc"
}

resource "google_compute_firewall" "terraria-firewall" {
    name = "terraria-firewall"
    network = google_compute_network.terraria-vpc.id
    target_tags = ["terraria"]

    allow {
        protocol = "icmp"
    }

    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    # For terraria server 
    allow {
        protocol = "tcp"
        ports = ["7777"]
    }

    allow {
        protocol = "udp"
        ports = ["7777"]
    }

    # Which IP's to allow
    source_ranges = [
        ""
    ]
}