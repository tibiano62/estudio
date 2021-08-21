# Aqui utilizaste un modulo externo para habilitar las APIS de la linea 29 y 30. Ahora la idea es que entres al proyecto y analices el modulo que usaste.
# https://github.com/terraform-google-modules/terraform-google-project-factory/blob/master/modules/project_services/main.tf 
module "project_services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "3.3.0"

  project_id = "estudio-terraform-322107"

  activate_apis = [
    "compute.googleapis.com",
    "oslogin.googleapis.com"
  ]

  disable_services_on_destroy = false
  disable_dependent_services  = false
}

# Estos 2 resources que utilizaste intenta transformalo en modulo, si no sabes como empezar me dices y te ayudo.
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["web", "dev"]
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }

  allow_stopping_for_update = true
}