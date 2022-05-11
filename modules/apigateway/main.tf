// create api gateway REST
resource "aws_api_gateway_rest_api" "gateway" {
	name = var.gateway_name
	description = var.description
	
	endpoint_configuration {
		types = [var.gateway_type]
  }
}

// allow apigateway to invoke lambda function
resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.function_name
  principal     = "apigateway.amazonaws.com"

  // The /*/* portion grants access from any method on any resource
  // within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.gateway.execution_arn}/*/*"
}


// add resource /short_url
resource "aws_api_gateway_resource" "gateway_resource" {
  parent_id   = aws_api_gateway_rest_api.gateway.root_resource_id
  path_part   = var.path
  rest_api_id = aws_api_gateway_rest_api.gateway.id
}

// add method POST to the url api
resource "aws_api_gateway_method" "gateway_method" {
  authorization = "NONE"
  http_method   = var.http_method
  resource_id   = aws_api_gateway_resource.gateway_resource.id
  rest_api_id   = aws_api_gateway_rest_api.gateway.id
}

// integrate lambda to api gateway
resource "aws_api_gateway_integration" "gateway_integration" {
  http_method = aws_api_gateway_method.gateway_method.http_method
  resource_id = aws_api_gateway_resource.gateway_resource.id
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  type                    = "AWS_PROXY"
  integration_http_method     = aws_api_gateway_method.gateway_method.http_method
  uri                     = var.aws_lambda_function_url_shortner_lambda_invoke_arn
}

// api gateway deployment
resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.gateway.id
  
  depends_on = [
	aws_api_gateway_integration.gateway_integration
  ]

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.gateway_integration,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

// create stage named poc
resource "aws_api_gateway_stage" "gateway_stage" {
  deployment_id = aws_api_gateway_deployment.deployment.id
  rest_api_id   = aws_api_gateway_rest_api.gateway.id
  stage_name    = var.stage
}