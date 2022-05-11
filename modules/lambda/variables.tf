variable bucket{
	type = string
	default = "urlshortnerlambdabucket"
}

variable lambda_role_name{
	type = string
	default = "url_shortner_lambda_role"
}
/*
variable lambda_role_doc{
	type = string
	default = "url_shortner_lambda_role_document"
}
*/
variable lambda_func_name{
	type = string
	default = "url_shortner_lambda"
}

variable lambda_handler{
	type = string
	default = "url_shortner_api.lambda_handler"
}

variable lambda_runtime{
	type = string
	default = "python3.8"
}