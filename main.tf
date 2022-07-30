terraform {


  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "static-aws-site-bucket"
    key = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  alias = "acm_provider"
  region = "us-east-1"
}

module "s3-static-website" {
  source = "./Modules/s3-static-website"
  bucket_name = var.bucket_name
}

module "cloudfront" {
  source = "./Modules/Cloudfront"
  domain_name = module.s3-static-website.website_endpoint
  bucket_name = var.bucket_name
}

module "dynamodb" {
  source = "./Modules/dynamodb"
 
}

module "lambda" {
  source = "./Modules/lambda"
 
}

module "Apigateway" {
  source = "./Modules/Apigateway"
  lambda-arn = module.lambda.lambda_function_arn
  intergation-url = module.lambda.lambda_function_intergation
  lambda-arn2 = module.lambda.lambda_function_arn
 # source_arn = "${aws_apigatewayv2_api.lambda-api.execution_arn}/*/*"
}

