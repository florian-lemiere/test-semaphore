terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
}

provider "local" {}

variable "mon_mot" {
  description = "Mot à écrire dans le fichier"
  type        = string
  default     = "TOTO"
}

# 1. Créer un fichier temporaire
resource "local_file" "test_file" {
  filename = "/tmp/fichier_test.txt"
  content  = <<EOF
Bonjour, ceci est un test Terraform.
Mot : ${var.mon_mot}
EOF
}

# 2. Lire le contenu du fichier (affiché à l'apply)
data "local_file" "read_test_file" {
  filename = local_file.test_file.filename
  depends_on = [local_file.test_file]
}

# 3. Afficher le contenu du fichier
output "contenu_fichier_test" {
  value = data.local_file.read_test_file.content
}

# 4. Attendre 2 secondes (simulateur)
resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 2"
  }
  depends_on = [local_file.test_file]
}

