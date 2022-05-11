variable gateway_name{
	type = string
	default = "url_shortner_api_poc"
}

variable description {
	type = string
	default = "This is regional api gateway"
}

variable function_name {
	type = string
	default = "url_shortner_lambda"
}

variable gateway_type{
	type = string
	default = "REGIONAL"
}

variable invocation_role_name{
	type = string
	default = "apigw_invocation_role"
}

variable invocation_role_doc_name{
	type = string
	default = "apigw_invocation_role_document"
}

variable invocation_policy{
	type = string
	default = "apigw_invocation_policy"
}

variable invocation_policy_doc{
	type = string
	default = "apigw_invocation_policy_document"
}

variable aws_lambda_function_url_shortner_lambda_invoke_arn{
	type = string
}

variable path{
	type = string
	default = "short_url"
}

variable http_method{
	type = string
	default = "POST"
}

variable stage{
	type = string
	default = "poc"
}