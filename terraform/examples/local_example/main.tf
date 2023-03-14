# block name, [provider]_[resource type], resource name
resource "local_file" "example"{
    filename = var.example["filename"]
    content = "${random_pet.random-example.id}"
    file_permission = var.example["file_permission"]
}

resource "random_pet" "random-example" {
  prefix = var.random_example["prefix"]
  separator = var.random_example["separator"]
  length = var.random_example["length"]
}
