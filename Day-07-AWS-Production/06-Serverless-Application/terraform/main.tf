data "aws_caller_identity" "current" {}
resource "aws_dynamodb_table" "counter" { name="${var.project_name}-counter" billing_mode="PAY_PER_REQUEST" hash_key="id" attribute {name="id" type="S"} point_in_time_recovery {enabled=true} }
resource "aws_iam_role" "lambda" { name="${var.project_name}-lambda" assume_role_policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Principal={Service="lambda.amazonaws.com"},Action="sts:AssumeRole"}]}) }
resource "aws_iam_role_policy_attachment" "basic" { role=aws_iam_role.lambda.name policy_arn="arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" }
resource "aws_iam_role_policy" "dynamo" { name="${var.project_name}-dynamo" role=aws_iam_role.lambda.id policy=jsonencode({Version="2012-10-17",Statement=[{Effect="Allow",Action=["dynamodb:GetItem","dynamodb:PutItem","dynamodb:UpdateItem"],Resource=aws_dynamodb_table.counter.arn}]}) }
resource "aws_cloudwatch_log_group" "lambda" { name="/aws/lambda/${var.project_name}" retention_in_days=14 }
resource "aws_lambda_function" "api" { function_name="${var.project_name}-api" role=aws_iam_role.lambda.arn runtime="python3.12" handler="lambda_function.lambda_handler" filename="${path.module}/lambda.zip" source_code_hash=filebase64sha256("${path.module}/lambda.zip") timeout=10 environment {variables={TABLE_NAME=aws_dynamodb_table.counter.name}} depends_on=[aws_iam_role_policy_attachment.basic] }
resource "aws_apigatewayv2_api" "http" { name="${var.project_name}-api" protocol_type="HTTP" }
resource "aws_apigatewayv2_integration" "lambda" { api_id=aws_apigatewayv2_api.http.id integration_type="AWS_PROXY" integration_uri=aws_lambda_function.api.invoke_arn payload_format_version="2.0" }
resource "aws_apigatewayv2_route" "root" { api_id=aws_apigatewayv2_api.http.id route_key="GET /" target="integrations/${aws_apigatewayv2_integration.lambda.id}" }
resource "aws_apigatewayv2_stage" "default" { api_id=aws_apigatewayv2_api.http.id name="$default" auto_deploy=true }
resource "aws_lambda_permission" "api" { statement_id="AllowHttpApiInvoke" action="lambda:InvokeFunction" function_name=aws_lambda_function.api.function_name principal="apigateway.amazonaws.com" source_arn="${aws_apigatewayv2_api.http.execution_arn}/*/*" }
