# block name, resource type, resource name
resource "local_file" "example"{
    filename = "./example.txt"
    content = path.cwd
}