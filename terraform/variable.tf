variable "layer_name" {
    description = "Name of the Layer"
    type = string
}

variable "region" {
    description = "The AWS Region to deploy resources"
    type = string
}

variable "python_libraries" {
  type        = list(string)
  description = "List of Python libraries to include in the Lambda layer"
}

variable "compatible_runtimes" {
    type = list(string)
    description = "Compatible runtimes for the layer"
}

variable "layer_version" {
    description = "Version of the layer"
    type = string
}