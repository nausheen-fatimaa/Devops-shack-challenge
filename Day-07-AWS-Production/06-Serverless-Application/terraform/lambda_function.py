import os
import boto3
from decimal import Decimal

table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])

def lambda_handler(event, context):
    item = table.update_item(
        Key={"id": "requests"},
        UpdateExpression="ADD request_count :one",
        ExpressionAttributeValues={":one": Decimal(1)},
        ReturnValues="ALL_NEW",
    )["Attributes"]
    return {
        "statusCode": 200,
        "headers": {"content-type": "application/json"},
        "body": '{"message":"Hello from AWS serverless","request_count":%s}' % item["request_count"],
    }
