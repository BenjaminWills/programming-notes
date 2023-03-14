resource "local_file" "looper" {
  filename = var.name_list[count.index]
  content  = "hello"
  count    = length(var.name_list)
}