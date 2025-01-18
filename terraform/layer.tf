resource "null_resource" "install_libraries" {
  provisioner "local-exec" {
    command = <<EOT
      mkdir -p ./python
      python3 -m pip install ${join(" ", var.python_libraries)} -t ./python
    EOT
  }

  # Trigger installation when dependencies change
  triggers = {
    library_version = var.layer_version  # Change this if you update the dependency
  }
}

# Archive the files into a zip
data "archive_file" "lambda_layer_zip" {
  type        = "zip"
  source_dir  = "${path.root}/python"
  output_path = "${path.root}/layer.zip"

  depends_on = [null_resource.install_libraries]

}

# terraform for lambda layer

resource "aws_lambda_layer_version" "lambda_layer" {
    filename         = data.archive_file.lambda_layer_zip.output_path
    layer_name       = var.layer_name
    compatible_runtimes = var.compatible_runtimes

    depends_on = [null_resource.install_libraries]
}