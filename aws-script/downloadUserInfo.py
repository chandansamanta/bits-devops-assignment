import boto3
import json 
def lambda_handler(event, context): 

    dynamodb = boto3.resource('dynamodb')  
    table = dynamodb.Table('user_content')
    response = table.scan()
    data = response['Items']
    return {
        'statusCode': 200,
        'body': json.dumps(data)
    }