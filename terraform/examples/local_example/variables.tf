variable "example" {
  type = map(string)
  default = {
    "filename"        = "./example.txt"
    "file_permission" = "0700"
  }
}

variable "random_example" {
  type = map(string)
  default = {
    "prefix"    = "Mr"
    "separator" = "."
    "length"    = "1"
  }
}