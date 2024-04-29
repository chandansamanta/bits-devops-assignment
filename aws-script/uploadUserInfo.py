import uuid
import boto3
import json 
def lambda_handler(event, context): 

    dynamodb = boto3.resource('dynamodb')
    data = json.loads(event['body'])
    print(data)
    
    table = dynamodb.Table('user_content')
    table.put_item(
          Item = {
               'ID': str(uuid.uuid4()),
               'Name': data.Name,
               'Address': data.Address,
               'Mobile': data.Mobile,
          }
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Form saved successfully!')
    }