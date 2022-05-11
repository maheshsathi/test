provider "aws" {
	region = var.region
}

module "lambda" {
	source = "./modules/lambda"
}

module "apigateway" {
	source = "./modules/apigateway/"
	aws_lambda_function_url_shortner_lambda_invoke_arn = module.lambda.aws_lambda_function_url_shortner_lambda_invoke_arn
}