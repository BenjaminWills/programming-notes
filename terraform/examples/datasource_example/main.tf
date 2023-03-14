resource "local_file" "new_file" {
  filename = "./test.txt"
  content  = data.local_file.local.content
}

# The data keyword implies that the file was NOT provisioned by terraform.
data "local_file" "local" {
  filename = "./newfile.txt"
}