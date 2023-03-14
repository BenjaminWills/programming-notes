resource "local_file" "new_file" {
  filename = "./test.txt"
  content  = data.local_file.local.content
}

data "local_file" "local" {
  filename = "./newfile.txt"
}