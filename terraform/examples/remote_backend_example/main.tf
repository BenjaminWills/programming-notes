resource "local_file" "test" {
    filename = "./test.txt"
    content = path.cwd
}