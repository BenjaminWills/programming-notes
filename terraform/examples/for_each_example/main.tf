resource "local_file" "for_each" {
    filename = each.value
    content = each.key
    for_each = toset(var.name_list)
  
}