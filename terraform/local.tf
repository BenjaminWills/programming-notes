# block name, resource type, resource name
resource "local_file" "example"{
    filename = "./example.txt"
    content = path.cwd
}

# This file will create a file in the PWD that contains the path to the PWD.