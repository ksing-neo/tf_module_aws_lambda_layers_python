# Terraform Module: AWS Lambda Layer with Custom Python Libraries

This Terraform module deploys an AWS Lambda layer with specified Python libraries. It installs the libraries locally, packages them into a ZIP file, and uploads it to AWS as a Lambda layer. This setup allows you to easily manage Python dependencies in your Lambda functions.

## Features

- **Custom Python Libraries**: Specify any list of Python libraries to include in the Lambda layer.
- **Layer Versioning**: Use version triggers to control updates to the layer.
- **Flexible Compatible Runtimes**: Define the Lambda runtime environments compatible with your layer.

## Usage

To use this module, reference it in your Terraform configuration and specify the required variables.

```hcl
module "lambda_layer" {
  source              = "git::https://github.com/pumoxi/tf_module_aws_lambda_layers_python//terraform/"
  layer_name          = "custom_python_layer"
  region              = "us-east-1"
  python_libraries    = ["lxml", "requests"]
  compatible_runtimes = ["python3.8", "python3.9"]
  layer_version       = "1.0"
}

output "lambda_layer_arn" {
  value = module.lambda_layer.lambda_layer_arn
}
```

## Requirements

- **Terraform**: >=0.12
- **AWS Provider**: Ensure your AWS credentials are set up to allow Lambda layer creation.

## Deployment Instructions

1. **Initialize Terraform**: Run `terraform init` to set up the module and download providers.
2. **Apply the Configuration**: Run `terraform apply` to install libraries, package the layer, and deploy it to AWS.
3. **Use the Layer ARN**: Use the outputted `layer_arn` in your Lambda functions to include the deployed layer.

## Example

To deploy this module with default settings, run:

```bash
terraform init
terraform apply
```

This command will deploy an AWS Lambda layer named custom_python_layer with lxml installed, compatible with Python 3.8 and 3.9.

## Notes

- **Local Dependency Installation**: Dependencies are installed locally using `pip` and packaged into a ZIP archive. Ensure `pip` is installed and available in your environment.
- **Cleanup**: This module does not include an automatic cleanup step for local files. If desired, delete the `python` directory and `layer.zip` after deployment.